import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_state.dart';
import 'package:qol_ber/profile/bloc/profile_state.dart';
import 'package:qol_ber/profile/bloc/profile_cubit.dart';
import 'package:qol_ber/profile/components/drawer_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    @override
    void inItState (){
      super.initState;
      final authState = context.read<AuthBloc>().state;
      if(authState is AuthStateLoggedIn){
        final uid = authState.user.uid;
        context.read<ProfileCubit>().fetchUser(uid);
      }

    }
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileStateError) {
          return Center(child: Text(state.error));
        } else if (state is ProfileStateLoaded) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(state.user.email),
            ),

            body: const Center(child: Text('hello')),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
