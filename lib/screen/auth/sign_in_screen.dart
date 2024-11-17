import 'package:bloc_auth/screen/auth/components/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/sign_in_bloc/sign_in_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              controller: emailController,
              hintText: 'Enter your Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(CupertinoIcons.mail_solid),
              errorMsg: _errorMsg,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please fill in this field';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: MyTextField(
              controller: passwordController,
              hintText: 'Enter Password',
              obscureText: obscurePassword,
              keyboardType: TextInputType.visiblePassword,
              prefixIcon: const Icon(CupertinoIcons.lock_fill),
              errorMsg: _errorMsg,

              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please fill this field';
                } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                  return 'Please enter a valid password';
                }
                return null;
              },
              suffixIcon: IconButton(onPressed: (){
                setState(() {
                  obscurePassword = !obscurePassword;
                  if(obscurePassword){
                    iconPassword = CupertinoIcons.eye_fill;
                  }
                  else{
                    iconPassword = CupertinoIcons.eye_slash_fill;
                  }
                });
              }, icon: Icon(iconPassword)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          !signInRequired
              ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignInBloc>().add(SignInRequired(
                        emailController.text,
                        passwordController.text)
                    );
                  }
                },
                style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)
                    )
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Text(
                    'Sign In',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                )
            ),
          )
              : const CircularProgressIndicator(),
        ],
      ),
    );
  }
}

