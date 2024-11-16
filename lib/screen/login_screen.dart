import 'package:flutter/material.dart';
import 'package:recipe_app/services/auth_service.dart';
import 'package:status_alert/status_alert.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? userName, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(child: _buildUI()),
    );
  }
  Widget _buildUI(){
    return SizedBox(
      width:  MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          _loginForm(),


        ],
      ),
    );
  }

  Widget _title(){
    return const Text('Recipe Book', style: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w300

    ),);
  }
  Widget _loginForm(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.90,
      height: MediaQuery.sizeOf(context).height*0.30,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: 'emilys',
              onSaved: (value){
                setState(() {
                  userName = value;
                });

              },
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Enter a user name";
                }
              },
              decoration: const InputDecoration(
                hintText: 'UserName'
              ),

              ),
            TextFormField(
              initialValue: 'emilyspass',
              onSaved: (value){
                setState(() {
                  password = value;
                });

              },
              obscureText: true,
              validator: (value){
                if(value== null || value.length<6){
                  return "Enter a password";
                }
              },
              decoration: const InputDecoration(
                hintText: 'Password'
              ),

            ),
            _loginButton()

          ],
        ),
        

      ),


    );
  }
  Widget _loginButton(){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.60,
     child: ElevatedButton(onPressed: ()async {
       if(_formKey.currentState?.validate()??false){
         _formKey.currentState?.save();
         bool result = await AuthService().login(userName!, password!);
         if(result){
           Navigator.pushNamed(context, '/home');

         }
         else{
           StatusAlert.show(context, duration: const Duration(seconds: 2),
           title: 'Login Failed',
           subtitle: 'Please try again',
           configuration: IconConfiguration(icon: Icons.error),
           maxWidth: 260);
         }




       }
     }, child: const Text('Login')),


    );
  }


}
