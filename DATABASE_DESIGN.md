# 🗄️ تصميم قاعدة البيانات - نظام إدارة مطعم الشاورما

## نظرة عامة
قاعدة بيانات SQLite محلية (Offline First) مصممة لإدارة جميع عمليات المطعم

---

## 📊 الجداول والعلاقات

### 1️⃣ جدول المستخدمين (users)
```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL CHECK(role IN ('admin', 'cashier', 'kitchen')),
    is_active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

**الأدوار:**
- `admin`: مدير - صلاحيات كاملة
- `cashier`: كاشير - البيع وإدارة الطلبات
- `kitchen`: مطبخ - عرض الطلبات فقط

---

### 2️⃣ جدول الصلاحيات (permissions)
```sql
CREATE TABLE permissions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    role TEXT NOT NULL,
    permission_name TEXT NOT NULL,
    can_access INTEGER NOT NULL DEFAULT 0,
    UNIQUE(role, permission_name)
);
```

**الصلاحيات:**
- `view_reports`: عرض التقارير
- `edit_prices`: تعديل الأسعار
- `cancel_orders`: إلغاء الطلبات
- `manage_users`: إدارة المستخدمين
- `manage_items`: إدارة الأصناف
- `manage_inventory`: إدارة المخزون

---

### 3️⃣ جدول الفئات (categories)
```sql
CREATE TABLE categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    display_order INTEGER NOT NULL DEFAULT 0,
    is_active INTEGER NOT NULL DEFAULT 1,
    created_at TEXT NOT NULL
);
```

**الفئات الأساسية:**
- شاورما لحم
- شاورما دجاج
- مشروبات
- إضافات
- مقبلات

---

### 4️⃣ جدول الأصناف (items)
```sql
CREATE TABLE items (
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
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT
);
```

---

### 5️⃣ جدول الطلبات (orders)
```sql
CREATE TABLE orders (
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
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

**حالات الطلب:**
- `pending`: قيد الانتظار
- `preparing`: قيد التحضير
- `ready`: جاهز
- `completed`: مكتمل
- `cancelled`: ملغي

---

### 6️⃣ جدول تفاصيل الطلبات (order_items)
```sql
CREATE TABLE order_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER NOT NULL,
    item_id INTEGER NOT NULL,
    item_name TEXT NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    unit_price REAL NOT NULL CHECK(unit_price >= 0),
    total_price REAL NOT NULL CHECK(total_price >= 0),
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES items(id)
);
```

---

### 7️⃣ جدول المواد الخام (raw_materials)
```sql
CREATE TABLE raw_materials (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    unit TEXT NOT NULL,
    current_quantity REAL NOT NULL DEFAULT 0 CHECK(current_quantity >= 0),
    min_quantity REAL NOT NULL DEFAULT 0,
    created_at TEXT NOT NULL,
    updated_at TEXT NOT NULL
);
```

**الوحدات:**
- كيلو
- لتر
- قطعة
- كرتون

---

### 8️⃣ جدول الوارد (purchases)
```sql
CREATE TABLE purchases (
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
    FOREIGN KEY (material_id) REFERENCES raw_materials(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);
```

---

### 9️⃣ جدول الصادر (consumption)
```sql
CREATE TABLE consumption (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    material_id INTEGER NOT NULL,
    quantity REAL NOT NULL CHECK(quantity > 0),
    consumption_type TEXT NOT NULL CHECK(consumption_type IN ('order', 'waste', 'other')),
    order_id INTEGER,
    notes TEXT,
    created_at TEXT NOT NULL,
    FOREIGN KEY (material_id) REFERENCES raw_materials(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
```

---

### 🔟 جدول ربط الأصناف بالمواد الخام (item_materials)
```sql
CREATE TABLE item_materials (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    item_id INTEGER NOT NULL,
    material_id INTEGER NOT NULL,
    quantity_required REAL NOT NULL CHECK(quantity_required > 0),
    FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE,
    FOREIGN KEY (material_id) REFERENCES raw_materials(id),
    UNIQUE(item_id, material_id)
);
```

---

## 🔗 العلاقات بين الجداول

```
users (1) ────────> (N) orders
categories (1) ────> (N) items
items (1) ─────────> (N) order_items
orders (1) ────────> (N) order_items
raw_materials (1) ─> (N) purchases
raw_materials (1) ─> (N) consumption
raw_materials (1) ─> (N) item_materials
items (1) ─────────> (N) item_materials
```

---

## 📇 الفهارس (Indexes) لتحسين الأداء

```sql
-- فهارس للبحث السريع
CREATE INDEX idx_items_category ON items(category_id);
CREATE INDEX idx_items_active ON items(is_active);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created ON orders(created_at);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_purchases_material ON purchases(material_id);
CREATE INDEX idx_purchases_date ON purchases(purchase_date);
CREATE INDEX idx_consumption_material ON consumption(material_id);
```

---

## 🎯 Triggers للعمليات التلقائية

### 1. تحديث المخزون عند الوارد
```sql
CREATE TRIGGER update_stock_on_purchase
AFTER INSERT ON purchases
BEGIN
    UPDATE raw_materials
    SET current_quantity = current_quantity + NEW.quantity,
        updated_at = datetime('now')
    WHERE id = NEW.material_id;
END;
```

### 2. تحديث المخزون عند الصادر
```sql
CREATE TRIGGER update_stock_on_consumption
AFTER INSERT ON consumption
BEGIN
    UPDATE raw_materials
    SET current_quantity = current_quantity - NEW.quantity,
        updated_at = datetime('now')
    WHERE id = NEW.material_id;
END;
```

### 3. خصم المواد عند إتمام الطلب
```sql
CREATE TRIGGER consume_materials_on_order_complete
AFTER UPDATE OF status ON orders
WHEN NEW.status = 'completed' AND OLD.status != 'completed'
BEGIN
    INSERT INTO consumption (material_id, quantity, consumption_type, order_id, created_at)
    SELECT
        im.material_id,
        oi.quantity * im.quantity_required,
        'order',
        NEW.id,
        datetime('now')
    FROM order_items oi
    JOIN item_materials im ON oi.item_id = im.item_id
    WHERE oi.order_id = NEW.id;
END;
```

---

## 🔄 Views للاستعلامات الشائعة

### 1. عرض الأصناف مع الفئات
```sql
CREATE VIEW v_items_with_categories AS
SELECT
    i.id,
    i.name,
    i.sell_price,
    i.cost_price,
    i.is_active,
    c.name as category_name,
    c.id as category_id
FROM items i
JOIN categories c ON i.category_id = c.id;
```

### 2. عرض الطلبات مع التفاصيل
```sql
CREATE VIEW v_orders_details AS
SELECT
    o.id,
    o.order_number,
    o.total,
    o.status,
    o.created_at,
    u.full_name as cashier_name,
    COUNT(oi.id) as items_count
FROM orders o
JOIN users u ON o.user_id = u.id
LEFT JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id;
```

### 3. عرض المخزون الحالي
```sql
CREATE VIEW v_inventory_status AS
SELECT
    id,
    name,
    unit,
    current_quantity,
    min_quantity,
    CASE
        WHEN current_quantity <= min_quantity THEN 'low'
        WHEN current_quantity <= min_quantity * 1.5 THEN 'warning'
        ELSE 'ok'
    END as stock_status
FROM raw_materials;
```

---

## 📊 بيانات افتراضية (Seed Data)

### المستخدم الافتراضي (admin)
```sql
INSERT INTO users (username, password_hash, full_name, role, created_at, updated_at)
VALUES ('admin', 'hashed_password', 'المدير العام', 'admin', datetime('now'), datetime('now'));
```

### الفئات الأساسية
```sql
INSERT INTO categories (name, display_order, created_at) VALUES
('شاورما لحم', 1, datetime('now')),
('شاورما دجاج', 2, datetime('now')),
('مشروبات', 3, datetime('now')),
('إضافات', 4, datetime('now')),
('مقبلات', 5, datetime('now'));
```

---

## 🔐 ملاحظات الأمان

1. **تشفير كلمات المرور:** استخدام bcrypt أو argon2
2. **النسخ الاحتياطي:** نسخ ملف .db بشكل دوري
3. **الصلاحيات:** فحص الصلاحيات قبل كل عملية حساسة
4. **SQL Injection:** استخدام Prepared Statements فقط

---

## 📈 قابلية التوسع المستقبلية

القاعدة مصممة للانتقال السلس إلى:
- MySQL / PostgreSQL
- Multi-tenant (عدة مطاعم)
- Cloud Sync
- Mobile Apps

---

**تم التصميم بواسطة:** Claude AI
**التاريخ:** 2026-01-17
**الإصدار:** 1.0
