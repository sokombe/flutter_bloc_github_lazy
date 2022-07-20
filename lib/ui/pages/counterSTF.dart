import 'package:bloc_app1/helper/themes.dart';
import 'package:flutter/material.dart';


class CounterSTF extends StatefulWidget {
  const CounterSTF({Key? key}) : super(key: key);

  @override
  State<CounterSTF> createState() => _CounterSTFState();
}
   int counter=0;
   String errorMessage="";
class _CounterSTFState extends State<CounterSTF> {
  @override
  Widget build(BuildContext context) {
 
  return  Scaffold(
      appBar: AppBar(
        title:const Text("CounterSTF"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Text("Taped $counter time(s)"),
         errorMessage!=""?   Text("$errorMessage",style:CustomThemes.errorTextStyle,
             ):Container(),
          ],
        ),
      ),
      floatingActionButton:
      Row(
   mainAxisAlignment: MainAxisAlignment.end,
        children: [
           FloatingActionButton(
            heroTag: null,
            onPressed: () {
              ++counter;
        setState(() {
        });
        print("counter value: $counter");

      },
      child:const Icon(Icons.add),
      ),
     const SizedBox(width: 8,),
       FloatingActionButton(
        heroTag: null,
        onPressed: () {
       if(counter>0){
         --counter;
       }else{
       errorMessage="The counter can not be <0";
       }
      setState(() {});
      },
      child:const Icon(Icons.remove,color: Colors.black,),
      )
        ],
      ),
    );
  }
}