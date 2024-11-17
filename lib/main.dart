import 'package:bloc/bloc.dart';
import 'package:bloc_auth/firebase_options.dart';
import 'package:bloc_auth/screen/app.dart';
import 'package:bloc_auth/simple_bloc_observer.dart';
import 'package:bloc_auth/user_repository/firebase_user_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp( MyApp(userRepository: FirebaseUserRepo(),));
}



