import 'package:flutter/material.dart';

class WrapperDetect extends StatefulWidget {
  const WrapperDetect({super.key, required this.child});
  final Widget child;

  @override
  State<WrapperDetect> createState() => _WrapperDetectState();
}

class _WrapperDetectState extends State<WrapperDetect>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    //add an observer to monitor the widget lyfecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    //don't forget to dispose of it when not needed anymore
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late AppLifecycleState _lastState;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('😀 state: $state');
    if (state == AppLifecycleState.resumed &&
        _lastState == AppLifecycleState.paused) {
      //now you know that your app went to the background and is back to the foreground
    }
    if (state == AppLifecycleState.inactive) {
      _runAsync();
    }
    _lastState =
        state; //register the last state. When you get "paused" it means the app went to the background.
  }

  Future<void> _runAsync() async {
    // for (var i = 0; i < 1000; i++) {
    //   print('😀 count: $i');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
