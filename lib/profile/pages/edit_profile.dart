
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/features/domain/entity/app_user.dart';
import 'package:qol_ber/profile/bloc/profile_cubit.dart';

import '../bloc/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  final AppUser user;

  const EditProfilePage({super.key, required this.user,});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.user.name;
    bioController.text =widget.user.bio ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          title: const Text('🛠️ Edit Your Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // TODO: Insert your image picker logic
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person,
                          size: 40, color: Colors.white),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: const Icon(Icons.edit,
                            size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                controller: nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                hint: 'What should we call you?',
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: bioController,
                label: 'Bio',
                icon: Icons.chat_bubble_outline,
                hint: 'Share a few words that describe you',
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  final name = nameController.text;
                  final bio = bioController.text;
                  context
                      .read<ProfileCubit>()
                      .updateUser(uid: widget.user.uid, bio: bio, name: name);
                },
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Save Profile'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      );}
          else {
            return Scaffold();
          }
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
