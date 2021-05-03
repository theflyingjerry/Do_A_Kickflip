import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:skate_trick_selector/initializer.dart';
//import 'package:skate_trick_selector/main.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Map data1 = {};
  JSONReader saveJSON;
  List displayList;
  @override
  Widget build(BuildContext context) {
    data1 = ModalRoute.of(context).settings.arguments;
    saveJSON = JSONReader(newTrickMap: data1);
    displayDetermine();
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context, {
                'transition': data1['transition'],
                'streetTricks': data1['streetTricks'],
                'transitionTricks': data1['transitionTricks']
              });
            },
          ),
          title: Text('Settings'),
          centerTitle: true,
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10, 0, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('  Street  '),
                Switch(
                    value: data1['transition'],
                    onChanged: (value) {
                      setState(() {
                        data1['transition'] = value;
                      });
                    }),
                Text('Transition')
              ],
            ),
          ),
          Divider(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              child: Text('Save'),
              onPressed: () {
                saveJSON.writeJSON(saveJSON.newTrickMap);
              },
            ),
            TextButton(
              child: Text('Reset'),
              onPressed: () {
                saveJSON.writeJSON(saveJSON.initialTrickMap);
                Phoenix.rebirth(context);
              },
            ),
            TextButton(
              child: Text('Add Tricks'),
              onPressed: () async {
                dynamic result =
                    await Navigator.pushNamed(context, '/enter', arguments: {
                  'transition': data1['transition'],
                  'streetTricks': data1['streetTricks'],
                  'transitionTricks': data1['transitionTricks']
                });
                setState(() {
                  data1 = {
                    'streetTricks': result['streetTrickS'],
                    'transitionTricks': result['transitionTricks']
                  };
                });
              },
            ),
          ]),
          Divider(height: 10.0),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                      child: Card(
                          child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (data1['transition'] == false) {
                              data1['streetTricks']
                                  .remove(data1['streetTricks'][index]);
                            } else {
                              data1['transitionTricks']
                                  .remove(data1['transitionTricks'][index]);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(displayList[index]),
                            Icon(Icons.delete)
                          ],
                        ),
                      )));
                }),
          ),
        ]));
  }

  void displayDetermine() {
    if (data1['transition'] == false) {
      displayList = data1['streetTricks'];
    } else {
      displayList = data1['transitionTricks'];
    }
  }
}
