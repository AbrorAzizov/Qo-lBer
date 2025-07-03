import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_state.dart';
import 'package:qol_ber/profile/bloc/profile_state.dart';
import 'package:qol_ber/profile/bloc/profile_cubit.dart';
import 'package:qol_ber/profile/pages/edit_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final authState = context
        .read<AuthBloc>()
        .state;
    if (authState is AuthStateLoggedIn) {
      final uid = authState.user.uid;
      context.read<ProfileCubit>().fetchUser(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is ProfileStateError) {
          return Center(child: Text(state.error));
        }
        else if (state is ProfileStateLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.purple.shade100,
                    child: const Icon(
                        Icons.person, size: 60, color: Colors.white),
                  ),
                  const SizedBox(height: 30),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email Address',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.user.email,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const Divider(height: 24),
                          const Text(
                            'Name',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.user.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
              ]
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.purple,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage(user: state.user,),));
              },
              child:  Icon(Icons.edit,color: Colors.white,),
              tooltip: 'Edit Profile',
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
