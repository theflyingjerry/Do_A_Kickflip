import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EnterPage extends StatefulWidget {
  @override
  _EnterPageState createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> {
  Map data2 = {};
  List<String> tricksToAdd = ['EXAMPLE TRICK'];
  String trickType;
  bool tricksAdded = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var msgController = TextEditingController();
    data2 = ModalRoute.of(context).settings.arguments;
    streetTranny();
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter $trickType Tricks'),
          leading: BackButton(
            onPressed: () {
              if (data2['transition'] == false) {
                for (String entry in tricksToAdd) {
                  data2['streetTricks'].add(entry);
                }
                if (tricksAdded == false) {
                  data2['streetTricks'].removeLast();
                }
              } else {
                for (String entry in tricksToAdd) {
                  data2['transitionTricks'].add(entry);
                }
                //data2['transitionTricks'].removeLast();
              }

              Navigator.pop(context, {
                'transition': data2['transition'],
                'streetTricks': data2['streetTricks'],
                'transitionTricks': data2['transitionTricks']
              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 24, 10, 0),
          child: ListView(children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 400.0),
              child: ListView.builder(
                  itemCount: tricksToAdd.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                          color: Colors.grey[200],
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                if (tricksToAdd.length == 1 &&
                                    tricksAdded == true) {
                                  tricksToAdd.insert(1, 'EXAMPLE TRICK');
                                  tricksToAdd.remove(tricksToAdd[index]);
                                  tricksAdded = false;
                                } else {
                                  tricksToAdd.remove(index);
                                }
                              });
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${(index + 1)} .)  ${tricksToAdd[index]}'),
                                Icon(
                                  Icons.delete,
                                  color: Colors.grey[700],
                                )
                              ],
                            ),
                          ),
                        ));
                  }),
            ),
            Form(
              key: _formKey,
              child: Container(
                width: 300,
                child: TextFormField(
                    decoration: InputDecoration(hintText: 'Enter Trick Here'),
                    controller: msgController,
                    validator: (text) {
                      String toSendString = text.trim();
                      if (toSendString == null || toSendString.isEmpty) {
                        return 'Text is empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (String value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          if (tricksAdded == false) {
                            tricksToAdd.insert(0, value.toUpperCase());
                            tricksToAdd.removeLast();
                            tricksAdded = true;
                          } else {
                            tricksToAdd.insert(0, value.toUpperCase());
                          }
                          msgController.clear();
                        });
                      }
                    }),
              ),
            ),
          ]),
        ));
  }

  void streetTranny() {
    if (data2['transition'] == false) {
      trickType = 'Street';
    } else {
      trickType = 'Transition';
    }
  }
}
