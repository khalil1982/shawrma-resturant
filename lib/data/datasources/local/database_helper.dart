import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../../../core/constants/database_constants.dart';
import '../../../core/utils/date_utils.dart';

/// Database helper class for managing SQLite database
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create Users table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableUsers} (
        id TEXT PRIMARY KEY,
        username TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        full_name TEXT NOT NULL,
        role TEXT NOT NULL CHECK(role IN ('owner', 'cashier', 'kitchen')),
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create Shifts table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableShifts} (
        id TEXT PRIMARY KEY,
        shift_type TEXT NOT NULL CHECK(shift_type IN ('morning', 'evening')),
        shift_date TEXT NOT NULL,
        opened_by_user_id TEXT NOT NULL,
        opened_at TEXT NOT NULL,
        opening_cash REAL NOT NULL DEFAULT 0,
        opening_cash_adjustment REAL DEFAULT 0,
        opening_cash_adjustment_reason TEXT,
        opening_cash_adjusted_by_user_id TEXT,
        closed_by_user_id TEXT,
        closed_at TEXT,
        expected_closing_cash REAL DEFAULT 0,
        actual_closing_cash REAL DEFAULT 0,
        cash_variance REAL DEFAULT 0,
        cash_variance_reason TEXT,
        total_sales REAL DEFAULT 0,
        total_orders INTEGER DEFAULT 0,
        cancelled_orders INTEGER DEFAULT 0,
        status TEXT NOT NULL DEFAULT 'active' CHECK(status IN ('active', 'closed')),
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (opened_by_user_id) REFERENCES ${DatabaseConstants.tableUsers}(id),
        FOREIGN KEY (closed_by_user_id) REFERENCES ${DatabaseConstants.tableUsers}(id),
        FOREIGN KEY (opening_cash_adjusted_by_user_id) REFERENCES ${DatabaseConstants.tableUsers}(id)
      )
    ''');

    // Create Menu Items table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableMenuItems} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        category TEXT,
        is_active INTEGER DEFAULT 1,
        display_order INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // Create Orders table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableOrders} (
        id TEXT PRIMARY KEY,
        order_number TEXT NOT NULL UNIQUE,
        shift_id TEXT NOT NULL,
        order_type TEXT NOT NULL CHECK(order_type IN ('dine_in', 'takeaway')),
        customer_count INTEGER DEFAULT 1,
        status TEXT NOT NULL DEFAULT 'pending'
          CHECK(status IN ('pending', 'preparing', 'ready', 'delivered', 'cancelled')),
        subtotal REAL NOT NULL DEFAULT 0,
        discount_amount REAL DEFAULT 0,
        total_amount REAL NOT NULL DEFAULT 0,
        payment_method TEXT DEFAULT 'cash',
        amount_paid REAL DEFAULT 0,
        change_amount REAL DEFAULT 0,
        notes TEXT,
        created_by_user_id TEXT NOT NULL,
        created_at TEXT NOT NULL,
        completed_by_user_id TEXT,
        completed_at TEXT,
        cancelled_by_user_id TEXT,
        cancelled_at TEXT,
        cancellation_reason TEXT,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (shift_id) REFERENCES ${DatabaseConstants.tableShifts}(id),
        FOREIGN KEY (created_by_user_id) REFERENCES ${DatabaseConstants.tableUsers}(id),
        FOREIGN KEY (completed_by_user_id) REFERENCES ${DatabaseConstants.tableUsers}(id),
        FOREIGN KEY (cancelled_by_user_id) REFERENCES ${DatabaseConstants.tableUsers}(id)
      )
    ''');

    // Create Order Items table
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.tableOrderItems} (
        id TEXT PRIMARY KEY,
        order_id TEXT NOT NULL,
        menu_item_id TEXT NOT NULL,
        item_name TEXT NOT NULL,
        item_price REAL NOT NULL,
        quantity INTEGER NOT NULL DEFAULT 1,
        subtotal REAL NOT NULL,
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (order_id) REFERENCES ${DatabaseConstants.tableOrders}(id) ON DELETE CASCADE,
        FOREIGN KEY (menu_item_id) REFERENCES ${DatabaseConstants.tableMenuItems}(id)
      )
    ''');

    // Create indexes
    await db.execute(
      'CREATE INDEX idx_shifts_date ON ${DatabaseConstants.tableShifts}(shift_date)',
    );
    await db.execute(
      'CREATE INDEX idx_shifts_status ON ${DatabaseConstants.tableShifts}(status)',
    );
    await db.execute(
      'CREATE INDEX idx_orders_shift ON ${DatabaseConstants.tableOrders}(shift_id)',
    );
    await db.execute(
      'CREATE INDEX idx_orders_status ON ${DatabaseConstants.tableOrders}(status)',
    );
    await db.execute(
      'CREATE INDEX idx_orders_created_at ON ${DatabaseConstants.tableOrders}(created_at)',
    );
    await db.execute(
      'CREATE INDEX idx_order_items_order ON ${DatabaseConstants.tableOrderItems}(order_id)',
    );

    // Insert initial data
    await _insertInitialData(db);
  }

  Future<void> _insertInitialData(Database db) async {
    final now = AppDateUtils.toDbFormat(DateTime.now());

    // Hash passwords
    final adminPasswordHash = _hashPassword('admin123');
    final cashierPasswordHash = _hashPassword('cashier123');

    // Insert default users
    await db.insert(DatabaseConstants.tableUsers, {
      'id': 'user_owner_001',
      'username': 'admin',
      'password_hash': adminPasswordHash,
      'full_name': 'المالك',
      'role': DatabaseConstants.roleOwner,
      'is_active': 1,
      'created_at': now,
      'updated_at': now,
    });

    await db.insert(DatabaseConstants.tableUsers, {
      'id': 'user_cashier_001',
      'username': 'cashier',
      'password_hash': cashierPasswordHash,
      'full_name': 'الكاشير',
      'role': DatabaseConstants.roleCashier,
      'is_active': 1,
      'created_at': now,
      'updated_at': now,
    });

    // Insert static menu items
    final menuItems = [
      {'name': 'Beta', 'price': 15.00, 'category': 'shawarma'},
      {'name': 'Regular', 'price': 20.00, 'category': 'shawarma'},
      {'name': 'Double Regular', 'price': 25.00, 'category': 'shawarma'},
      {'name': 'Double Double', 'price': 30.00, 'category': 'shawarma'},
      {'name': 'Double Meat', 'price': 30.00, 'category': 'shawarma'},
      {'name': 'Rocket', 'price': 35.00, 'category': 'shawarma'},
      {'name': 'Syrian', 'price': 35.00, 'category': 'shawarma'},
      {'name': 'Sfiha', 'price': 45.00, 'category': 'appetizers'},
      {'name': 'Cheese Bracelets', 'price': 45.00, 'category': 'appetizers'},
      {'name': 'PUBG', 'price': 45.00, 'category': 'special'},
      {'name': 'Shawarma Kilo', 'price': 120.00, 'category': 'bulk'},
    ];

    for (var i = 0; i < menuItems.length; i++) {
      await db.insert(DatabaseConstants.tableMenuItems, {
        'id': 'item_${(i + 1).toString().padLeft(3, '0')}',
        'name': menuItems[i]['name'],
        'price': menuItems[i]['price'],
        'category': menuItems[i]['category'],
        'is_active': 1,
        'display_order': i + 1,
        'created_at': now,
        'updated_at': now,
      });
    }
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Hash password for authentication
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Close database connection
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
