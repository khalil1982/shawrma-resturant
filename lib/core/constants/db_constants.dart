/// ثوابت قاعدة البيانات - أسماء الأعمدة والاستعلامات
class DbConstants {
  DbConstants._();

  // ============= أعمدة جدول المستخدمين =============
  static const String usersId = 'id';
  static const String usersUsername = 'username';
  static const String usersPasswordHash = 'password_hash';
  static const String usersFullName = 'full_name';
  static const String usersRole = 'role';
  static const String usersIsActive = 'is_active';
  static const String usersCreatedAt = 'created_at';
  static const String usersUpdatedAt = 'updated_at';

  // ============= أعمدة جدول الفئات =============
  static const String categoriesId = 'id';
  static const String categoriesName = 'name';
  static const String categoriesDescription = 'description';
  static const String categoriesDisplayOrder = 'display_order';
  static const String categoriesIsActive = 'is_active';
  static const String categoriesCreatedAt = 'created_at';

  // ============= أعمدة جدول الأصناف =============
  static const String itemsId = 'id';
  static const String itemsName = 'name';
  static const String itemsCategoryId = 'category_id';
  static const String itemsSellPrice = 'sell_price';
  static const String itemsCostPrice = 'cost_price';
  static const String itemsDescription = 'description';
  static const String itemsImagePath = 'image_path';
  static const String itemsIsActive = 'is_active';
  static const String itemsCreatedAt = 'created_at';
  static const String itemsUpdatedAt = 'updated_at';

  // ============= أعمدة جدول الطلبات =============
  static const String ordersId = 'id';
  static const String ordersOrderNumber = 'order_number';
  static const String ordersUserId = 'user_id';
  static const String ordersSubtotal = 'subtotal';
  static const String ordersDiscount = 'discount';
  static const String ordersTotal = 'total';
  static const String ordersStatus = 'status';
  static const String ordersPaymentMethod = 'payment_method';
  static const String ordersCustomerName = 'customer_name';
  static const String ordersNotes = 'notes';
  static const String ordersCreatedAt = 'created_at';
  static const String ordersCompletedAt = 'completed_at';
  static const String ordersCancelledAt = 'cancelled_at';

  // ============= أعمدة جدول تفاصيل الطلبات =============
  static const String orderItemsId = 'id';
  static const String orderItemsOrderId = 'order_id';
  static const String orderItemsItemId = 'item_id';
  static const String orderItemsItemName = 'item_name';
  static const String orderItemsQuantity = 'quantity';
  static const String orderItemsUnitPrice = 'unit_price';
  static const String orderItemsTotalPrice = 'total_price';
  static const String orderItemsNotes = 'notes';

  // ============= أعمدة جدول المواد الخام =============
  static const String rawMaterialsId = 'id';
  static const String rawMaterialsName = 'name';
  static const String rawMaterialsUnit = 'unit';
  static const String rawMaterialsCurrentQuantity = 'current_quantity';
  static const String rawMaterialsMinQuantity = 'min_quantity';
  static const String rawMaterialsCreatedAt = 'created_at';
  static const String rawMaterialsUpdatedAt = 'updated_at';

  // ============= أعمدة جدول المشتريات =============
  static const String purchasesId = 'id';
  static const String purchasesMaterialId = 'material_id';
  static const String purchasesSupplierName = 'supplier_name';
  static const String purchasesQuantity = 'quantity';
  static const String purchasesUnitPrice = 'unit_price';
  static const String purchasesTotalPrice = 'total_price';
  static const String purchasesPurchaseDate = 'purchase_date';
  static const String purchasesNotes = 'notes';
  static const String purchasesCreatedBy = 'created_by';
  static const String purchasesCreatedAt = 'created_at';

  // ============= أعمدة جدول الاستهلاك =============
  static const String consumptionId = 'id';
  static const String consumptionMaterialId = 'material_id';
  static const String consumptionQuantity = 'quantity';
  static const String consumptionType = 'consumption_type';
  static const String consumptionOrderId = 'order_id';
  static const String consumptionNotes = 'notes';
  static const String consumptionCreatedAt = 'created_at';

  // ============= أعمدة جدول ربط الأصناف بالمواد =============
  static const String itemMaterialsId = 'id';
  static const String itemMaterialsItemId = 'item_id';
  static const String itemMaterialsMaterialId = 'material_id';
  static const String itemMaterialsQuantityRequired = 'quantity_required';

  // ============= أعمدة جدول الصلاحيات =============
  static const String permissionsId = 'id';
  static const String permissionsRole = 'role';
  static const String permissionsPermissionName = 'permission_name';
  static const String permissionsCanAccess = 'can_access';
}
