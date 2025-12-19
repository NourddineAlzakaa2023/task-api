# Task API – Node.js & Express

Simple REST API for managing tasks (CRUD) built with Node.js and Express.

## Tech Stack
- Node.js
- Express.js
- CORS middleware
- Replit Cloud
- GitHub

## Features
- ✅ RESTful API with CRUD operations
- ✅ CORS enabled for cross-origin requests
- ✅ In-memory storage (ready for database integration)
- ✅ Input validation and error handling
- ✅ Replit-ready deployment

## Endpoints
- `GET /` - Welcome message with API documentation
- `GET /tasks` - Get all tasks
- `POST /tasks` - Create a new task (requires `{"title": "Task title"}`)
- `PUT /tasks/:id` - Update a task (requires `{"title": "Updated title", "completed": true/false}`)
- `DELETE /tasks/:id` - Delete a task

## Setup

### Install Dependencies
```bash
npm install
```

### Run Server
```bash
npm start
```

The server will start on port 5000 (or the port specified in `process.env.PORT`).

## Testing with curl

```bash
# GET welcome message
curl http://localhost:5000/

# GET all tasks
curl http://localhost:5000/tasks

# CREATE task
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "My first task"}'

# UPDATE task
curl -X PUT http://localhost:5000/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title": "Updated task", "completed": true}'

# DELETE task
curl -X DELETE http://localhost:5000/tasks/1
```

## Deployment

### Replit
1. Upload `index.js` and `package.json` to your Replit project
2. Replit will automatically detect Node.js and install dependencies
3. The server will start automatically using the `start` script
4. Replit will provide a public URL automatically

**⚠️ Important: SSL Certificate Warning**

If you see `ERR_CERT_COMMON_NAME_INVALID` error:

1. **Quick Fix**: Click "Advanced" → "Proceed to [your-url].replit.app (unsafe)"
2. **Best Solution**: Change your Repl name from generic names like `workspace` to a unique name (e.g., `my-task-api`)
3. **Get Correct URL**: Use the "Open in Browser" button in Replit's Webview panel to get the actual URL (Replit sometimes adds random numbers like `workspace-00.replit.app`)

**💡 Tip for Presentations**: Always click "Run" in Replit before showing the API to ensure the server is active (free tier servers sleep after inactivity).

### Environment Variables
- `PORT` - Server port (default: 5000)
- `REPL_SLUG` - Replit slug (automatically set by Replit)
- `REPL_OWNER` - Replit owner (automatically set by Replit)

## Project Structure
```
.
├── index.js           # Main server file
├── package.json       # Dependencies and scripts
├── .gitignore        # Git ignore rules
└── README.md         # This file
```

## Future Enhancements
- Database integration (PostgreSQL, MySQL, MongoDB, etc.)
- Authentication and authorization
- Rate limiting
- Request logging
- API documentation (Swagger/OpenAPI)

