import 'package:flutter/material.dart';
import 'package:self_quiz/screen/exam_screen/exam_screen.dart';
import 'package:self_quiz/screen/practice_screen/practice_screen.dart';
import 'package:self_quiz/screen/upload/upload_exam.dart';
import 'package:self_quiz/screen/upload/upload_question.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isChecked = false;
  bool _isUpload = false;
  bool _isAdmin = false;
  bool _isLang = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/image/Lab Logo.png'),
              ),
              accountName: Text(
                'John Doe',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('john.doe@example.com'),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.blueAccent),
              title: const Text('Settings', style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.blueAccent),
              title: const Text('Help', style: TextStyle(fontSize: 16)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(fontSize: 16)),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quiz Mode',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: _isChecked,
                            activeColor: Colors.blueAccent,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value;
                              });
                              if (_isChecked) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ExamScreen(),
                                ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PracticeScreen(),
                                ));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Toggle to switch between Practice and Exam modes.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Language Setting',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: _isLang,
                            activeColor: Colors.blueAccent,
                            onChanged: (value) {
                              setState(() {
                                _isLang = value;
                              });
                              if (_isLang) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ExamScreen(),
                                ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PracticeScreen(),
                                ));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Toggle to switch between use native  and international language.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Upload Question',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: _isUpload,
                            activeColor: Colors.blueAccent,
                            onChanged: (value) {
                              setState(() {
                                _isUpload = value;
                              });
                              if (_isUpload) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UploadQuestion(),
                                ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const PracticeScreen(),
                                ));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Toggle to switch between to upload your own question .',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Profile Mode',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: _isAdmin,
                            activeColor: Colors.blueAccent,
                            onChanged: (value) {
                              setState(() {
                                _isAdmin = value;
                              });
                              if (_isAdmin) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UploadExam(),
                                ));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UploadQuestion(),
                                ));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Toggle to switch between Admin and User modes.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),

        ),
      ),
    );
  }
}
