# 🚀 دليل النشر على Replit

## الخطوات السريعة

### 1️⃣ رفع المشروع على GitHub

```bash
cd C:\Users\DELL\Desktop\flutter_projet\task_api

# تهيئة Git
git init
git add .
git commit -m "Initial Task API"

# ربط مع GitHub (استبدل YOUR_USERNAME و YOUR_REPO_NAME)
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git push -u origin main
```

### 2️⃣ النشر على Replit

1. اذهب إلى [Replit](https://replit.com)
2. اضغط على **"Create Repl"**
3. اختر **"Import from GitHub"**
4. الصق رابط المستودع: `https://github.com/YOUR_USERNAME/YOUR_REPO_NAME`
5. اضغط **"Import"**
6. Replit سيقوم تلقائياً بـ:
   - تثبيت التبعيات (`dart pub get`)
   - تشغيل السيرفر (`dart run bin/server.dart`)

### 3️⃣ الحصول على URL العام

- بعد التشغيل، Replit سيعطيك رابط مثل:
  - `https://YOUR_REPL_NAME.YOUR_USERNAME.repl.co`
- استخدم هذا الرابط للوصول إلى API من أي مكان

### 4️⃣ اختبار API

```bash
# GET all tasks
curl https://YOUR_REPL_NAME.YOUR_USERNAME.repl.co/tasks

# CREATE task
curl -X POST https://YOUR_REPL_NAME.YOUR_USERNAME.repl.co/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "My first task"}'
```

## ✅ النتيجة

- ✅ API شغال على السحابة
- ✅ قاعدة بيانات SQLite محلية
- ✅ CRUD كامل
- ✅ CORS مفعّل
- ✅ جاهز للاستخدام من أي مكان

