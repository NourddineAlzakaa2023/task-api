# 📡 أمثلة استخدام API

## 🌐 Base URL
- محلي: `http://localhost:8080`
- Replit: `https://YOUR_REPL_NAME.YOUR_USERNAME.repl.co`

---

## 1️⃣ GET /tasks
جلب جميع المهام

### cURL
```bash
curl http://localhost:8080/tasks
```

### JavaScript (Fetch)
```javascript
fetch('http://localhost:8080/tasks')
  .then(res => res.json())
  .then(data => console.log(data));
```

### Response
```json
[
  {
    "id": 1,
    "title": "My first task",
    "completed": false
  }
]
```

---

## 2️⃣ POST /tasks
إنشاء مهمة جديدة

### cURL
```bash
curl -X POST http://localhost:8080/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "My new task"}'
```

### JavaScript (Fetch)
```javascript
fetch('http://localhost:8080/tasks', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ title: 'My new task' })
})
  .then(res => res.json())
  .then(data => console.log(data));
```

### Request Body
```json
{
  "title": "My new task"
}
```

### Response
```json
{
  "id": 1,
  "title": "My new task",
  "completed": false
}
```

---

## 3️⃣ PUT /tasks/{id}
تحديث مهمة موجودة

### cURL
```bash
curl -X PUT http://localhost:8080/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Updated task", "completed": true}'
```

### JavaScript (Fetch)
```javascript
fetch('http://localhost:8080/tasks/1', {
  method: 'PUT',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ 
    title: 'Updated task', 
    completed: true 
  })
})
  .then(res => res.json())
  .then(data => console.log(data));
```

### Request Body
```json
{
  "title": "Updated task",
  "completed": true
}
```

### Response
```json
{
  "id": 1,
  "title": "Updated task",
  "completed": true
}
```

---

## 4️⃣ DELETE /tasks/{id}
حذف مهمة

### cURL
```bash
curl -X DELETE http://localhost:8080/tasks/1
```

### JavaScript (Fetch)
```javascript
fetch('http://localhost:8080/tasks/1', {
  method: 'DELETE'
})
  .then(res => res.json())
  .then(data => console.log(data));
```

### Response
```json
{
  "success": true
}
```

---

## 🧪 اختبار كامل (سكربت)

### PowerShell
```powershell
# إنشاء مهمة
$task = Invoke-RestMethod -Uri "http://localhost:8080/tasks" `
  -Method POST `
  -ContentType "application/json" `
  -Body '{"title": "Test task"}'

Write-Host "Created task: $($task.id)"

# جلب جميع المهام
$tasks = Invoke-RestMethod -Uri "http://localhost:8080/tasks"
Write-Host "Total tasks: $($tasks.Count)"

# تحديث المهمة
$updated = Invoke-RestMethod -Uri "http://localhost:8080/tasks/$($task.id)" `
  -Method PUT `
  -ContentType "application/json" `
  -Body '{"title": "Updated", "completed": true}'
Write-Host "Updated: $($updated.title)"

# حذف المهمة
Invoke-RestMethod -Uri "http://localhost:8080/tasks/$($task.id)" -Method DELETE
Write-Host "Deleted task"
```

