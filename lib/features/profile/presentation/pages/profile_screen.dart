import 'package:flutter/material.dart';
import 'package:maw3ed/core/route/app_routes.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: const Text("Settings"),
            onTap: (){
              Navigator.of(context).pushNamed(AppRoutes.settingsRoute);
            },
          )
        ],
      ),
    );
  }
}