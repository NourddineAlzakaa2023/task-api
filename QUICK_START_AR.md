# 🚀 دليل البدء السريع

## 📦 تثبيت التبعيات

```bash
dart pub get
```

## ▶️ تشغيل السيرفر

```bash
dart run bin/server.dart
```

السيرفر سيعمل على `http://localhost:8080`

## 🧪 اختبار API

### GET - جلب جميع المهام
```bash
curl http://localhost:8080/tasks
```

### POST - إنشاء مهمة جديدة
```bash
curl -X POST http://localhost:8080/tasks \
  -H "Content-Type: application/json" \
  -d "{\"title\": \"مهمة جديدة\"}"
```

### PUT - تحديث مهمة
```bash
curl -X PUT http://localhost:8080/tasks/1 \
  -H "Content-Type: application/json" \
  -d "{\"title\": \"مهمة محدثة\", \"completed\": true}"
```

### DELETE - حذف مهمة
```bash
curl -X DELETE http://localhost:8080/tasks/1
```

## 📤 النشر على GitHub

```bash
git init
git add .
git commit -m "Initial Task API"
git branch -M main
git remote add origin YOUR_GITHUB_REPO_URL
git push -u origin main
```

## ☁️ النشر على Replit

1. اذهب إلى [Replit](https://replit.com)
2. Create Repl → Import from GitHub
3. الصق رابط المستودع
4. اضغط Run ✅

## 📝 ملاحظات

- قاعدة البيانات SQLite تُنشأ تلقائياً في ملف `tasks.db`
- السيرفر يستمع على المنفذ المحدد في متغير البيئة `PORT` (افتراضياً 8080)
- CORS مفعّل للسماح بالطلبات من أي مصدر

