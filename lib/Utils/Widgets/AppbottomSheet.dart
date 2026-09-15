import 'package:flutter/material.dart';

class AppBottomSheet extends StatefulWidget {
  const AppBottomSheet({super.key});

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet>
    with SingleTickerProviderStateMixin {
  double _currentSliderValue = 0.0;
  final double _startCount = 0.0;
  final double _endCount = 100.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isShow = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isShow == false
          ? IconButton(
              onPressed: () {
                setState(() {
                  isShow = true;
                });
                _controller.forward();
                //
              },
              icon: const Icon(Icons.keyboard_arrow_up))
          : const SizedBox.shrink(),
      bottomSheet:
          //         isShow == false?
          //         IconButton(onPressed: (){
          // _controller.forward();
          //
          //         }, icon: Icon(Icons.cabin)):
          AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          print(_controller.value);
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              height: _animation.value * 250,
              // Adjust height based on animation value
              color: Colors.black87,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: IconButton(
                        onPressed: () {
                          _controller.reverse().whenComplete(() {
                            setState(() {
                              isShow = false;
                            });
                          });
                        },
                        icon: const Icon(Icons.keyboard_arrow_down)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Slider(
                        inactiveColor: Colors.grey,
                        activeColor: Colors.white,
                        thumbColor: Colors.black,
                        value: _currentSliderValue,
                        min: _startCount,
                        max: _endCount,
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_currentSliderValue.roundToDouble()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '$_endCount',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Album Name',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Artist Name',
                    style: TextStyle(fontSize: 14.0, color: Colors.yellow),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.sync, color: Colors.yellow),
                        onPressed: () {
                          setState(() {});
                        },
                      ),
                      //     : IconButton(
                      //   icon: Icon(Icons.sync, color: Colors.white),
                      //   onPressed: () {
                      //     setState(() {
                      //       istap = true;
                      //     });
                      //   },
                      // ),
                      IconButton(
                        icon: const Icon(Icons.skip_previous, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.pause, color: Colors.white),
                        onPressed: () {},
                      ),
                      //     : IconButton(
                      //   icon: Icon(Icons.play_arrow,
                      //       color: Colors.white),
                      //   onPressed: () {},
                      // ),
                      IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shuffle,
                          color: Colors.yellow,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('Bottom Sheet Demo'),
      ),
    );
  }
}
