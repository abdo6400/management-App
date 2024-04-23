package com.ama.baraneq

import io.flutter.embedding.android.FlutterActivity
import android.graphics.Color
import android.graphics.PorterDuff
import android.graphics.drawable.Drawable
import android.os.Bundle
import java.util.Random
import android.view.View
class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Get the background item
val backgroundItem: View? = findViewById<View>(R.id.background_item)

// Generate a random number between 0 and 1
val random = Random()
val randomNumber = random.nextInt(2)

// Set the background color based on the random number
if (randomNumber == 0) {
    backgroundItem?.background?.setColorFilter(Color.parseColor("#B3C8CF"), PorterDuff.Mode.SRC)
} else {
    backgroundItem?.background?.setColorFilter(Color.WHITE, PorterDuff.Mode.SRC)
}

    }
}
