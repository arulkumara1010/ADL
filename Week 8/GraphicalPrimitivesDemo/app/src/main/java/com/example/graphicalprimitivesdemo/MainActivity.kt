package com.example.graphicalprimitivesdemo

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import android.widget.FrameLayout

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Create a FrameLayout as the root view
        val frameLayout = FrameLayout(this)

        // Add DrawView to the FrameLayout
        frameLayout.addView(DrawView(this))

        // Set the FrameLayout as the content view
        setContentView(frameLayout)
    }
}