import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<HomeBloc>();
    return Scaffold(
        appBar: AppBar(),
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
                            context.watch<HomeBloc>().outputText,
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
                    ...bloc.models.map((m) => Container(
                        padding: const EdgeInsets.all(8),
                        child: TextButton(
                          child: Text(
                            m.value,
                            style: TextStyle(fontSize: 26),
                          ),
                          onPressed: () => bloc.calc(model: m),
                        ),
                        color: Colors.teal[100]))
                  ]))
            ])));
  }
}
