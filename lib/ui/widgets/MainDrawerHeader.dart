import 'package:bloc_app1/bloc/themeBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MainDrawerHearder extends StatelessWidget {
  const MainDrawerHearder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  DrawerHeader(
              decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.white,Theme.of(context).primaryColor
                    ])
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 const   CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/technology.jpg"),
                    ),
                      IconButton(onPressed: (){
                        context.read<ThemeBloc>().add(SwitchThemeEvent());
                      }, icon:const Icon(Icons.settings))
              ],
            ),
            ); }}

