
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent{}

class IncrementCounterEvent extends CounterEvent{}

class DecrementCounterEvent extends CounterEvent{}

// state
abstract class CounterState{
  final int? counter;
  const CounterState({@required this.counter});
}


class CounterSuccessState extends CounterState{
CounterSuccessState({required int counter}): super(counter: counter);
}

class CounterErrorState extends CounterState{
  final  String? errorMessage;
  CounterErrorState({@required counter,@required this.errorMessage});
}

class CounterInitialState extends CounterState{
  CounterInitialState(): super(counter: 0);
}

// bloc

class CounterBloc extends Bloc<CounterEvent,CounterState>{
  CounterBloc():super(CounterInitialState()){

 on((IncrementCounterEvent event,emit){
if((state.counter!)<10){
  int coubtervalue=state.counter!+1;
emit(CounterSuccessState(counter: coubtervalue));
}else{
  emit(CounterErrorState(counter: state.counter,
  errorMessage: "Counter value can't exceed 10"
  ));
}
 });

  on((DecrementCounterEvent event,emit){
  if((state.counter!)>0){
  int coubtervalue=state.counter!-1;
emit(CounterSuccessState(counter: coubtervalue));
}else{
  emit(CounterErrorState(counter: state.counter,
  errorMessage: "Counter value can't be less than  0"
  ));
}
 });
  }
}