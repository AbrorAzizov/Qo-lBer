import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_bloc.dart';
import 'package:qol_ber/profile/bloc/profile_cubit.dart';
import 'package:qol_ber/profile/components/drawer_tile.dart';

class DrawerMenu extends StatelessWidget {

  const DrawerMenu({super.key});


  @override
  Widget build(BuildContext context) {
    final authBloc  =   context.read<AuthBloc>();
    final AppUser? = authBloc.
    return Drawer(
      child: SafeArea(child: Column(
        children: [
          const SizedBox( height: 50,),
          Icon(Icons.person,size: 80,),
          const SizedBox( height: 30,),
          myDrawerTile(title: 'Home', icon: Icons.home, onTap: () {},)

         ],
      )),
    );
  }
}
