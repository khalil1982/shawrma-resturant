import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/utils/encryption_helper.dart';

/// مساعد قاعدة البيانات - Singleton
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  /// الحصول على قاعدة البيانات
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// تهيئة قاعدة البيانات
  Future<Database> _initDatabase() async {
    try {
      // تهيئة FFI للديسكتوب
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      // الحصول على مسار قاعدة البيانات
      final directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, AppConstants.databaseName);

      AppLogger.info('Database path: $path');

      // فتح/إنشاء قاعدة البيانات
      final database = await openDatabase(
        path,
        version: AppConstants.databaseVersion,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onOpen: _onOpen,
      );

      AppLogger.info('Database initialized successfully');
      return database;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize database', e, stackTrace);
      rethrow;
    }
  }

  /// إنشاء الجداول عند الإنشاء الأول
  Future<void> _onCreate(Database db, int version) async {
    AppLogger.info('Creating database tables...');

    // تشغيل Foreign Keys
    await db.execute('PRAGMA foreign_keys = ON');

    // ============= جدول المستخدمين =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableUsers} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        full_name TEXT NOT NULL,
        role TEXT NOT NULL CHECK(role IN ('admin', 'cashier', 'kitchen')),
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // ============= جدول الصلاحيات =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tablePermissions} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        role TEXT NOT NULL,
        permission_name TEXT NOT NULL,
        can_access INTEGER NOT NULL DEFAULT 0,
        UNIQUE(role, permission_name)
      )
    ''');

    // ============= جدول الفئات =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableCategories} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        description TEXT,
        display_order INTEGER NOT NULL DEFAULT 0,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL
      )
    ''');

    // ============= جدول الأصناف =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableItems} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category_id INTEGER NOT NULL,
        sell_price REAL NOT NULL CHECK(sell_price >= 0),
        cost_price REAL NOT NULL DEFAULT 0 CHECK(cost_price >= 0),
        description TEXT,
        image_path TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES ${AppConstants.tableCategories}(id) ON DELETE RESTRICT
      )
    ''');

    // ============= جدول الطلبات =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableOrders} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_number TEXT NOT NULL UNIQUE,
        user_id INTEGER NOT NULL,
        subtotal REAL NOT NULL CHECK(subtotal >= 0),
        discount REAL NOT NULL DEFAULT 0 CHECK(discount >= 0),
        total REAL NOT NULL CHECK(total >= 0),
        status TEXT NOT NULL CHECK(status IN ('pending', 'preparing', 'ready', 'completed', 'cancelled')),
        payment_method TEXT CHECK(payment_method IN ('cash', 'card')),
        customer_name TEXT,
        notes TEXT,
        created_at TEXT NOT NULL,
        completed_at TEXT,
        cancelled_at TEXT,
        FOREIGN KEY (user_id) REFERENCES ${AppConstants.tableUsers}(id)
      )
    ''');

    // ============= جدول تفاصيل الطلبات =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableOrderItems} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        item_id INTEGER NOT NULL,
        item_name TEXT NOT NULL,
        quantity INTEGER NOT NULL CHECK(quantity > 0),
        unit_price REAL NOT NULL CHECK(unit_price >= 0),
        total_price REAL NOT NULL CHECK(total_price >= 0),
        notes TEXT,
        FOREIGN KEY (order_id) REFERENCES ${AppConstants.tableOrders}(id) ON DELETE CASCADE,
        FOREIGN KEY (item_id) REFERENCES ${AppConstants.tableItems}(id)
      )
    ''');

    // ============= جدول المواد الخام =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableRawMaterials} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL UNIQUE,
        unit TEXT NOT NULL,
        current_quantity REAL NOT NULL DEFAULT 0 CHECK(current_quantity >= 0),
        min_quantity REAL NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    // ============= جدول المشتريات =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tablePurchases} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        material_id INTEGER NOT NULL,
        supplier_name TEXT NOT NULL,
        quantity REAL NOT NULL CHECK(quantity > 0),
        unit_price REAL NOT NULL CHECK(unit_price >= 0),
        total_price REAL NOT NULL CHECK(total_price >= 0),
        purchase_date TEXT NOT NULL,
        notes TEXT,
        created_by INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (material_id) REFERENCES ${AppConstants.tableRawMaterials}(id),
        FOREIGN KEY (created_by) REFERENCES ${AppConstants.tableUsers}(id)
      )
    ''');

    // ============= جدول الاستهلاك =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableConsumption} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        material_id INTEGER NOT NULL,
        quantity REAL NOT NULL CHECK(quantity > 0),
        consumption_type TEXT NOT NULL CHECK(consumption_type IN ('order', 'waste', 'other')),
        order_id INTEGER,
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (material_id) REFERENCES ${AppConstants.tableRawMaterials}(id),
        FOREIGN KEY (order_id) REFERENCES ${AppConstants.tableOrders}(id)
      )
    ''');

    // ============= جدول ربط الأصناف بالمواد =============
    await db.execute('''
      CREATE TABLE ${AppConstants.tableItemMaterials} (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_id INTEGER NOT NULL,
        material_id INTEGER NOT NULL,
        quantity_required REAL NOT NULL CHECK(quantity_required > 0),
        FOREIGN KEY (item_id) REFERENCES ${AppConstants.tableItems}(id) ON DELETE CASCADE,
        FOREIGN KEY (material_id) REFERENCES ${AppConstants.tableRawMaterials}(id),
        UNIQUE(item_id, material_id)
      )
    ''');

    // ============= الفهارس (Indexes) =============
    await _createIndexes(db);

    // ============= Triggers =============
    await _createTriggers(db);

    // ============= Views =============
    await _createViews(db);

    // ============= البيانات الافتراضية =============
    await _seedData(db);

    AppLogger.info('Database tables created successfully');
  }

  /// إنشاء الفهارس
  Future<void> _createIndexes(Database db) async {
    await db.execute('CREATE INDEX idx_items_category ON ${AppConstants.tableItems}(category_id)');
    await db.execute('CREATE INDEX idx_items_active ON ${AppConstants.tableItems}(is_active)');
    await db.execute('CREATE INDEX idx_orders_user ON ${AppConstants.tableOrders}(user_id)');
    await db.execute('CREATE INDEX idx_orders_status ON ${AppConstants.tableOrders}(status)');
    await db.execute('CREATE INDEX idx_orders_created ON ${AppConstants.tableOrders}(created_at)');
    await db.execute('CREATE INDEX idx_order_items_order ON ${AppConstants.tableOrderItems}(order_id)');
    await db.execute('CREATE INDEX idx_purchases_material ON ${AppConstants.tablePurchases}(material_id)');
    await db.execute('CREATE INDEX idx_purchases_date ON ${AppConstants.tablePurchases}(purchase_date)');
    await db.execute('CREATE INDEX idx_consumption_material ON ${AppConstants.tableConsumption}(material_id)');
  }

  /// إنشاء Triggers
  Future<void> _createTriggers(Database db) async {
    // Trigger: تحديث المخزون عند الوارد
    await db.execute('''
      CREATE TRIGGER update_stock_on_purchase
      AFTER INSERT ON ${AppConstants.tablePurchases}
      BEGIN
        UPDATE ${AppConstants.tableRawMaterials}
        SET current_quantity = current_quantity + NEW.quantity,
            updated_at = datetime('now')
        WHERE id = NEW.material_id;
      END
    ''');

    // Trigger: تحديث المخزون عند الصادر
    await db.execute('''
      CREATE TRIGGER update_stock_on_consumption
      AFTER INSERT ON ${AppConstants.tableConsumption}
      BEGIN
        UPDATE ${AppConstants.tableRawMaterials}
        SET current_quantity = current_quantity - NEW.quantity,
            updated_at = datetime('now')
        WHERE id = NEW.material_id;
      END
    ''');
  }

  /// إنشاء Views
  Future<void> _createViews(Database db) async {
    // View: الأصناف مع الفئات
    await db.execute('''
      CREATE VIEW v_items_with_categories AS
      SELECT
        i.id,
        i.name,
        i.sell_price,
        i.cost_price,
        i.description,
        i.image_path,
        i.is_active,
        c.name as category_name,
        c.id as category_id
      FROM ${AppConstants.tableItems} i
      JOIN ${AppConstants.tableCategories} c ON i.category_id = c.id
    ''');

    // View: الطلبات مع التفاصيل
    await db.execute('''
      CREATE VIEW v_orders_details AS
      SELECT
        o.id,
        o.order_number,
        o.total,
        o.status,
        o.created_at,
        u.full_name as cashier_name,
        COUNT(oi.id) as items_count
      FROM ${AppConstants.tableOrders} o
      JOIN ${AppConstants.tableUsers} u ON o.user_id = u.id
      LEFT JOIN ${AppConstants.tableOrderItems} oi ON o.id = oi.order_id
      GROUP BY o.id
    ''');
  }

  /// إدخال البيانات الافتراضية
  Future<void> _seedData(Database db) async {
    // المستخدم الافتراضي (admin)
    final passwordHash = EncryptionHelper.hashPassword('admin123');
    await db.insert(AppConstants.tableUsers, {
      'username': 'admin',
      'password_hash': passwordHash,
      'full_name': 'المدير العام',
      'role': 'admin',
      'is_active': 1,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    // الصلاحيات الافتراضية
    final permissions = [
      // Admin permissions
      {'role': 'admin', 'permission_name': 'view_reports', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'edit_prices', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'cancel_orders', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'manage_users', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'manage_items', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'manage_inventory', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'export_reports', 'can_access': 1},
      {'role': 'admin', 'permission_name': 'view_costs', 'can_access': 1},

      // Cashier permissions
      {'role': 'cashier', 'permission_name': 'view_reports', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'edit_prices', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'cancel_orders', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'manage_users', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'manage_items', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'manage_inventory', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'export_reports', 'can_access': 0},
      {'role': 'cashier', 'permission_name': 'view_costs', 'can_access': 0},

      // Kitchen permissions
      {'role': 'kitchen', 'permission_name': 'view_reports', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'edit_prices', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'cancel_orders', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'manage_users', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'manage_items', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'manage_inventory', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'export_reports', 'can_access': 0},
      {'role': 'kitchen', 'permission_name': 'view_costs', 'can_access': 0},
    ];

    for (final permission in permissions) {
      await db.insert(AppConstants.tablePermissions, permission);
    }

    // الفئات الافتراضية
    final categories = [
      {'name': 'شاورما لحم', 'description': 'شاورما اللحم بأنواعها', 'display_order': 1, 'is_active': 1, 'created_at': DateTime.now().toIso8601String()},
      {'name': 'شاورما دجاج', 'description': 'شاورما الدجاج بأنواعها', 'display_order': 2, 'is_active': 1, 'created_at': DateTime.now().toIso8601String()},
      {'name': 'مشروبات', 'description': 'المشروبات الباردة والساخنة', 'display_order': 3, 'is_active': 1, 'created_at': DateTime.now().toIso8601String()},
      {'name': 'إضافات', 'description': 'الإضافات والصلصات', 'display_order': 4, 'is_active': 1, 'created_at': DateTime.now().toIso8601String()},
      {'name': 'مقبلات', 'description': 'المقبلات والسلطات', 'display_order': 5, 'is_active': 1, 'created_at': DateTime.now().toIso8601String()},
    ];

    for (final category in categories) {
      await db.insert(AppConstants.tableCategories, category);
    }

    AppLogger.info('Seed data inserted successfully');
  }

  /// تحديث قاعدة البيانات
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    AppLogger.info('Upgrading database from $oldVersion to $newVersion');
    // سيتم إضافة منطق التحديث هنا في الإصدارات المستقبلية
  }

  /// عند فتح قاعدة البيانات
  Future<void> _onOpen(Database db) async {
    // تشغيل Foreign Keys
    await db.execute('PRAGMA foreign_keys = ON');
    AppLogger.info('Database opened');
  }

  /// إغلاق قاعدة البيانات
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
    AppLogger.info('Database closed');
  }

  /// حذف قاعدة البيانات
  Future<void> deleteDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, AppConstants.databaseName);
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
      _database = null;
      AppLogger.info('Database deleted');
    }
  }

  /// نسخ احتياطي لقاعدة البيانات
  Future<String?> backup() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dbPath = join(directory.path, AppConstants.databaseName);
      final dbFile = File(dbPath);

      if (!await dbFile.exists()) {
        return null;
      }

      final backupDir = Directory(join(directory.path, 'backups'));
      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final backupPath = join(backupDir.path, 'backup_$timestamp.db');

      await dbFile.copy(backupPath);
      AppLogger.info('Database backed up to: $backupPath');

      return backupPath;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to backup database', e, stackTrace);
      return null;
    }
  }

  /// استعادة من نسخة احتياطية
  Future<bool> restore(String backupPath) async {
    try {
      final backupFile = File(backupPath);
      if (!await backupFile.exists()) {
        AppLogger.error('Backup file not found: $backupPath');
        return false;
      }

      // إغلاق قاعدة البيانات الحالية
      await close();

      final directory = await getApplicationDocumentsDirectory();
      final dbPath = join(directory.path, AppConstants.databaseName);

      // استبدال قاعدة البيانات
      await backupFile.copy(dbPath);
      AppLogger.info('Database restored from: $backupPath');

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to restore database', e, stackTrace);
      return false;
    }
  }
}
