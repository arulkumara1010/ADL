"use client";

import { useEffect, useState } from "react";
import { addTask, getTasks, updateTask, deleteTask } from "./actions";

type Task = {
  id: number;
  title: string;
  completed: boolean;
};

export default function Home() {
  const [tasks, setTasks] = useState<Task[]>([]);
  const [newTask, setNewTask] = useState("");

  async function loadTasks() {
    const tasks = await getTasks();
    setTasks(tasks);
  }

  useEffect(() => {
    loadTasks();
  }, []);

  const handleAddTask = async () => {
    if (!newTask.trim()) return;
    await addTask(newTask);
    setNewTask("");
    loadTasks();
  };

  const handleToggleComplete = async (id: number, completed: boolean) => {
    await updateTask(id, !completed);
    loadTasks();
  };

  const handleDelete = async (id: number) => {
    await deleteTask(id);
    loadTasks();
  };

  return (
    <main className="flex items-center justify-center min-h-screen bg-gray-100">
      <div className="w-full max-w-md bg-white p-6 rounded-xl shadow-lg">
        <h1 className="text-2xl font-semibold text-center mb-4 text-black">
          ✅ To-Do List
        </h1>

        <div className="flex gap-2 mb-4">
          <input
            type="text"
            className="w-full border border-gray-300 rounded-lg p-2 focus:outline-none focus:ring-2 focus:ring-blue-400 text-black placeholder-gray-400"
            placeholder="Add a new task..."
            value={newTask}
            onChange={(e) => setNewTask(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") {
                handleAddTask();
              }
            }}
          />
          <button
            className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition"
            onClick={handleAddTask}
          >
            Add
          </button>
        </div>

        <ul className="space-y-2">
          {tasks.map((task) => (
            <li
              key={task.id}
              className="flex justify-between items-center bg-gray-50 p-3 rounded-lg shadow-sm hover:bg-gray-100 transition"
            >
              <span
                className={`cursor-pointer flex-1 ${
                  task.completed
                    ? "line-through text-gray-400"
                    : "text-gray-800"
                }`}
                onClick={() => handleToggleComplete(task.id, task.completed)}
              >
                {task.title}
              </span>
              <button
                className="text-red-500 hover:text-red-700 transition"
                onClick={() => handleDelete(task.id)}
              >
                Delete
              </button>
            </li>
          ))}
        </ul>

        {tasks.length === 0 && (
          <p className="text-gray-500 text-center mt-4">No tasks added yet.</p>
        )}
      </div>
    </main>
  );
}
