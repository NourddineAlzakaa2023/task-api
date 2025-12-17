# Node.js Express Setup Guide

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Run the Server
```bash
npm start
```

Or:
```bash
node index.js
```

### 3. Test the API

The server will start on port 5000 (or the port specified in `process.env.PORT`).

#### Test with curl:
```bash
# Get welcome message
curl http://localhost:5000/

# Get all tasks
curl http://localhost:5000/tasks

# Create a task
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "My first task"}'

# Update a task
curl -X PUT http://localhost:5000/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Updated task", "completed": true}'

# Delete a task
curl -X DELETE http://localhost:5000/tasks/1
```

## Deployment on Replit

1. Upload `index.js` and `package.json` to your Replit project
2. Replit will automatically detect Node.js and install dependencies
3. The server will start automatically using the `start` script
4. Replit will provide a public URL automatically

## Features

- ✅ Express.js framework
- ✅ CORS enabled for cross-origin requests
- ✅ Listens on `process.env.PORT` (default: 5000)
- ✅ Binds to `0.0.0.0` for Replit compatibility
- ✅ In-memory storage (easy to replace with database)
- ✅ All CRUD endpoints implemented
- ✅ Welcome endpoint to avoid 404 errors
- ✅ Input validation
- ✅ Proper error handling

## API Endpoints

- `GET /` - Welcome message with API documentation
- `GET /tasks` - Get all tasks
- `POST /tasks` - Create a new task (requires `{"title": "Task title"}`)
- `PUT /tasks/:id` - Update a task (requires `{"title": "Updated title", "completed": true/false}`)
- `DELETE /tasks/:id` - Delete a task

## Future Database Integration

The `TaskService` class is structured to be easily replaced with a database. Simply:

1. Install your preferred database library (e.g., `pg` for PostgreSQL, `mysql2` for MySQL, `mongodb` for MongoDB)
2. Replace the in-memory array operations with database queries
3. Keep the same method signatures for seamless integration

Example structure for database integration:
```javascript
// Replace TaskService with DatabaseService
class DatabaseService {
  async getAllTasks() {
    // Database query here
  }
  
  async createTask(title) {
    // Database insert here
  }
  
  // ... etc
}
```

