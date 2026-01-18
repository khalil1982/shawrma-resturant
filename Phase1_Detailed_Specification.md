# المرحلة 1: المواصفات التفصيلية
# Phase 1: Detailed Technical Specification
## النواة الأساسية والعمليات اليومية - Core Foundation & Daily Operations

---

## معلومات المستند
## Document Information

- **اسم المرحلة:** المرحلة 1 - النواة الأساسية
- **Phase Name:** Phase 1 - Core Foundation
- **المدة المتوقعة:** 3-4 أسابيع
- **Expected Duration:** 3-4 weeks
- **الأولوية:** حرجة - Critical
- **التبعيات:** لا يوجد - None
- **الإصدار:** 1.0
- **التاريخ:** 18 يناير 2026

---

## 1. نظرة عامة على المرحلة
## 1. Phase Overview

### الهدف الرئيسي
**Main Objective**

بناء الأساس الوظيفي للنظام الذي يمكّن المطعم من البدء في العمليات اليومية الأساسية: فتح الوردية، إنشاء الطلبات، معالجة المبيعات، وإغلاق الوردية.

Build the functional foundation that enables the restaurant to start basic daily operations: opening shifts, creating orders, processing sales, and closing shifts.

### القيمة المقدمة
**Delivered Value**

بعد هذه المرحلة، سيكون لدى المطعم:
- ✅ نظام POS وظيفي للعمليات اليومية
- ✅ تتبع دقيق للنقد والمبيعات
- ✅ إدارة الورديات الصباحية والمسائية
- ✅ تقرير وردية أساسي

---

## 2. نطاق المرحلة 1
## 2. Phase 1 Scope

### ضمن النطاق (In Scope)

#### 2.1 البنية التحتية للنظام
**System Infrastructure**

- ✅ إعداد مشروع Flutter للسطح المكتبي
- ✅ إعداد قاعدة بيانات SQLite المحلية
- ✅ معمارية المشروع (Clean Architecture)
- ✅ إدارة الحالة (State Management)
- ✅ التوطين والدعم الكامل للعربية RTL
- ✅ واجهة المستخدم الأساسية والتنقل

#### 2.2 إدارة الورديات
**Shift Management**

- ✅ فتح الوردية (صباحية/مسائية)
- ✅ ترحيل النقد من اليوم السابق
- ✅ تعديل النقد الافتتاحي (يدوي مع السبب)
- ✅ إغلاق الوردية
- ✅ حساب فروقات النقد
- ✅ إدخال السبب للفروقات
- ✅ منع فتح وردية جديدة إذا كانت هناك وردية نشطة

#### 2.3 القائمة الثابتة
**Static Menu (Initial)**

- ✅ قائمة ثابتة بالأصناف والأسعار من BRD
- ✅ عرض الأصناف في واجهة الطلب
- ✅ البحث السريع عن الأصناف
- ⚠️ التعديل الديناميكي (المرحلة 2)

**الأصناف الثابتة:**
1. Beta — 15 شيكل
2. Regular — 20 شيكل
3. Double Regular — 25 شيكل
4. Double Double — 30 شيكل
5. Double Meat — 30 شيكل
6. Rocket — 35 شيكل
7. Syrian — 35 شيكل
8. Sfiha — 45 شيكل
9. Cheese Bracelets — 45 شيكل
10. PUBG — 45 شيكل
11. Shawarma Kilo — 120 شيكل

#### 2.4 إدارة الطلبات
**Order Management**

- ✅ إنشاء طلب جديد
- ✅ إضافة الأصناف والكميات
- ✅ ملاحظات على مستوى الصنف
- ✅ ملاحظات على مستوى الطلب
- ✅ اختيار نوع الطلب (داخلي/خارجي - تحليلي فقط)
- ✅ عدد الأشخاص (افتراضي = 1)
- ✅ حالات الطلب:
  - معلق (Pending)
  - قيد التحضير (Preparing)
  - جاهز (Ready)
  - مسلم (Delivered)
  - ملغي (Cancelled)
- ✅ حساب المجموع التلقائي
- ✅ عرض الطلبات النشطة
- ✅ البحث عن الطلبات

#### 2.5 نظام الدفع الأساسي
**Basic Payment System**

- ✅ طريقة دفع واحدة: نقداً (Cash)
- ✅ حساب المبلغ المستحق
- ✅ إدخال المبلغ المدفوع
- ✅ حساب الباقي تلقائياً
- ✅ إكمال عملية الدفع
- ✅ طباعة فاتورة بسيطة (نصية)
- ⚠️ طرق دفع متعددة (المرحلة 4)
- ⚠️ الخصومات (المرحلة 4)

#### 2.6 إلغاء الطلبات
**Order Cancellation**

- ✅ إلغاء الطلب (قبل الدفع فقط في المرحلة 1)
- ✅ سبب الإلغاء (اختياري)
- ✅ تسجيل المستخدم الذي ألغى
- ⚠️ إلغاء بعد الدفع مع استرجاع (المرحلة 4)

#### 2.7 التقرير الأساسي للوردية
**Basic Shift Report**

- ✅ النقد الافتتاحي
- ✅ إجمالي المبيعات
- ✅ عدد الطلبات
- ✅ النقد الختامي المتوقع
- ✅ النقد الفعلي
- ✅ فروقات النقد
- ✅ الطلبات الملغاة
- ✅ عرض على الشاشة
- ✅ طباعة نصية بسيطة
- ⚠️ تصدير PDF/Excel (المرحلة 5)

#### 2.8 نظام المستخدمين الأساسي
**Basic User System**

- ✅ مستخدمان محددان مسبقاً:
  - المالك (Owner): اسم المستخدم `admin`, كلمة المرور `admin123`
  - الكاشير (Cashier): اسم المستخدم `cashier`, كلمة المرور `cashier123`
- ✅ شاشة تسجيل الدخول
- ✅ تسجيل الخروج
- ✅ عرض المستخدم الحالي
- ⚠️ إضافة مستخدمين (المرحلة 6)
- ⚠️ إدارة الأدوار (المرحلة 6)

### خارج النطاق (Out of Scope - Future Phases)

- ❌ القائمة الديناميكية → المرحلة 2
- ❌ إدارة العملاء والديون → المرحلة 2
- ❌ المصروفات والمشتريات → المرحلة 3
- ❌ السحوبات → المرحلة 3
- ❌ الخصومات وطرق الدفع المتعددة → المرحلة 4
- ❌ التقارير الشاملة → المرحلة 5
- ❌ إدارة المستخدمين المتقدمة → المرحلة 6
- ❌ النسخ الاحتياطي → المرحلة 7

---

## 3. البنية التقنية
## 3. Technical Architecture

### 3.1 معمارية المشروع
**Project Architecture**

```
lib/
├── main.dart
├── app.dart
│
├── core/                          # الطبقة الأساسية
│   ├── constants/                 # الثوابت
│   │   ├── app_constants.dart
│   │   ├── database_constants.dart
│   │   └── ui_constants.dart
│   ├── theme/                     # المظهر
│   │   ├── app_theme.dart
│   │   └── colors.dart
│   ├── localization/              # التوطين
│   │   ├── app_localizations.dart
│   │   └── ar.dart
│   ├── utils/                     # الأدوات المساعدة
│   │   ├── date_utils.dart
│   │   ├── number_utils.dart
│   │   └── validators.dart
│   └── errors/                    # معالجة الأخطاء
│       ├── failures.dart
│       └── exceptions.dart
│
├── data/                          # طبقة البيانات
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── database_helper.dart
│   │   │   ├── shift_local_datasource.dart
│   │   │   ├── order_local_datasource.dart
│   │   │   ├── menu_local_datasource.dart
│   │   │   └── user_local_datasource.dart
│   ├── models/
│   │   ├── shift_model.dart
│   │   ├── order_model.dart
│   │   ├── order_item_model.dart
│   │   ├── menu_item_model.dart
│   │   └── user_model.dart
│   └── repositories/
│       ├── shift_repository_impl.dart
│       ├── order_repository_impl.dart
│       ├── menu_repository_impl.dart
│       └── user_repository_impl.dart
│
├── domain/                        # طبقة الأعمال
│   ├── entities/
│   │   ├── shift.dart
│   │   ├── order.dart
│   │   ├── order_item.dart
│   │   ├── menu_item.dart
│   │   └── user.dart
│   ├── repositories/              # واجهات المستودعات
│   │   ├── shift_repository.dart
│   │   ├── order_repository.dart
│   │   ├── menu_repository.dart
│   │   └── user_repository.dart
│   └── usecases/
│       ├── shift/
│       │   ├── open_shift.dart
│       │   ├── close_shift.dart
│       │   └── get_active_shift.dart
│       ├── order/
│       │   ├── create_order.dart
│       │   ├── add_item_to_order.dart
│       │   ├── complete_order.dart
│       │   └── cancel_order.dart
│       ├── menu/
│       │   └── get_menu_items.dart
│       └── user/
│           └── authenticate_user.dart
│
└── presentation/                  # طبقة العرض
    ├── providers/                 # State Management (Riverpod)
    │   ├── auth_provider.dart
    │   ├── shift_provider.dart
    │   ├── order_provider.dart
    │   └── menu_provider.dart
    ├── screens/
    │   ├── auth/
    │   │   └── login_screen.dart
    │   ├── home/
    │   │   └── home_screen.dart
    │   ├── shift/
    │   │   ├── open_shift_screen.dart
    │   │   ├── close_shift_screen.dart
    │   │   └── shift_report_screen.dart
    │   └── order/
    │       ├── order_screen.dart
    │       ├── order_details_screen.dart
    │       └── payment_screen.dart
    └── widgets/
        ├── common/
        │   ├── app_button.dart
        │   ├── app_text_field.dart
        │   └── loading_indicator.dart
        ├── order/
        │   ├── order_item_card.dart
        │   └── menu_item_card.dart
        └── shift/
            └── shift_summary_card.dart
```

### 3.2 التقنيات المستخدمة
**Technology Stack**

| المكون | التقنية | الإصدار |
|--------|---------|---------|
| Framework | Flutter | 3.19+ |
| Language | Dart | 3.3+ |
| Database | SQLite | sqflite 2.3+ |
| State Management | Riverpod | 2.4+ |
| Navigation | go_router | 13+ |
| Localization | intl | 0.19+ |
| Date/Time | intl | 0.19+ |
| UUID | uuid | 4.3+ |

### 3.3 إدارة الحالة
**State Management Strategy**

**استخدام Riverpod للحالة:**

```dart
// مثال: Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(userRepositoryProvider));
});

// مثال: Shift Provider
final activeShiftProvider = FutureProvider<Shift?>((ref) async {
  final repository = ref.read(shiftRepositoryProvider);
  return await repository.getActiveShift();
});

// مثال: Order Provider
final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  return OrderNotifier(ref.read(orderRepositoryProvider));
});
```

---

## 4. نموذج قاعدة البيانات
## 4. Database Schema

### 4.1 الجداول الرئيسية
**Main Tables**

#### جدول المستخدمين - Users Table
```sql
CREATE TABLE users (
    id TEXT PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('owner', 'cashier', 'kitchen')),
    is_active INTEGER DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

#### جدول الورديات - Shifts Table
```sql
CREATE TABLE shifts (
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
    
    FOREIGN KEY (opened_by_user_id) REFERENCES users(id),
    FOREIGN KEY (closed_by_user_id) REFERENCES users(id),
    FOREIGN KEY (opening_cash_adjusted_by_user_id) REFERENCES users(id)
);
```

#### جدول أصناف القائمة - Menu Items Table
```sql
CREATE TABLE menu_items (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    price REAL NOT NULL,
    category TEXT,
    is_active INTEGER DEFAULT 1,
    display_order INTEGER DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

#### جدول الطلبات - Orders Table
```sql
CREATE TABLE orders (
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
    
    FOREIGN KEY (shift_id) REFERENCES shifts(id),
    FOREIGN KEY (created_by_user_id) REFERENCES users(id),
    FOREIGN KEY (completed_by_user_id) REFERENCES users(id),
    FOREIGN KEY (cancelled_by_user_id) REFERENCES users(id)
);
```

#### جدول عناصر الطلب - Order Items Table
```sql
CREATE TABLE order_items (
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
    
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id)
);
```

### 4.2 الفهارس
**Indexes**

```sql
-- فهارس الأداء
CREATE INDEX idx_shifts_date ON shifts(shift_date);
CREATE INDEX idx_shifts_status ON shifts(status);
CREATE INDEX idx_orders_shift ON orders(shift_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_order_items_order ON order_items(order_id);
```

### 4.3 البيانات الأولية
**Initial Data**

```sql
-- المستخدمون الافتراضيون
INSERT INTO users (id, username, password_hash, full_name, role, created_at, updated_at)
VALUES 
    ('user_owner_001', 'admin', 'HASHED_PASSWORD', 'المالك', 'owner', datetime('now'), datetime('now')),
    ('user_cashier_001', 'cashier', 'HASHED_PASSWORD', 'الكاشير', 'cashier', datetime('now'), datetime('now'));

-- القائمة الثابتة
INSERT INTO menu_items (id, name, price, category, display_order, created_at, updated_at)
VALUES 
    ('item_001', 'Beta', 15.00, 'shawarma', 1, datetime('now'), datetime('now')),
    ('item_002', 'Regular', 20.00, 'shawarma', 2, datetime('now'), datetime('now')),
    ('item_003', 'Double Regular', 25.00, 'shawarma', 3, datetime('now'), datetime('now')),
    ('item_004', 'Double Double', 30.00, 'shawarma', 4, datetime('now'), datetime('now')),
    ('item_005', 'Double Meat', 30.00, 'shawarma', 5, datetime('now'), datetime('now')),
    ('item_006', 'Rocket', 35.00, 'shawarma', 6, datetime('now'), datetime('now')),
    ('item_007', 'Syrian', 35.00, 'shawarma', 7, datetime('now'), datetime('now')),
    ('item_008', 'Sfiha', 45.00, 'appetizers', 8, datetime('now'), datetime('now')),
    ('item_009', 'Cheese Bracelets', 45.00, 'appetizers', 9, datetime('now'), datetime('now')),
    ('item_010', 'PUBG', 45.00, 'special', 10, datetime('now'), datetime('now')),
    ('item_011', 'Shawarma Kilo', 120.00, 'bulk', 11, datetime('now'), datetime('now'));
```

---

## 5. تصميم واجهة المستخدم
## 5. User Interface Design

### 5.1 المبادئ التصميمية
**Design Principles**

1. **RTL أولاً:** جميع الواجهات بالعربية من اليمين إلى اليسار
2. **البساطة:** واجهات نظيفة وسهلة الاستخدام
3. **الوضوح:** عناصر كبيرة وواضحة للمس
4. **السرعة:** استجابة فورية للإجراءات
5. **الاتساق:** أنماط تصميم موحدة

### 5.2 نظام الألوان
**Color Palette**

```dart
// الألوان الأساسية
const Color primaryColor = Color(0xFF2E7D32);      // أخضر داكن
const Color secondaryColor = Color(0xFFFF6F00);    // برتقالي
const Color accentColor = Color(0xFF1976D2);       // أزرق

// ألوان الحالة
const Color successColor = Color(0xFF4CAF50);      // أخضر
const Color errorColor = Color(0xFFD32F2F);        // أحمر
const Color warningColor = Color(0xFFFF9800);      // برتقالي
const Color infoColor = Color(0xFF2196F3);         // أزرق

// ألوان الخلفية
const Color backgroundColor = Color(0xFFF5F5F5);   // رمادي فاتح
const Color surfaceColor = Color(0xFFFFFFFF);      // أبيض
const Color cardColor = Color(0xFFFFFFFF);         // أبيض
```

### 5.3 الطباعة
**Typography**

```dart
// استخدام Cairo font للعربية
const TextTheme arabicTextTheme = TextTheme(
  displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  headlineLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
  headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
  bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
  bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
);
```

### 5.4 الشاشات الرئيسية
**Main Screens**

#### 5.4.1 شاشة تسجيل الدخول
**Login Screen**

**المكونات:**
- شعار المطعم (اختياري)
- حقل اسم المستخدم
- حقل كلمة المرور
- زر تسجيل الدخول
- رسالة خطأ (إن وجدت)

**التحققات:**
- ✅ اسم المستخدم مطلوب
- ✅ كلمة المرور مطلوبة
- ✅ التحقق من بيانات الاعتماد

#### 5.4.2 الشاشة الرئيسية
**Home Screen**

**المكونات:**
- شريط التطبيق العلوي:
  - اسم النظام
  - الوردية النشطة (إن وجدت)
  - اسم المستخدم
  - زر تسجيل الخروج
- القائمة الجانبية:
  - إدارة الورديات
  - الطلبات
  - التقارير (أساسي)
  - الإعدادات
- المحتوى الرئيسي:
  - بطاقات ملخص سريع
  - روابط سريعة

#### 5.4.3 شاشة فتح الوردية
**Open Shift Screen**

**المكونات:**
- اختيار نوع الوردية (صباحية/مسائية)
- عرض التاريخ الحالي
- النقد المرحل من اليوم السابق (تلقائي)
- حقل تعديل النقد الافتتاحي (اختياري)
- حقل سبب التعديل (إذا تم التعديل)
- زر فتح الوردية

**التحققات:**
- ✅ لا توجد وردية نشطة حالياً
- ✅ إذا تم التعديل، السبب مطلوب
- ✅ القيم المالية صحيحة

#### 5.4.4 شاشة الطلبات
**Orders Screen**

**المكونات:**
- شريط البحث (بحث في القائمة)
- شبكة أصناف القائمة:
  - اسم الصنف
  - السعر
  - زر إضافة سريعة
- قائمة عناصر الطلب الحالي:
  - اسم الصنف
  - السعر × الكمية
  - الإجمالي الفرعي
  - أزرار (+/-)
  - حقل ملاحظات
  - زر حذف
- ملخص الطلب:
  - الإجمالي الفرعي
  - الإجمالي النهائي
- معلومات الطلب:
  - نوع الطلب (داخلي/خارجي)
  - عدد الأشخاص
  - ملاحظات عامة
- أزرار الإجراءات:
  - حفظ كمعلق
  - إرسال للمطبخ (قيد التحضير)
  - الدفع (إكمال)
  - إلغاء

#### 5.4.5 شاشة الدفع
**Payment Screen**

**المكونات:**
- ملخص الطلب:
  - قائمة الأصناف
  - الإجمالي الفرعي
  - المبلغ المستحق
- طريقة الدفع: نقداً (ثابت في المرحلة 1)
- حقل المبلغ المدفوع
- عرض الباقي (تلقائي)
- زر إكمال الدفع
- زر طباعة الفاتورة

**التحققات:**
- ✅ المبلغ المدفوع >= المبلغ المستحق
- ✅ حساب الباقي صحيح

#### 5.4.6 شاشة إغلاق الوردية
**Close Shift Screen**

**المكونات:**
- ملخص الوردية:
  - نوع الوردية
  - التاريخ والوقت
  - النقد الافتتاحي
  - إجمالي المبيعات
  - عدد الطلبات
  - الطلبات الملغاة
  - النقد الختامي المتوقع
- حقل النقد الفعلي (إدخال يدوي)
- عرض فروقات النقد (تلقائي)
- حقل سبب الفروقات (إذا وجدت)
- زر إغلاق الوردية

**التحققات:**
- ✅ النقد الفعلي مُدخل
- ✅ إذا وجدت فروقات، السبب مطلوب

#### 5.4.7 شاشة تقرير الوردية
**Shift Report Screen**

**المكونات:**
- معلومات الوردية
- النقد الافتتاحي والختامي
- المبيعات والطلبات
- الفروقات
- تفاصيل الطلبات
- زر طباعة

---

## 6. الوظائف الأساسية
## 6. Core Features

### 6.1 إدارة المستخدمين الأساسية
**Basic User Management**

#### تسجيل الدخول
```dart
class AuthenticateUser {
  final UserRepository repository;
  
  Future<Either<Failure, User>> call(String username, String password) async {
    // 1. التحقق من الحقول
    // 2. البحث عن المستخدم
    // 3. التحقق من كلمة المرور
    // 4. إرجاع المستخدم أو خطأ
  }
}
```

**قواعد العمل:**
- ✅ اسم المستخدم وكلمة المرور مطلوبان
- ✅ المستخدم يجب أن يكون نشطاً
- ✅ كلمة المرور يجب أن تطابق الهاش المخزن

### 6.2 إدارة الورديات
**Shift Management**

#### فتح الوردية
```dart
class OpenShift {
  final ShiftRepository repository;
  
  Future<Either<Failure, Shift>> call(OpenShiftParams params) async {
    // 1. التحقق من عدم وجود وردية نشطة
    // 2. الحصول على النقد المرحل من آخر وردية
    // 3. تطبيق أي تعديلات على النقد الافتتاحي
    // 4. إنشاء وردية جديدة
    // 5. حفظ في قاعدة البيانات
  }
}
```

**قواعد العمل:**
- ✅ وردية واحدة نشطة فقط في أي وقت
- ✅ النقد الافتتاحي = النقد الختامي من الوردية السابقة
- ✅ إذا تم التعديل، السبب والمستخدم مطلوبان
- ✅ تسجيل من فتح الوردية ومتى

#### إغلاق الوردية
```dart
class CloseShift {
  final ShiftRepository repository;
  
  Future<Either<Failure, Shift>> call(CloseShiftParams params) async {
    // 1. الحصول على الوردية النشطة
    // 2. حساب النقد الختامي المتوقع
    // 3. إدخال النقد الفعلي
    // 4. حساب الفروقات
    // 5. التحقق من السبب إذا وجدت فروقات
    // 6. تحديث حالة الوردية إلى "closed"
  }
}
```

**قواعد العمل:**
- ✅ النقد الفعلي مطلوب
- ✅ الفروقات = النقد الفعلي - النقد المتوقع
- ✅ إذا الفروقات != 0، السبب مطلوب
- ✅ تسجيل من أغلق الوردية ومتى

### 6.3 إدارة الطلبات
**Order Management**

#### إنشاء طلب جديد
```dart
class CreateOrder {
  final OrderRepository repository;
  
  Future<Either<Failure, Order>> call(CreateOrderParams params) async {
    // 1. التحقق من وجود وردية نشطة
    // 2. توليد رقم طلب فريد
    // 3. إنشاء كيان الطلب
    // 4. حفظ في قاعدة البيانات
  }
}
```

**قواعد العمل:**
- ✅ يجب وجود وردية نشطة
- ✅ رقم الطلب فريد (مثال: ORD-20260118-001)
- ✅ الحالة الافتراضية: معلق (pending)
- ✅ عدد الأشخاص الافتراضي: 1

#### إضافة صنف للطلب
```dart
class AddItemToOrder {
  final OrderRepository repository;
  
  Future<Either<Failure, Order>> call(AddItemParams params) async {
    // 1. التحقق من الطلب
    // 2. الحصول على الصنف من القائمة
    // 3. إضافة للطلب أو زيادة الكمية
    // 4. إعادة حساب المجموع
    // 5. حفظ التحديثات
  }
}
```

**قواعد العمل:**
- ✅ الطلب يجب أن يكون في حالة قابلة للتعديل
- ✅ الصنف يجب أن يكون نشطاً
- ✅ الكمية يجب أن تكون > 0
- ✅ إعادة حساب المجموع الفرعي والمجموع الكلي

#### إكمال الطلب (الدفع)
```dart
class CompleteOrder {
  final OrderRepository repository;
  
  Future<Either<Failure, Order>> call(CompleteOrderParams params) async {
    // 1. التحقق من الطلب
    // 2. التحقق من المبلغ المدفوع
    // 3. حساب الباقي
    // 4. تحديث حالة الطلب إلى "delivered"
    // 5. تحديث إحصائيات الوردية
    // 6. حفظ التحديثات
  }
}
```

**قواعد العمل:**
- ✅ المبلغ المدفوع >= المبلغ المستحق
- ✅ الباقي = المبلغ المدفوع - المبلغ المستحق
- ✅ لا تقريب للقيم المالية
- ✅ تحديث total_sales و total_orders في الوردية

#### إلغاء الطلب
```dart
class CancelOrder {
  final OrderRepository repository;
  
  Future<Either<Failure, Order>> call(CancelOrderParams params) async {
    // 1. التحقق من الطلب
    // 2. التحقق من أن الطلب لم يُدفع بعد (المرحلة 1)
    // 3. تحديث حالة الطلب إلى "cancelled"
    // 4. تسجيل السبب (اختياري)
    // 5. تسجيل من ألغى
    // 6. تحديث إحصائيات الوردية
  }
}
```

**قواعد العمل:**
- ✅ في المرحلة 1: الإلغاء قبل الدفع فقط
- ✅ السبب اختياري
- ✅ تسجيل المستخدم والوقت
- ✅ تحديث cancelled_orders في الوردية

### 6.4 القائمة الثابتة
**Static Menu**

```dart
class GetMenuItems {
  final MenuRepository repository;
  
  Future<Either<Failure, List<MenuItem>>> call() async {
    // 1. استرجاع جميع الأصناف النشطة
    // 2. ترتيب حسب display_order
    // 3. إرجاع القائمة
  }
}
```

**قواعد العمل:**
- ✅ عرض الأصناف النشطة فقط (is_active = 1)
- ✅ ترتيب حسب display_order
- ✅ البحث السريع في الاسم

---

## 7. خطة الاختبار
## 7. Testing Plan

### 7.1 اختبارات الوحدات
**Unit Tests**

#### اختبار Use Cases
```dart
// مثال: اختبار فتح الوردية
group('OpenShift', () {
  test('should open shift successfully when no active shift exists', () async {
    // Arrange
    // Act
    // Assert
  });
  
  test('should fail when active shift exists', () async {
    // Arrange
    // Act
    // Assert
  });
  
  test('should carry forward cash from previous shift', () async {
    // Arrange
    // Act
    // Assert
  });
});
```

#### اختبار Entities
```dart
group('Order Entity', () {
  test('should calculate total correctly', () {
    // Test
  });
  
  test('should not allow negative quantities', () {
    // Test
  });
});
```

### 7.2 اختبارات التكامل
**Integration Tests**

```dart
group('Shift Flow Integration', () {
  test('complete shift lifecycle', () async {
    // 1. فتح الوردية
    // 2. إنشاء طلبات
    // 3. إكمال طلبات
    // 4. إغلاق الوردية
    // 5. التحقق من البيانات
  });
});
```

### 7.3 اختبار واجهة المستخدم
**Widget Tests**

```dart
group('Login Screen', () {
  testWidgets('should show error when fields are empty', (tester) async {
    // Test
  });
  
  testWidgets('should navigate to home when login successful', (tester) async {
    // Test
  });
});
```

### 7.4 حالات الاختبار الرئيسية
**Main Test Cases**

#### TC-001: تسجيل الدخول
- ✅ تسجيل دخول ناجح بمستخدم صحيح
- ✅ فشل تسجيل الدخول ببيانات خاطئة
- ✅ فشل تسجيل الدخول بحقول فارغة
- ✅ فشل تسجيل الدخول بمستخدم غير نشط

#### TC-002: فتح الوردية
- ✅ فتح وردية صباحية جديدة
- ✅ فتح وردية مسائية جديدة
- ✅ ترحيل النقد من الوردية السابقة
- ✅ تعديل النقد الافتتاحي مع السبب
- ✅ منع فتح وردية عند وجود وردية نشطة

#### TC-003: الطلبات
- ✅ إنشاء طلب جديد
- ✅ إضافة أصناف للطلب
- ✅ زيادة/تقليل الكمية
- ✅ حذف صنف من الطلب
- ✅ إضافة ملاحظات
- ✅ حساب المجموع الصحيح
- ✅ إكمال الطلب (الدفع)
- ✅ إلغاء طلب

#### TC-004: إغلاق الوردية
- ✅ إغلاق الوردية بنقد مطابق
- ✅ إغلاق الوردية مع فروقات موجبة
- ✅ إغلاق الوردية مع فروقات سالبة
- ✅ إدخال سبب الفروقات

#### TC-005: التقرير
- ✅ عرض تقرير الوردية الصحيح
- ✅ طباعة التقرير

---

## 8. معايير القبول
## 8. Acceptance Criteria

### 8.1 معايير وظيفية
**Functional Criteria**

- ✅ جميع الميزات المحددة في النطاق تعمل بشكل صحيح
- ✅ تسجيل الدخول/الخروج يعمل
- ✅ فتح وإغلاق الورديات يعمل بدقة
- ✅ إنشاء ومعالجة الطلبات يعمل
- ✅ الحسابات المالية دقيقة 100% (بدون تقريب)
- ✅ التقرير الأساسي يعرض بيانات صحيحة

### 8.2 معايير غير وظيفية
**Non-Functional Criteria**

- ✅ الواجهة بالكامل بالعربية RTL
- ✅ الاستجابة الفورية (<100ms للعمليات المحلية)
- ✅ النظام يعمل دون اتصال بالإنترنت
- ✅ لا أخطاء crashes
- ✅ البيانات محفوظة بشكل آمن في SQLite

### 8.3 معايير الجودة
**Quality Criteria**

- ✅ تغطية اختبارات > 80%
- ✅ الكود يتبع معايير Dart/Flutter
- ✅ المعمارية النظيفة مطبقة
- ✅ لا تحذيرات Lint
- ✅ الكود موثق

---

## 9. التسليمات
## 9. Deliverables

### 9.1 الكود
**Code**

- ✅ شفرة المصدر الكاملة على Git
- ✅ اختبارات الوحدات والتكامل
- ✅ التوثيق التقني (README)
- ✅ دليل الإعداد

### 9.2 قاعدة البيانات
**Database**

- ✅ سكريبت إنشاء الجداول
- ✅ البيانات الأولية
- ✅ وثائق نموذج البيانات

### 9.3 الوثائق
**Documentation**

- ✅ دليل المستخدم (المرحلة 1)
- ✅ دليل الإعداد والتثبيت
- ✅ وثائق API الداخلية
- ✅ ملاحظات الإصدار

### 9.4 الاختبار
**Testing**

- ✅ حالات الاختبار المكتوبة
- ✅ تقرير الاختبار
- ✅ قائمة الأخطاء المعروفة (إن وجدت)

---

## 10. الجدول الزمني التفصيلي
## 10. Detailed Timeline

### الأسبوع 1: البنية التحتية
**Week 1: Infrastructure**

**الأيام 1-2:**
- ✅ إعداد مشروع Flutter
- ✅ إعداد SQLite
- ✅ بناء معمارية المشروع
- ✅ إعداد Riverpod

**الأيام 3-4:**
- ✅ إنشاء نموذج قاعدة البيانات
- ✅ إدخال البيانات الأولية
- ✅ بناء طبقة البيانات الأساسية

**الأيام 5-7:**
- ✅ إعداد التوطين (العربية)
- ✅ بناء نظام التصميم الأساسي
- ✅ إنشاء الويدجتات المشتركة

### الأسبوع 2: المستخدمين والورديات
**Week 2: Users & Shifts**

**الأيام 1-3:**
- ✅ تطبيق نظام المستخدمين
- ✅ شاشة تسجيل الدخول
- ✅ إدارة الجلسة
- ✅ اختبارات المستخدمين

**الأيام 4-7:**
- ✅ تطبيق فتح الوردية
- ✅ تطبيق إغلاق الوردية
- ✅ شاشات الورديات
- ✅ اختبارات الورديات

### الأسبوع 3: الطلبات والدفع
**Week 3: Orders & Payment**

**الأيام 1-3:**
- ✅ تطبيق إنشاء الطلب
- ✅ تطبيق إضافة الأصناف
- ✅ شاشة الطلبات
- ✅ واجهة القائمة

**الأيام 4-7:**
- ✅ تطبيق الدفع
- ✅ شاشة الدفع
- ✅ تطبيق الإلغاء
- ✅ اختبارات الطلبات

### الأسبوع 4: التقارير والاختبار النهائي
**Week 4: Reports & Final Testing**

**الأيام 1-2:**
- ✅ تطبيق التقرير الأساسي
- ✅ شاشة التقرير
- ✅ وظيفة الطباعة

**الأيام 3-5:**
- ✅ اختبار التكامل الشامل
- ✅ اختبار قبول المستخدم
- ✅ إصلاح الأخطاء

**الأيام 6-7:**
- ✅ التوثيق النهائي
- ✅ التحضير للتسليم
- ✅ جلسة تدريب أولية

---

## 11. المخاطر والتخفيف
## 11. Risks & Mitigation

### خطر 1: مشاكل أداء قاعدة البيانات
**Risk 1: Database Performance Issues**

- **الاحتمال:** متوسط
- **التأثير:** عالي
- **التخفيف:**
  - استخدام الفهارس المناسبة
  - اختبار الأداء مبكراً
  - تحسين الاستعلامات

### خطر 2: تعقيد واجهة المستخدم RTL
**Risk 2: RTL UI Complexity**

- **الاحتمال:** متوسط
- **التأثير:** متوسط
- **التخفيف:**
  - اختبار RTL منذ البداية
  - استخدام Directionality في Flutter
  - مراجعة مستمرة للواجهات

### خطر 3: دقة الحسابات المالية
**Risk 3: Financial Calculation Accuracy**

- **الاحتمال:** منخفض
- **التأثير:** حرج
- **التخفيف:**
  - استخدام Decimal للحسابات المالية
  - اختبارات شاملة للحسابات
  - مراجعة يدوية للنتائج

### خطر 4: تأخر الجدول الزمني
**Risk 4: Timeline Delays**

- **الاحتمال:** متوسط
- **التأثير:** متوسط
- **التخفيف:**
  - مراجعة أسبوعية للتقدم
  - buffer time في الجدول
  - إعطاء أولوية للميزات الأساسية

---

## 12. معايير النجاح
## 12. Success Metrics

### المعايير الوظيفية
**Functional Metrics**

- ✅ 100% من الميزات المطلوبة منفذة
- ✅ 0 أخطاء حرجة
- ✅ جميع حالات الاختبار تنجح

### معايير الأداء
**Performance Metrics**

- ✅ وقت استجابة < 100ms للعمليات المحلية
- ✅ استهلاك ذاكرة < 200MB
- ✅ حجم قاعدة البيانات معقول

### معايير الجودة
**Quality Metrics**

- ✅ تغطية اختبارات > 80%
- ✅ 0 تحذيرات Lint
- ✅ درجة صيانة الكود > B

### رضا المستخدم
**User Satisfaction**

- ✅ سهولة الاستخدام: 4/5
- ✅ الأداء: 4/5
- ✅ الموثوقية: 5/5

---

## 13. الخطوات التالية
## 13. Next Steps

### بعد الموافقة على هذا المستند
**After Approval of This Document**

1. ✅ إعداد بيئة التطوير
2. ✅ إنشاء مستودع Git
3. ✅ بدء التطوير حسب الجدول الزمني
4. ✅ اجتماع بداية أسبوعي

### التواصل
**Communication**

- اجتماعات أسبوعية لمراجعة التقدم
- تحديثات يومية عبر القنوات المتفق عليها
- استعراض الكود المستمر

### الانتقال للمرحلة 2
**Transition to Phase 2**

- اختبار قبول المستخدم للمرحلة 1
- مراجعة الدروس المستفادة
- تحديث خطة المرحلة 2 إذا لزم الأمر

---

## 14. الملاحق
## 14. Appendices

### ملحق أ: نماذج البيانات التفصيلية
**Appendix A: Detailed Data Models**

```dart
// Shift Entity
class Shift {
  final String id;
  final String shiftType; // 'morning' | 'evening'
  final DateTime shiftDate;
  final String openedByUserId;
  final DateTime openedAt;
  
  final double openingCash;
  final double? openingCashAdjustment;
  final String? openingCashAdjustmentReason;
  final String? openingCashAdjustedByUserId;
  
  final String? closedByUserId;
  final DateTime? closedAt;
  final double expectedClosingCash;
  final double actualClosingCash;
  final double cashVariance;
  final String? cashVarianceReason;
  
  final double totalSales;
  final int totalOrders;
  final int cancelledOrders;
  
  final String status; // 'active' | 'closed'
  
  final DateTime createdAt;
  final DateTime updatedAt;
}

// Order Entity
class Order {
  final String id;
  final String orderNumber;
  final String shiftId;
  
  final String orderType; // 'dine_in' | 'takeaway'
  final int customerCount;
  
  final String status; // 'pending' | 'preparing' | 'ready' | 'delivered' | 'cancelled'
  
  final double subtotal;
  final double discountAmount;
  final double totalAmount;
  
  final String paymentMethod;
  final double amountPaid;
  final double changeAmount;
  
  final String? notes;
  
  final List<OrderItem> items;
  
  final String createdByUserId;
  final DateTime createdAt;
  
  final String? completedByUserId;
  final DateTime? completedAt;
  
  final String? cancelledByUserId;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  
  final DateTime updatedAt;
}

// MenuItem Entity
class MenuItem {
  final String id;
  final String name;
  final double price;
  final String? category;
  final bool isActive;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
}
```

### ملحق ب: أمثلة على الواجهات
**Appendix B: UI Mockups**

(سيتم إضافة الصور/النماذج في مرحلة التصميم)

---

## التوقيعات والموافقات
## Signatures & Approvals

**تم الإعداد بواسطة:** خليل الحلبي
**Prepared by:** Khalil Al-Halabi

**التاريخ:** 18 يناير 2026
**Date:** January 18, 2026

**الحالة:** جاهز للموافقة والبدء
**Status:** Ready for Approval & Start

---

**نهاية مواصفات المرحلة 1**
**End of Phase 1 Specification**
