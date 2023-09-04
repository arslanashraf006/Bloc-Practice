import 'dart:async';

import 'package:bloc_practice/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class StreamControllerScreen extends StatefulWidget {
  const StreamControllerScreen({Key? key}) : super(key: key);

  @override
  State<StreamControllerScreen> createState() => _StreamControllerScreenState();
}

class _StreamControllerScreenState extends State<StreamControllerScreen> {
  int counter = 0;

  StreamController<int> counterController = StreamController();

  late Stream myStream;

  @override
  void initState() {
    myStream = counterController.stream.asBroadcastStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: myStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TextWidget(
                    title: snapshot.data.toString(),
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                  );
                } else {
                  return const TextWidget(
                    title: '0',
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                  );
                }
              },
            ),
            StreamBuilder(
              stream: myStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return TextWidget(
                    title: snapshot.data.toString(),
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                  );
                } else {
                  return const TextWidget(
                    title: '0',
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                  );
                }
              },
            ),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter++;counterController.sink.add(counter);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
