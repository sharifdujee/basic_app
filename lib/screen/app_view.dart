
import 'package:bloc_auth/blocs/todo_bloc/todo_bloc.dart';
import 'package:bloc_auth/screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import 'home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: const ColorScheme.light(
              background: Colors.white,
              onBackground: Colors.white,
              primary: Color.fromRGBO(206, 147, 216, 1),
              onPrimary: Colors.black,
              secondary: Color.fromRGBO(244, 143, 177, 1),
              onSecondary: Colors.white,
              tertiary: Color.fromRGBO(255, 204, 128, 1),
              error: Colors.red,
              outline: Color(0xFF424242)
          ),
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if(state.status == AuthenticationStatus.authenticated) {
                return BlocProvider<TodoBloc>(
                  create: (context) => TodoBloc()..add(TodoStarted()),
                  child: const HomeScreen(),
                );
              } else {
                return const WelcomeScreen();
              }
            }
        )
    );
  }
}