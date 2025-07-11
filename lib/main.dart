import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qol_ber/auth/bloc/auth_event.dart';
import 'package:qol_ber/features/storage/data/firebase_storage_repo.dart';
import 'package:qol_ber/firebase_options.dart';
import 'package:qol_ber/profile/bloc/profile_cubit.dart';
import 'package:qol_ber/profile/data/firebase_profile_repo.dart';
import 'package:qol_ber/view/auth_view.dart';
import 'package:qol_ber/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final profileRepo = FireBaseProfileRepo();
    final storageRepo = FirebaseStorageRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc();
            bloc.add(AuthEventInitialize());
            return bloc;
          },
        ),
        BlocProvider<ProfileCubit>(
          create: (context) =>
              ProfileCubit(profileRepo: profileRepo, storageRepo: storageRepo),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthView(),
      ),
    );
  }
}
