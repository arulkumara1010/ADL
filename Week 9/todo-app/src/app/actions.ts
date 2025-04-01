"use server";

import prisma from "@/lib/prisma";

// Add Task
export async function addTask(title: string) {
  await prisma.task.create({
    data: { title },
  });
}

// Get Tasks
export async function getTasks() {
  return await prisma.task.findMany({ orderBy: { createdAt: "desc" } });
}

// Update Task
export async function updateTask(id: number, completed: boolean) {
  await prisma.task.update({
    where: { id },
    data: { completed },
  });
}

// Delete Task
export async function deleteTask(id: number) {
  await prisma.task.delete({ where: { id } });
}
