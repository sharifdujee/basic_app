import 'package:bloc_auth/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:bloc_auth/screen/app_view.dart';
import 'package:bloc_auth/user_repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key,  required this.userRepository});
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(create: (context)=>AuthenticationBloc(userRepository: userRepository),
    child: const MyAppView(),);
  }
}
