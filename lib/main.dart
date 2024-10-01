import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MultiStepForm(),
  ));
}

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  int _currentStep = 0;

  List<Step> getSteps() {
    return [
      Step(
        title: Text('Step 1'),
        content: Container(),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Step 2'),
        content: Container(),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Step 3'),
        content: Container(),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Step 4'),
        content: Container(),
        isActive: _currentStep >= 3,
      ),
    ];
  }

  Widget personalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Tell us about your personal information",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(height: 20),
        buildTextInputField("Last Name", "Enter Last Name"),
        buildTextInputField("First Name", "Enter First Name"),
        buildTextInputField("Middle Name", "Enter Middle Name"),
        buildTextInputField("Contact Number", "Enter Contact Number"),
        buildTextInputField("Alternate Contact", "Enter Alternate Contact"),
        buildTextInputField("Alternate Email", "Enter Alternate Email"),
      ],
    );
  }

  Widget educationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Tell us about your Educational Background",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        buildTextInputField("Course", "Enter Course"),
        buildTextInputField("Graduate Course", "Enter Graduate Course"),
        buildTextInputField("Date of Graduation", "Enter Date of Graduation"),
        buildTextInputField("Add Course", "Enter Additional Course"),
      ],
    );
  }

  Widget employmentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Tell us about your Employment History",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        buildTextInputField("Position", "Enter Position"),
        buildTextInputField("Company", "Enter Company"),
        buildTextInputField("Starting Date", "Enter Starting Date"),
        buildTextInputField("End Date", "Enter End Date"),
        buildTextInputField("Add Position", "Enter Additional Position"),
      ],
    );
  }

  Widget jobPositionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "Fill the position",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        buildTextInputField(
            "Desired Job Position", "Enter Desired Job Position"),
      ],
    );
  }

  Widget buildTextInputField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.green.shade800,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green.shade500, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green.shade300, width: 2),
          ),
        ),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  // This method will handle the form and buttons under each step
  Widget buildStepContent(Widget stepContent) {
    return Column(
      children: [
        stepContent,
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: _currentStep > 0
                  ? () {
                      setState(() {
                        _currentStep -= 1;
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
              ),
              child: Text("Prev", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              onPressed: _currentStep < getSteps().length - 1
                  ? () {
                      setState(() {
                        _currentStep += 1;
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade800,
              ),
              child: Text("Next", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        title: Image.asset(
          'assets/delmonte-logo.png', // Ensure you have this asset or change it accordingly
          height: 50,
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side stepper
          Expanded(
            flex: 1,
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              steps: getSteps(),
              onStepTapped: (int step) {
                setState(() {
                  _currentStep = step;
                });
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return SizedBox.shrink(); // Remove default stepper controls
              },
            ),
          ),
          // Right side content form
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: IndexedStack(
                  index: _currentStep,
                  children: [
                    buildStepContent(personalInfoStep()),
                    buildStepContent(educationStep()),
                    buildStepContent(employmentStep()),
                    buildStepContent(jobPositionStep()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
