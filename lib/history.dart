import 'package:flutter/material.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List historyList = [];
  @override
  Widget build(BuildContext context) {
    historyList = historyList.isNotEmpty
        ? historyList
        : ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Trick History'),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, historyList);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 520,
              child: ListView.builder(
                  itemCount: historyList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 4.0),
                        child: Card(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 24),
                              child: Text(
                                historyList[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  letterSpacing: 1,
                                ),
                              ),
                            )));
                  }),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    historyList = ['No Tricks Done'];
                  });
                },
                child: Text('Clear History'))
          ],
        ),
      ),
    );
  }
}
