import 'package:flutter/material.dart';


String mailValidator(value){
  if(value.isEmpty){
    return 'Please fill in the Email';
  }
  return "";
}

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  // Decorator for google-Mail input
  InputDecoration _mailDecoration = new InputDecoration(
    border: OutlineInputBorder(),
    icon: Icon(Icons.mail),
    hintText: "Please Enter your Google-Mail",
    labelText: "Mail"
  );


  @override
  Widget build(BuildContext context) {

    int _stepperIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO create universal bar"),
      ),
      body: Stepper(
        steps: [
          Step(
              title: Text("Get Started"),
              content: Column(
                children: [
                  ElevatedButton(
                      onPressed:() => {},
                      child: Text("Get Started"),
                  )
                ],
              )
          ),
          Step(
              title: Text("Credentials"),
              content: Column(
                children: [
                  ElevatedButton(onPressed: () => {}, child: Text("Login with Google"))
                ],
              )
          ),
          Step(
            title: Text("Your Data"),
            content: Column(),  // TODO fill
          )
        ],
      )
    );
  }

}