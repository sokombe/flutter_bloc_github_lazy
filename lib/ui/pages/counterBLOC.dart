
import 'package:bloc_app1/bloc/counter.dart';
import 'package:bloc_app1/helper/themes.dart';
import 'package:bloc_app1/ui/widgets/MainDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBLOCPages extends StatelessWidget {
  const CounterBLOCPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return  Scaffold(
      appBar: AppBar(
        title:const Text("CounterBLOCPages"),
      ),
      body: Center(
        child:BlocBuilder<CounterBloc,CounterState>(
          builder:  (context, state) {
          if(state is CounterSuccessState || state is CounterInitialState){
           return Text("Counter value=> ${state.counter}",style: Theme.of(context).textTheme.headline5,);
            }
            else if(state is CounterErrorState){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Text("Counter value=> ${state.counter}",style: Theme.of(context).textTheme.headline5,),
           Text("${state.errorMessage}",style: CustomThemes.errorTextStyle,)

          ],
        )   ;
            }
            else{
              return Container();
            }
          },
        ),
     
      ),
           floatingActionButton:
      Row(
   mainAxisAlignment: MainAxisAlignment.end,
        children: [
           FloatingActionButton(
            heroTag: null,
            onPressed: () {
            context.read<CounterBloc>().add(IncrementCounterEvent());

      },
      child:const Icon(Icons.add),
      ),
     const SizedBox(width: 8,),
       FloatingActionButton(
        heroTag: null,
        onPressed: () {
            context.read<CounterBloc>().add(DecrementCounterEvent());
      },
      child:const Icon(Icons.remove,color: Colors.white,),
      )
        ],
      ),
    );
  }
}