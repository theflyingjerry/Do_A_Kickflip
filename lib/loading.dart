import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skate_trick_selector/initializer.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setUpTricks() async {
    await Future.delayed(Duration(seconds: 1));
    bool transition = false;
    Map<String, dynamic> spaceholder = {};
    JSONReader initialData = JSONReader(newTrickMap: spaceholder);
    //initialData.writeJSON(initialData.initialTrickMap);
    Map data = await initialData.readJSON();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'transition': transition,
      'streetTricks': data['streetTricks'],
      'transitionTricks': data['transitionTricks']
    });
  }

  @override
  void initState() {
    super.initState();
    setUpTricks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (Center(
            child: SpinKitDoubleBounce(
      color: Colors.blue,
      size: 50.0,
    ))));
  }
}
