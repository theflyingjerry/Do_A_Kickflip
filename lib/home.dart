import 'package:flutter/material.dart';
import "dart:math";

class TrickListSelect extends StatefulWidget {
  @override
  _TrickListSelectState createState() => _TrickListSelectState();
}

class _TrickListSelectState extends State<TrickListSelect> {
  String trick = 'KICKFLIP';
  List history = ['No Tricks Done'];
  Map data = {};
  int selectedIndex = 1;
  String lastTrick = 'KICKFLIP';
  bool trickDone = false;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 70.0, 16.0, 300),
            child: Container(
              height: 125,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    while (trick == lastTrick) {
                      trick = trickSelector(
                          data['transition'],
                          trickDone,
                          data['streetTricks'],
                          data['transitionTricks'],
                          history);
                    }
                    addToHistory();
                    lastTrick = trick;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 0.0),
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Do a...',
                            style: TextStyle(fontSize: 28, letterSpacing: 1.5)),
                        SizedBox(height: 12.0),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            trick,
                            softWrap: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: ([
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ]),
          backgroundColor: Colors.blue,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.white,
          onTap: itemSelected),
    );
  }

  String trickSelector(bool tranny, bool justStarted, List listValue1,
      List listValue2, List history) {
    final random = new Random();

    if (tranny == false) {
      if (listValue1.isNotEmpty) {
        var i = random.nextInt(listValue1.length);
        return listValue1[i];
      } else {
        return 'KICKFLIP';
      }
    } else {
      if (listValue2.isNotEmpty) {
        var j = random.nextInt(listValue2.length);
        return listValue2[j];
      } else {
        return 'KICKFLIP';
      }
    }
  }

  itemSelected(int index) async {
    if (index == 0) {
      dynamic result =
          await Navigator.pushNamed(context, '/history', arguments: history);
      setState(() {
        history = result;
        if (result[0] == 'No Tricks Done') {
          trickDone = false;
        }
      });
    } else if (index == 2) {
      dynamic result =
          await Navigator.pushNamed(context, '/settings', arguments: {
        'transition': data['transition'],
        'streetTricks': data['streetTricks'],
        'transitionTricks': data['transitionTricks']
      });
      setState(() {
        data['transition'] = result['transition'];
      });
    }
  }

  addToHistory() {
    if (trickDone == false) {
      history.removeLast();
      setState(() {
        trickDone = true;
      });
    }
    history.insert(0, trick);
    if (history.length > 5) {
      history.removeLast();
    }
  }
}
