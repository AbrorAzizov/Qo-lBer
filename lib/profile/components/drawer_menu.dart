import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_bloc.dart';
import 'package:qol_ber/profile/bloc/profile_cubit.dart';
import 'package:qol_ber/profile/components/drawer_tile.dart';

class DrawerMenu extends StatelessWidget {
  final String uid ;
  const DrawerMenu({super.key, required this.uid});


  @override
  Widget build(BuildContext context) {
    final profileCubit  =   context.read<ProfileCubit>();
    final AppUser? = profileCubit.state.
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
