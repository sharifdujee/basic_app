import 'package:flutter/material.dart';
import 'package:self_quiz/screen/settings/setting_screen.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  // List of questions
  List<String> questionList = [
    'The Capital of Bangladesh',
    'The Capital of India',
    'The Capital of USA'
  ];

  // Correct answers for each question
  Map<int, String> correctAnswers = {
    0: 'Dhaka',
    1: 'New Delhi',
    2: 'Washington, D.C.'
  };

  // Options for the questions
  List<List<String>> options = [
    ['Khulna', 'Dhaka', 'Sylhet', 'Chittagong'],
    ['Mumbai',  'Kolkata', 'New Delhi', 'Chennai'],
    ['New York', 'Chicago', 'Los Angeles', 'Washington, D.C.']
  ];


  String? selectedOption;
  String feedbackMessage = "";
  int currentIndex = 0;
  bool isOptionSelected = false;
  bool _isRest = false;
  int totalCorrect = 0;

  // Store user choices
  Map<int, String> userAnswers = {};

  void nextQuestion() {
    if (currentIndex < questionList.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null; // Reset the selected option for the next question
        feedbackMessage = ""; // Clear the feedback message
        isOptionSelected = false; // Allow new selection
      });
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        selectedOption = null; // Reset the selected option for the previous question
        feedbackMessage = ""; // Clear the feedback message
        isOptionSelected = false; // Allow new selection
      });
    }
  }

  void selectOption(String value) {
    if (!isOptionSelected) {
      setState(() {
        selectedOption = value;
        userAnswers[currentIndex] = value; // Save the user's choice
        isOptionSelected = true; // Prevent further changes
        if (selectedOption == correctAnswers[currentIndex]) {
          feedbackMessage = "Correct Answer!";
        } else {
          feedbackMessage = "Wrong Answer! The correct answer is ${correctAnswers[currentIndex]}";
        }
      });
    }
  }
  void _reset() {
    setState(() {
      _isRest = true; // Indicate that a reset has occurred
      currentIndex = 0; // Restart from the first question
      totalCorrect = 0; // Reset the score if applicable
      _isRest = false; // Allow the quiz to proceed after reset
    });

    print('Quiz has been reset and begins from the first question.');
  }



  void showSummaryDialog() {

    List<Widget> summaryItems = [];

    for (int i = 0; i < questionList.length; i++) {
      bool isCorrect = userAnswers[i] == correctAnswers[i];
      if (isCorrect) {
        totalCorrect++;
      }
      summaryItems.add(
        ListTile(
          title: Text(questionList[i]),
          subtitle: Text(
            "Your answer: ${userAnswers[i] ?? "Not answered"}\nCorrect answer: ${correctAnswers[i]}",
          ),
          leading: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: isCorrect ? Colors.green : Colors.red,
          ),
        ),
      );
    }


    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Summary"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total Marks: $totalCorrect/${questionList.length}\n"),
                const SizedBox(height: 10),
                ...summaryItems,
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Practice Page',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        questionList[currentIndex],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...options[currentIndex]
                          .map((option) => RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: selectedOption,
                        onChanged: isOptionSelected
                            ? null // Disable selection after an option is selected
                            : (value) => selectOption(value!),
                      ))
                          .toList(),
                      const SizedBox(height: 10),
                      if (feedbackMessage.isNotEmpty)
                        Text(
                          feedbackMessage,
                          style: TextStyle(
                            color: feedbackMessage == "Correct Answer!"
                                ? Colors.green
                                : Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: currentIndex > 0 ? previousQuestion : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: currentIndex < questionList.length - 1
                        ? nextQuestion
                        : null,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: currentIndex == questionList.length - 1
                        ? showSummaryDialog
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(onPressed: (){
                    _reset();

                  }, child: const Text('Reset'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
