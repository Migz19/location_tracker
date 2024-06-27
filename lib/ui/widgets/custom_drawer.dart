import 'package:flutter/material.dart';
import 'package:location_tracker/core/app_assets.dart';

class CustomDrawer extends StatelessWidget {

   Color? drawerHeaderColor;
   String? drawerImagePath;
   CustomDrawer({this.drawerHeaderColor,this.drawerImagePath});

   Widget buildDrawerHeader(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: drawerHeaderColor,
          ),
          child:drawerImagePath== null ? Image.asset(""):Image.asset(drawerImagePath!,fit: BoxFit.cover) ,
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
