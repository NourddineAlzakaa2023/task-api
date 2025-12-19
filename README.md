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

The server will start on port 8080 (or the port specified in `process.env.PORT`).

## Testing with curl

```bash
# GET welcome message
curl http://localhost:8080/

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

## Deployment

### Replit
1. Upload `index.js` and `package.json` to your Replit project
2. Run `npm install` in the Shell to install dependencies
3. Click "Run" button - the server will start automatically
4. Replit will provide a public URL automatically

**⚠️ Troubleshooting Webview Issues**

If the Webview doesn't open or shows "Refused to connect":

1. **Check Server is Running**: 
   - Look for `✅ Server running on port 8080` in the console
   - Test locally: `curl http://localhost:8080/` in Shell

2. **Change Repl Name** (Recommended):
   - Click on the Repl name (e.g., `workspace`) at the top
   - Change to a unique name like `my-task-api` or `doctor-api-test`
   - Click "Stop" then "Run" again
   - Wait 10 seconds for the new URL to be ready

3. **SSL Certificate Warning** (`ERR_CERT_COMMON_NAME_INVALID`):
   - Click "Advanced" → "Proceed to [your-url].replit.app (unsafe)"
   - Or change Repl name to avoid certificate conflicts

4. **Get Correct URL**:
   - Use the "Open in Browser" button in Replit's Webview panel
   - Replit sometimes adds random numbers (e.g., `workspace-00.replit.app`)

**💡 Tip for Presentations**: 
- Always click "Run" in Replit before showing the API
- Wait 10-15 seconds after clicking Run
- Use a unique Repl name (not `workspace`) to avoid SSL issues
- Test the URL in the Shell first: `curl http://localhost:8080/tasks`

### Environment Variables
- `PORT` - Server port (default: 8080, Replit's most stable port)
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

