import 'package:flutter/material.dart';
import 'package:revent/widget/custom_textfield.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{

  static const int CREDENTIAL_PAGE = 0;
  static const int DATA_PAGE = 1;

  int _stepperIndex = 0;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String _mail = '';
  String _pass = '';

  String _number = '';
  String _gender = '';
  String _birthday = '';

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

          // check of form is validated
          if(_key.currentState.validate()){

          }else{
            print('not valid');
          }

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
                    CustomInput(hintText: "Google Mail", onChanged: (value) => this.setState(() {
                      this._mail = value;
                    })),
                    CustomInput(hintText: "Password",onChanged: (value) => this.setState(() {
                      this._pass = value;
                    }))
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}