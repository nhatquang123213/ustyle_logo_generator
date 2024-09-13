# Quang_Le
Build Canvas Editor for UStyle Project: AI Logo Generator
https://app.ustyle.pro

# Multi-touch Canvas with Flutter

If you ever wanted to create a canvas in [Flutter](https://flutter.dev) that needs to be panned in any direction and allow zoom then you also probably tried to create a [MultiGestureRecognizer](https://api.flutter.dev/flutter/gestures/MultiDragGestureRecognizer-class.html) or under a [GestureDetector](https://api.flutter.dev/flutter/widgets/GestureDetector-class.html) added onPanUpdate and onScaleUpdate and received an error because both can not work at the same time. Even if you have to GestureDetectors then you will still find it does not work how you want and one will always win.

This is the canvas rendering logic used in https://widget.studio

## Multi Touch Goal

* Pan the canvas with two or more fingers
* Zoom the canvas with two fingers only (Pinch/Zoom)
* Single finger will interact with canvas object and detect selection
* Bonus trackpad support with similar results

In order to achieve this we need to use a Listener for the trackpad events and raw touch interactions and  [RawKeyboardListener](https://api.flutter.dev/flutter/widgets/RawKeyboardListener-class.html) for keyboard shortcuts.
