package com.example.graphicalprimitivesdemo

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.util.DisplayMetrics
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager

class DrawView(context: Context) : View(context) {

    // Screen dimensions
    private val displayMetrics = DisplayMetrics()
    private val screenWidth: Int
    private val screenHeight: Int

    // Paint objects for different shapes
    private val circlePaint = Paint().apply {
        color = Color.RED
        style = Paint.Style.FILL
        isAntiAlias = true
    }

    private val rectanglePaint = Paint().apply {
        color = Color.BLUE
        style = Paint.Style.FILL
        isAntiAlias = true
    }

    private val linePaint = Paint().apply {
        color = Color.GREEN
        strokeWidth = 10f
        style = Paint.Style.STROKE
        isAntiAlias = true
    }

    // List to store touch positions for drawing circles
    private val touchPositions = mutableListOf<Pair<Float, Float>>()

    init {
        // Get screen dimensions
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        windowManager.defaultDisplay.getMetrics(displayMetrics)
        screenWidth = displayMetrics.widthPixels
        screenHeight = displayMetrics.heightPixels
    }

    override fun onDraw(canvas: Canvas) {
        super.onDraw(canvas)

        // Set background color
        canvas.drawColor(Color.BLACK)

        // Draw static shapes for Exercise 1

        // Draw a red circle (positioned relative to screen size)
        val circleX = screenWidth * 0.25f
        val circleY = screenHeight * 0.2f
        val circleRadius = screenWidth * 0.1f
        canvas.drawCircle(circleX, circleY, circleRadius, circlePaint)

        // Draw a blue rectangle (positioned relative to screen size)
        val rectLeft = screenWidth * 0.5f
        val rectTop = screenHeight * 0.1f
        val rectRight = screenWidth * 0.9f
        val rectBottom = screenHeight * 0.3f
        canvas.drawRect(rectLeft, rectTop, rectRight, rectBottom, rectanglePaint)

        // Draw a green line (positioned relative to screen size)
        val lineStartX = screenWidth * 0.1f
        val lineStartY = screenHeight * 0.4f
        val lineEndX = screenWidth * 0.9f
        val lineEndY = screenHeight * 0.4f
        canvas.drawLine(lineStartX, lineStartY, lineEndX, lineEndY, linePaint)

        // Draw circles at touch positions for Exercise 2
        for (position in touchPositions) {
            canvas.drawCircle(position.first, position.second, circleRadius, circlePaint)
        }
    }

    override fun onTouchEvent(event: MotionEvent): Boolean {
        // Handle touch events for Exercise 2
        when (event.action) {
            MotionEvent.ACTION_DOWN -> {
                // Store the touch position
                touchPositions.add(Pair(event.x, event.y))

                // Redraw the screen
                invalidate()
                return true
            }
        }
        return super.onTouchEvent(event)
    }
}