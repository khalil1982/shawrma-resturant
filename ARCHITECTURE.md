# 🏗️ معمارية النظام - Architecture Documentation

<div dir="rtl">

## نظرة عامة

يتبع هذا المشروع **معمارية Clean Architecture** لضمان:
- فصل الاهتمامات (Separation of Concerns)
- قابلية الاختبار (Testability)
- قابلية التوسع (Scalability)
- سهولة الصيانة (Maintainability)

---

## 📐 الطبقات الرئيسية

```
┌─────────────────────────────────────┐
│    Presentation Layer (UI)          │
│  - Screens, Widgets, Providers      │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    Domain Layer (Business Logic)    │
│  - Entities, Use Cases, Repositories│
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    Data Layer (Data Access)          │
│  - Models, Data Sources, Repos Impl │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│    Database (SQLite)                 │
└─────────────────────────────────────┘
```

---

## 🗂️ هيكل المجلدات التفصيلي

### 1️⃣ Core Layer - الطبقة الأساسية

```
lib/core/
├── constants/           # الثوابت
│   ├── app_constants.dart        # ثوابت التطبيق العامة
│   ├── db_constants.dart         # أسماء الأعمدة والجداول
│   └── enums.dart                # Enumerations
│
├── theme/              # الثيمات والألوان
│   ├── app_colors.dart          # ألوان التطبيق
│   └── app_theme.dart           # ThemeData
│
├── helpers/            # المساعدات
│   ├── date_helper.dart         # تنسيق التواريخ
│   └── validators.dart          # التحقق من المدخلات
│
├── utils/              # الأدوات المساعدة
│   ├── currency_formatter.dart  # تنسيق العملة
│   ├── encryption_helper.dart   # التشفير
│   └── app_logger.dart          # التسجيل
│
└── errors/             # معالجة الأخطاء
    ├── failures.dart            # Domain Failures
    └── exceptions.dart          # Data Exceptions
```

**الغرض:**
- توفير أدوات مشتركة لجميع الطبقات
- تجنب تكرار الكود
- توحيد طريقة التعامل مع الأخطاء والتواريخ والعملة

---

### 2️⃣ Data Layer - طبقة البيانات

```
lib/data/
├── models/                    # نماذج البيانات (Data Models)
│   ├── user/
│   │   └── user_model.dart    # UserModel - يتعامل مع قاعدة البيانات
│   ├── category/
│   ├── item/
│   ├── order/
│   └── inventory/
│
├── datasources/              # مصادر البيانات
│   └── local/
│       └── database_helper.dart  # إدارة SQLite
│
└── repositories/             # تطبيق المستودعات
    ├── user_repository_impl.dart
    ├── item_repository_impl.dart
    └── order_repository_impl.dart
```

**المسؤوليات:**
- التعامل المباشر مع قاعدة البيانات
- تحويل البيانات من/إلى قاعدة البيانات
- تطبيق واجهات Repository من Domain Layer

**مثال - UserModel:**
```dart
class UserModel {
  final int? id;
  final String username;
  final String passwordHash;

  // تحويل من Map (قاعدة البيانات)
  factory UserModel.fromMap(Map<String, dynamic> map);

  // تحويل إلى Map (لحفظها في قاعدة البيانات)
  Map<String, dynamic> toMap();

  // تحويل إلى Entity (للطبقة Domain)
  UserEntity toEntity();
}
```

---

### 3️⃣ Domain Layer - طبقة المنطق

```
lib/domain/
├── entities/                 # كيانات العمل (Business Entities)
│   ├── user_entity.dart     # الكيان بدون تفاصيل قاعدة البيانات
│   ├── category_entity.dart
│   ├── item_entity.dart
│   ├── order_entity.dart
│   └── order_item_entity.dart
│
├── repositories/            # واجهات المستودعات (Interfaces)
│   ├── user_repository.dart
│   ├── item_repository.dart
│   └── order_repository.dart
│
└── usecases/               # حالات الاستخدام (Use Cases)
    ├── auth/
    │   ├── login_usecase.dart
    │   └── logout_usecase.dart
    ├── items/
    │   ├── get_items_usecase.dart
    │   └── create_item_usecase.dart
    └── orders/
        ├── create_order_usecase.dart
        └── get_pending_orders_usecase.dart
```

**المسؤوليات:**
- تحديد منطق العمل الأساسي
- لا تعتمد على أي طبقة خارجية
- تحديد **ماذا** يجب أن يفعل النظام (وليس كيف)

**مثال - Entity:**
```dart
class UserEntity {
  final int id;
  final String username;
  final String fullName;
  final UserRole role;

  // بدون تفاصيل قاعدة البيانات
  // فقط منطق العمل
}
```

**مثال - Repository Interface:**
```dart
abstract class UserRepository {
  Future<Either<Failure, UserEntity>> login(String username, String password);
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, void>> createUser(UserEntity user);
}
```

---

### 4️⃣ Presentation Layer - طبقة العرض

```
lib/presentation/
├── screens/               # الشاشات
│   ├── auth/
│   │   └── login_screen.dart         # شاشة تسجيل الدخول
│   ├── home/
│   │   └── home_screen.dart          # الشاشة الرئيسية
│   ├── pos/
│   │   └── pos_screen.dart           # شاشة نقطة البيع
│   ├── items/
│   │   ├── items_list_screen.dart    # قائمة الأصناف
│   │   └── item_form_screen.dart     # نموذج إضافة/تعديل
│   ├── inventory/
│   ├── reports/
│   └── settings/
│
├── widgets/              # المكونات المشتركة
│   ├── buttons/
│   ├── cards/
│   ├── forms/
│   ├── dialogs/
│   └── common/
│
└── providers/           # Riverpod Providers
    ├── auth_provider.dart
    ├── items_provider.dart
    └── orders_provider.dart
```

**المسؤوليات:**
- عرض البيانات للمستخدم
- التفاعل مع المستخدم
- استدعاء Use Cases عبر Providers

---

## 🔄 تدفق البيانات (Data Flow)

### مثال: تسجيل الدخول

```
1. User يدخل اسم المستخدم وكلمة المرور في LoginScreen
                    ↓
2. LoginScreen يستدعي AuthProvider
                    ↓
3. AuthProvider يستدعي LoginUseCase
                    ↓
4. LoginUseCase يستدعي UserRepository (interface)
                    ↓
5. UserRepositoryImpl يستدعي DatabaseHelper
                    ↓
6. DatabaseHelper يبحث في SQLite
                    ↓
7. النتيجة ترجع عبر نفس السلسلة بالعكس:
   DatabaseHelper → UserRepositoryImpl → LoginUseCase
   → AuthProvider → LoginScreen
                    ↓
8. LoginScreen يعرض النتيجة للمستخدم
```

---

## 🗄️ قاعدة البيانات (Database Layer)

### الجداول الرئيسية

| الجدول | الوصف | العلاقات |
|--------|-------|----------|
| `users` | المستخدمين | - |
| `categories` | الفئات | `items` (1:N) |
| `items` | الأصناف | `categories` (N:1), `order_items` (1:N) |
| `orders` | الطلبات | `users` (N:1), `order_items` (1:N) |
| `order_items` | تفاصيل الطلبات | `orders` (N:1), `items` (N:1) |
| `raw_materials` | المواد الخام | `purchases` (1:N), `consumption` (1:N) |
| `purchases` | المشتريات | `raw_materials` (N:1) |
| `consumption` | الاستهلاك | `raw_materials` (N:1), `orders` (N:1) |

### Triggers التلقائية

1. **update_stock_on_purchase**
   - يُنفذ عند إضافة مشتريات جديدة
   - يحدث المخزون تلقائياً

2. **update_stock_on_consumption**
   - يُنفذ عند تسجيل استهلاك
   - يخصم من المخزون تلقائياً

---

## 🎨 إدارة الحالة (State Management)

### لماذا Riverpod؟

✅ **المميزات:**
- Type-safe - آمن من الأخطاء
- لا يعتمد على BuildContext
- سهل الاختبار
- يدعم Dependency Injection
- Hot Reload ممتاز

### أنواع Providers المستخدمة

```dart
// 1. Provider - للقيم الثابتة
final databaseProvider = Provider((ref) => DatabaseHelper.instance);

// 2. StateProvider - للحالة البسيطة
final counterProvider = StateProvider((ref) => 0);

// 3. FutureProvider - للبيانات غير المتزامنة
final usersProvider = FutureProvider((ref) async {
  final repo = ref.read(userRepositoryProvider);
  return repo.getAllUsers();
});

// 4. StateNotifierProvider - للحالة المعقدة
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(loginUseCaseProvider));
});
```

---

## 🔐 الأمان (Security)

### 1. تشفير كلمات المرور
```dart
// استخدام SHA-256
final hashedPassword = EncryptionHelper.hashPassword('admin123');
```

### 2. الصلاحيات
```dart
// فحص الصلاحيات قبل كل عملية
if (!user.hasPermission(PermissionType.editPrices)) {
  throw PermissionException('ليس لديك صلاحية لتعديل الأسعار');
}
```

### 3. SQL Injection Protection
```dart
// استخدام Prepared Statements
await db.query(
  'users',
  where: 'username = ?',
  whereArgs: [username], // آمن من SQL Injection
);
```

---

## 🧪 الاختبارات (Testing)

### هيكل الاختبارات

```
test/
├── unit/                # اختبارات الوحدات
│   ├── domain/
│   │   └── usecases/
│   └── data/
│       └── repositories/
│
├── widget/             # اختبارات الواجهة
│   └── screens/
│
└── integration/        # اختبارات التكامل
```

### مثال اختبار

```dart
test('Login with valid credentials should return UserEntity', () async {
  // Arrange
  final mockRepo = MockUserRepository();
  final useCase = LoginUseCase(mockRepo);

  // Act
  final result = await useCase('admin', 'admin123');

  // Assert
  expect(result.isRight(), true);
  result.fold(
    (failure) => fail('Should not return failure'),
    (user) => expect(user.username, 'admin'),
  );
});
```

---

## 📦 إدارة الاعتماديات (Dependency Injection)

نستخدم **Riverpod** لإدارة الاعتماديات:

```dart
// في ملف providers/app_providers.dart

// Database
final databaseProvider = Provider((ref) => DatabaseHelper.instance);

// Repositories
final userRepositoryProvider = Provider((ref) {
  final db = ref.read(databaseProvider);
  return UserRepositoryImpl(db);
});

// Use Cases
final loginUseCaseProvider = Provider((ref) {
  final repo = ref.read(userRepositoryProvider);
  return LoginUseCase(repo);
});

// State Notifiers
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.read(loginUseCaseProvider);
  return AuthNotifier(loginUseCase);
});
```

---

## 🌐 دعم RTL واللغة العربية

### 1. تكوين MaterialApp

```dart
MaterialApp(
  locale: const Locale('ar', 'SA'),
  supportedLocales: const [
    Locale('ar', 'SA'),
    Locale('en', 'US'),
  ],
  theme: AppTheme.lightTheme, // يدعم RTL
)
```

### 2. استخدام Directionality

```dart
Directionality(
  textDirection: TextDirection.rtl,
  child: YourWidget(),
)
```

### 3. الخطوط العربية

```yaml
fonts:
  - family: Cairo
    fonts:
      - asset: assets/fonts/Cairo-Regular.ttf
      - asset: assets/fonts/Cairo-Bold.ttf
        weight: 700
```

---

## 🚀 التوسع المستقبلي

### المرحلة 1 (الحالية)
- ✅ قاعدة البيانات المحلية
- ✅ المعمارية الأساسية
- ✅ شاشة تسجيل الدخول
- 🔄 نقطة البيع (POS)
- 🔄 إدارة الأصناف
- 🔄 التقارير الأساسية

### المرحلة 2
- [ ] نظام الطباعة (Thermal Printer)
- [ ] شاشة المطبخ المنفصلة
- [ ] النسخ الاحتياطي التلقائي

### المرحلة 3
- [ ] مزامنة سحابية (Cloud Sync)
- [ ] Multi-tenant (عدة مطاعم)
- [ ] تطبيق موبايل

### المرحلة 4
- [ ] تحليلات بالذكاء الاصطناعي
- [ ] توقع الطلب والمبيعات
- [ ] لوحة تحكم تحليلية متقدمة

---

## 📝 القواعد والمعايير

### تسمية الملفات
- **الملفات:** `snake_case.dart`
- **الكلاسات:** `PascalCase`
- **المتغيرات:** `camelCase`
- **الثوابت:** `UPPER_SNAKE_CASE`

### تنظيم الكود
```dart
// 1. Imports
import 'package:flutter/material.dart';

// 2. Class/Function Documentation
/// وصف الكلاس أو الدالة

// 3. Class Definition
class MyClass {
  // Constants
  static const String myConstant = 'value';

  // Fields
  final String myField;

  // Constructor
  const MyClass({required this.myField});

  // Methods
  void myMethod() {}
}
```

### معالجة الأخطاء
```dart
try {
  // عملية قد تفشل
} on DatabaseException catch (e) {
  AppLogger.error('Database error: ${e.message}');
  return Left(DatabaseFailure(e.message));
} catch (e, stackTrace) {
  AppLogger.error('Unexpected error', e, stackTrace);
  return Left(UnexpectedFailure('حدث خطأ غير متوقع'));
}
```

---

## 📚 المراجع والمصادر

### Clean Architecture
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture](https://resocoder.com/flutter-clean-architecture-tdd/)

### Riverpod
- [Riverpod Documentation](https://riverpod.dev)
- [Riverpod Best Practices](https://codewithandrea.com/articles/flutter-state-management-riverpod/)

### Flutter Desktop
- [Flutter Desktop Documentation](https://docs.flutter.dev/desktop)
- [Building Desktop Apps](https://flutter.dev/multi-platform/desktop)

---

## 🤝 المساهمة

عند المساهمة في المشروع:
1. اتبع معمارية Clean Architecture
2. اكتب كود نظيف وموثق
3. أضف اختبارات للكود الجديد
4. حدّث الوثائق عند الحاجة

---

**تاريخ آخر تحديث:** 2026-01-17
**الإصدار:** 1.0.0
**المطور:** Claude AI

</div>
