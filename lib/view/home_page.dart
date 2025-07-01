import 'package:flutter/material.dart';

import '../profile/components/drawer_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('hello'),),
      floatingActionButton: FloatingActionButton(onPressed: () {
      },child: Icon(Icons.add),),
      appBar: AppBar(),
      drawer: DrawerMenu()
    );
  }
}
