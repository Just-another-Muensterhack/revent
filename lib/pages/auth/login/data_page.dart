import 'package:flutter/material.dart';
import 'package:revent/models/profile.dart';
import 'package:revent/widgets/custom_button.dart';
import 'package:revent/widgets/custom_textfield.dart';

class DataPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>{

  //String _number = '';
  //String _gender = '';
  DateTime _birthday = DateTime.now();

  Future<void> _sendForm()async{
    return Profile.create(_birthday);
  }

  void _openDatePicker(BuildContext context){
    showDatePicker(
        context: context,
        initialDate: _birthday,
        firstDate: DateTime(1900),
        lastDate: DateTime.now()
    ).then((value) {setState(() {
      _birthday = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
                child: Column(
                  children: [
                    CustomInput(hintText: "type in #", onChanged: (value) => this.setState(() {
                      //this._number = value;
                    })),
                    CustomInput(hintText: "gender", onChanged: (value) => this.setState(() {
                      //this._gender = value;
                    })),
                    CustomButton(
                      buttonText: "select birthday",
                      onPress: () => _openDatePicker(context),
                    )
                  ],
                )
            ),
            CustomButton(
              buttonText: "let´s celebrate",
              onPress: () => _sendForm(),
            )
          ],
        ),
      )
    );
  }

}