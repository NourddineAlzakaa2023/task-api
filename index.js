const express = require('express');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// In-memory task storage (can be replaced with database later)
class TaskService {
  constructor() {
    this.tasks = [];
    this.nextId = 1;
  }

  getAllTasks() {
    return this.tasks;
  }

  createTask(title) {
    const task = {
      id: this.nextId++,
      title: title,
      completed: false
    };
    this.tasks.push(task);
    return task;
  }

  updateTask(id, title, completed) {
    const taskIndex = this.tasks.findIndex(t => t.id === id);
    if (taskIndex === -1) return null;

    const updatedTask = {
      id: id,
      title: title,
      completed: completed
    };
    this.tasks[taskIndex] = updatedTask;
    return updatedTask;
  }

  deleteTask(id) {
    const taskIndex = this.tasks.findIndex(t => t.id === id);
    if (taskIndex === -1) return false;

    this.tasks.splice(taskIndex, 1);
    return true;
  }
}

const taskService = new TaskService();

// Routes

// GET / - Welcome message
app.get('/', (req, res) => {
  res.json({
    message: 'Welcome to the Task API!',
    endpoints: {
      'GET /tasks': 'Get all tasks',
      'POST /tasks': 'Create a new task',
      'PUT /tasks/:id': 'Update a task',
      'DELETE /tasks/:id': 'Delete a task'
    },
    example: '/tasks'
  });
});

// GET /tasks - Get all tasks
app.get('/tasks', (req, res) => {
  const tasks = taskService.getAllTasks();
  res.json(tasks);
});

// POST /tasks - Create a new task
app.post('/tasks', (req, res) => {
  const { title } = req.body;

  if (!title || typeof title !== 'string' || title.trim() === '') {
    return res.status(400).json({ error: 'Title is required and must be a non-empty string' });
  }

  const task = taskService.createTask(title.trim());
  res.status(201).json(task);
});

// PUT /tasks/:id - Update a task
app.put('/tasks/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const { title, completed } = req.body;

  if (isNaN(id)) {
    return res.status(400).json({ error: 'Invalid task ID' });
  }

  if (!title || typeof title !== 'string' || title.trim() === '') {
    return res.status(400).json({ error: 'Title is required and must be a non-empty string' });
  }

  if (typeof completed !== 'boolean') {
    return res.status(400).json({ error: 'Completed must be a boolean' });
  }

  const task = taskService.updateTask(id, title.trim(), completed);

  if (!task) {
    return res.status(404).json({ error: 'Task not found' });
  }

  res.json(task);
});

// DELETE /tasks/:id - Delete a task
app.delete('/tasks/:id', (req, res) => {
  const id = parseInt(req.params.id);

  if (isNaN(id)) {
    return res.status(400).json({ error: 'Invalid task ID' });
  }

  const success = taskService.deleteTask(id);

  if (!success) {
    return res.status(404).json({ error: 'Task not found' });
  }

  res.json({ success: true });
});

// Start server
const PORT = process.env.PORT || 5000;
const HOST = '0.0.0.0';

app.listen(PORT, HOST, () => {
  // Check if running on Replit
  const replSlug = process.env.REPL_SLUG;
  const replOwner = process.env.REPL_OWNER;
  const isReplit = replSlug && replOwner;

  // Print server info
  console.log('\n' + '='.repeat(50));
  console.log(`✅ Server running on port ${PORT}`);
  console.log('='.repeat(50));

  if (isReplit) {
    // Replit deployment
    const replitUrl = `https://${replSlug}.${replOwner}.repl.co`;
    console.log('\n🌍 Public API URL (Replit):');
    console.log(`  ${replitUrl}`);
    console.log('\n📡 API Endpoints:');
    console.log(`  GET    ${replitUrl}/          (Welcome message)`);
    console.log(`  GET    ${replitUrl}/tasks`);
    console.log(`  POST   ${replitUrl}/tasks`);
    console.log(`  PUT    ${replitUrl}/tasks/{id}`);
    console.log(`  DELETE ${replitUrl}/tasks/{id}`);
  } else {
    // Local development
    const localhostUrl = `http://localhost:${PORT}`;
    console.log('\n🌐 Base URLs:');
    console.log(`  Local:    ${localhostUrl}`);
    console.log(`  Android:  http://10.0.2.2:${PORT} (for Android Emulator)`);
    console.log('\n📡 API Endpoints:');
    console.log(`  GET    ${localhostUrl}/          (Welcome message)`);
    console.log(`  GET    ${localhostUrl}/tasks`);
    console.log(`  POST   ${localhostUrl}/tasks`);
    console.log(`  PUT    ${localhostUrl}/tasks/{id}`);
    console.log(`  DELETE ${localhostUrl}/tasks/{id}`);
  }

  console.log('\n' + '='.repeat(50) + '\n');
});

