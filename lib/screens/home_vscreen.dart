import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key) {}
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _inputText;

  void _incrementCounter(String val) {
    setState(() {
      _inputText = _inputText + val;
    });
  }

  @override
  Widget build(BuildContext context) {
    var text = '|';
    var model = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0',
      '-',
      '+',
      '*',
      '/',
      '='
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
              SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            text,
                            style: TextStyle(fontSize: 22),
                          )),
                      color: Colors.teal[100])),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 3,
                      padding: EdgeInsets.all(10),
                      primary: false,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                    ...model.map((e) => Container(
                        padding: const EdgeInsets.all(8),
                        child: TextButton(
                          child: Text(
                            e,
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () {},
                        ),
                        color: Colors.teal[100]))
                  ]))
            ])));
  }
}
