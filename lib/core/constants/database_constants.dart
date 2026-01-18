/// Database-related constants
class DatabaseConstants {
  static const String databaseName = 'shawarma_basel.db';
  static const int databaseVersion = 1;

  // Table Names
  static const String tableUsers = 'users';
  static const String tableShifts = 'shifts';
  static const String tableMenuItems = 'menu_items';
  static const String tableOrders = 'orders';
  static const String tableOrderItems = 'order_items';

  // User Roles
  static const String roleOwner = 'owner';
  static const String roleCashier = 'cashier';
  static const String roleKitchen = 'kitchen';

  // Shift Types
  static const String shiftTypeMorning = 'morning';
  static const String shiftTypeEvening = 'evening';

  // Shift Status
  static const String shiftStatusActive = 'active';
  static const String shiftStatusClosed = 'closed';

  // Order Types
  static const String orderTypeDineIn = 'dine_in';
  static const String orderTypeTakeaway = 'takeaway';

  // Order Status
  static const String orderStatusPending = 'pending';
  static const String orderStatusPreparing = 'preparing';
  static const String orderStatusReady = 'ready';
  static const String orderStatusDelivered = 'delivered';
  static const String orderStatusCancelled = 'cancelled';

  // Payment Methods
  static const String paymentMethodCash = 'cash';

  // Menu Categories
  static const String categoryShawarma = 'shawarma';
  static const String categoryAppetizers = 'appetizers';
  static const String categorySpecial = 'special';
  static const String categoryBulk = 'bulk';
}
