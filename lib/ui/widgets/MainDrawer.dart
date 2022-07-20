

import 'package:bloc_app1/ui/widgets/DrawerItems.dart';
import 'package:bloc_app1/ui/widgets/MainDrawerHeader.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

List<dynamic> menus=[
  {"title":"Home","route":"/","leadingIcon":Icons.home,"trailingIcon":Icons.arrow_forward},
  {"title":"counter stf","route":"/counter1","leadingIcon":Icons.event,"trailingIcon":Icons.arrow_forward},
  {"title":"counter bloc","route":"/counter2","leadingIcon":Icons.timer,"trailingIcon":Icons.arrow_forward},
  {"title":"Git users","route":"/users","leadingIcon":Icons.person,"trailingIcon":Icons.arrow_forward},
];

    return  Drawer(
      child: Column(
        children: [
           const   MainDrawerHearder(),
           Expanded(
             child: ListView.separated(
              itemBuilder: (_,index){
                return    DrawerItem(
                  text: menus[index]["title"],
                   leadingIcon: menus[index]["leadingIcon"],
                    trailingIcon: menus[index]["trailingIcon"], 
                    onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context, menus[index]["route"]);
            }); 
              },
               separatorBuilder: (_,i){
                return const Divider(height: 3,);
               },
                itemCount: menus.length
                ),
           )
        ],
      ),
    );
  }
}