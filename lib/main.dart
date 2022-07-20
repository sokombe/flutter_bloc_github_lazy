import 'package:bloc_app1/bloc/counter.dart';
import 'package:bloc_app1/bloc/themeBloc.dart';
import 'package:bloc_app1/bloc/usersBloc.dart';
import 'package:bloc_app1/ui/pages/Api_Git_User.dart';
import 'package:bloc_app1/ui/pages/counterBLOC.dart';
import 'package:bloc_app1/ui/pages/counterSTF.dart';
import 'package:bloc_app1/ui/pages/hompage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( MultiBlocProvider(
    providers: [
      BlocProvider(create: (context)=>CounterBloc()),
      BlocProvider(create: (context)=>ThemeBloc()),
      BlocProvider(create: (context)=>UserSearchBloc()),
    ],
    child: BlocBuilder<ThemeBloc,ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: state.themeData,
          routes: {
            "/":(context) => const HomePage(),
            "/counter1":(context) => const CounterSTF(),
            "/counter2":(context) => const CounterBLOCPages(),
            "/users":(context) => const UserGitApi(),
          },
          initialRoute: "/",
        );
      }),
    
    ),
  );
}










