import 'package:bloc_app1/ui/widgets/MainDrawer.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      drawer:const MainDrawer(),
      appBar: AppBar(
        title:const Text("HomePage"),
      ),
      body:const Center(
        child: Text("HomePage"),
      ),
    );
  }
}