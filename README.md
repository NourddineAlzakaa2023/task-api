# Task API – Dart & Cloud

Simple REST API for managing tasks (CRUD).

## Tech Stack
- Dart
- Shelf
- SQLite
- Replit Cloud
- GitHub

## Endpoints
- GET    /tasks
- POST   /tasks        { "title": "My task" }
- PUT    /tasks/{id}   { "title": "Updated", "completed": true }
- DELETE /tasks/{id}

## Deployment
- Code hosted on GitHub
- API deployed to Replit

## Setup

```bash
# Install dependencies
dart pub get

# Run server
dart run bin/server.dart
```

## Testing with curl

```bash
# GET all tasks
curl http://localhost:8080/tasks

# CREATE task
curl -X POST http://localhost:8080/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "My first task"}'

# UPDATE task
curl -X PUT http://localhost:8080/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Updated task", "completed": true}'

# DELETE task
curl -X DELETE http://localhost:8080/tasks/1
```

