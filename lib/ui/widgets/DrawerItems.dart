import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String? text;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Function()? onTap;

  const DrawerItem({@required this.text,@required this.leadingIcon,@required this.trailingIcon,@required this.onTap}) ;

  @override
  Widget build(BuildContext context) {

    return ListTile(
                  title: Text(text!,
                  style: Theme.of(context).textTheme.headline5,
                  ),
                  leading: Icon(leadingIcon,color: Theme.of(context).primaryColor),
                  trailing: Icon(trailingIcon,color:  Theme.of(context).primaryColor),
                  onTap:onTap,
                );
    
  }
}