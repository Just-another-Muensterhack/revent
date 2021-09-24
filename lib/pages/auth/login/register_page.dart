import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  int _stepperIndex = 0;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  InputDecoration inpDec = new InputDecoration(
    border: OutlineInputBorder(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO Generic App bar"),
      ),
      body: Stepper(
        currentStep: _stepperIndex,
        onStepContinue: () => this.setState(() {
          _stepperIndex++;
        }),
        onStepCancel: () => this.setState(() {
          _stepperIndex--;
          if(_stepperIndex < 0){
            Navigator.pop(context);
          }
        }),
        onStepTapped: (int index) {
          setState(() { _stepperIndex = index; });
        },
        steps: [
          Step(
              title: Text("Login with Google"),
              content: Form(
                child: Column(
                  children: [
                    TextFormField(),
                  ],
                ),
              )
          ),
          Step(
              title: Text("Your data"),
              content: Form(
                child: Column(
                  children: [
                    TextFormField(),
                    TextFormField(),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}