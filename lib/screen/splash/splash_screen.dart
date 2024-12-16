import 'package:flutter/material.dart';
import 'package:self_quiz/screen/practice_screen/practice_screen.dart';
import 'package:self_quiz/screen/settings/setting_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the SettingScreen after a delay of 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PracticeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/image/Lab Logo.png'),
              ),
              accountName: Text('User'),
              accountEmail: Text('admin32@gmail.com'),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SettingScreen()));

              },
              child: const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            )
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/image/Lab Logo.png'),
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to Self Quiz!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
