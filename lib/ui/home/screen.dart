import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../src/classes/canvas_object.dart';
import '../../src/controllers/canvas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = CanvasController();

  @override
  void initState() {
    _controller.init();
    _dummyData();
    super.initState();
  }

  void _dummyData() {
    _controller.addObject(
      CanvasObject(
        dx: 20,
        dy: 20,
        child: Container(
          color: Colors.red,
          width: 100,
          height: 100,
          child: Center(
            child: Text(
              "Logo",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
    _controller.addObject(
      CanvasObject(
        dx: 80,
        dy: 60,
        child: Text(
          "Logo Name",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    _controller.addObject(
      CanvasObject(
        dx: 100,
        dy: 40,
        child: Text(
          "Logo Description",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CanvasController>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final instance = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              actions: [
                FocusScope(
                  canRequestFocus: false,
                  child: IconButton(
                    tooltip: 'Selection',
                    icon: Icon(Icons.select_all),
                    color: instance?.shiftPressed ?? false
                        ? Theme.of(context).hintColor
                        : null,
                    onPressed: _controller.shiftSelect,
                  ),
                ),
                FocusScope(
                  canRequestFocus: false,
                  child: IconButton(
                    tooltip: 'Meta Key',
                    color: instance?.metaPressed ?? false
                        ? Theme.of(context).hintColor
                        : null,
                    icon: Icon(Icons.category),
                    onPressed: _controller.metaSelect,
                  ),
                ),
                FocusScope(
                  canRequestFocus: false,
                  child: IconButton(
                    tooltip: 'Zoom In',
                    icon: Icon(Icons.zoom_in),
                    onPressed: _controller.zoomIn,
                  ),
                ),
                FocusScope(
                  canRequestFocus: false,
                  child: IconButton(
                    tooltip: 'Zoom Out',
                    icon: Icon(Icons.zoom_out),
                    onPressed: _controller.zoomOut,
                  ),
                ),
                FocusScope(
                  canRequestFocus: false,
                  child: IconButton(
                    tooltip: 'Reset the Scale and Offset',
                    icon: Icon(Icons.restore),
                    onPressed: _controller.reset,
                  ),
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () => _controller.unSelectObject(),
              child: Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerSignal: (details) {
                    print('onPointerSignal');
                    if (details is PointerScrollEvent) {
                      GestureBinding.instance.pointerSignalResolver
                          .register(details, (event) {
                        if (event is PointerScrollEvent) {
                          if (_controller.shiftPressed) {
                            double zoomDelta = (-event.scrollDelta.dy / 300);
                            _controller.scale = _controller.scale + zoomDelta;
                          } else {
                            _controller.offset =
                                _controller.offset - event.scrollDelta;
                          }
                        }
                      });
                    }
                  },
                  onPointerMove: (details) {
                    print('onPointerMove');
                    _controller.updateTouch(
                      details.pointer,
                      details.localPosition,
                      details.position,
                    );
                  },
                  onPointerDown: (details) {
                    print('onPointerDown${details.localPosition.dx}');
                    _controller.addTouch(
                      details.pointer,
                      details.localPosition,
                      details.position,
                    );
                  },
                  onPointerUp: (details) {
                    print('onPointerUp${details.localPosition.dx}');
                    _controller.removeTouch(details.pointer);
                  },
                  onPointerCancel: (details) {
                    print('onPointerCancel');
                    _controller.removeTouch(details.pointer);
                  },
                  child: RawKeyboardListener(
                    autofocus: true,
                    focusNode: _controller.focusNode,
                    onKey: (key) => _controller.rawKeyEvent(context, key),
                    child: SizedBox.expand(
                      child: Stack(
                        children: [
                          for (var i = instance!.objects.length - 1;
                              i > -1;
                              i--)
                            Positioned(
                              left: instance.objects[i].dx,
                              top: instance.objects[i].dy,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                  color: instance.isObjectSelected(i)
                                      ? Colors.grey
                                      : Colors.transparent,
                                )),
                                child: GestureDetector(
                                  onTapDown: (_) => _controller.selectObject(i),
                                  child: SizedBox(
                                    child: instance.objects[i].child,
                                  ),
                                ),
                              ),
                            ),
                          if (instance.marquee != null)
                            Positioned.fromRect(
                              rect: instance.marquee!.rect
                                  .adjusted(instance.offset, instance.scale),
                              child: Container(
                                color: Colors.blueAccent.withOpacity(0.3),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

extension RectUtils on Rect {
  Rect adjusted(Offset offset, double scale) {
    final left = (this.left + offset.dx) * scale;
    final top = (this.top + offset.dy) * scale;
    final width = this.width * scale;
    final height = this.height * scale;
    return Rect.fromLTWH(left, top, width, height);
  }
}
