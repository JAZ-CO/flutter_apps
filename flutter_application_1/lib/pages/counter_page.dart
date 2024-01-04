import "package:flutter/material.dart";

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  //variables
  int count = 0;
  //Methods
  void countUp() {
    setState(() {
      count++;
    });
  }

  //UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "You pushed the button " + count.toString() + " Times",
            style: TextStyle(fontSize: 30),
          ),
          ElevatedButton(onPressed: countUp, child: Text("Increment!!"))
        ]),
      ),
    );
  }
}
