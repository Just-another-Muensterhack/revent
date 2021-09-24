import 'package:flutter/material.dart';
import 'package:revent/widget/custom_button.dart';
import 'package:revent/widget/custom_textfield.dart';

class DataPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>{

  String _number = '';
  String _gender = '';
  String _birthday = '';

  Future<void> sendForm()async{
    print('Form was sent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Title"),),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Form(
                child: Column(
                  children: [
                    CustomInput(hintText: "type in #", onChanged: (value) => this.setState(() {
                      this._number = value;
                    })),
                    CustomInput(hintText: "gender", onChanged: (value) => this.setState(() {
                      this._gender = value;
                    })),
                    CustomInput(hintText: "birthday", onChanged: (value) => this.setState(() {
                      this._birthday = value;
                    })),
                  ],
                )
            ),
            CustomButton(
              buttonText: "let´s celebrate",
              onPress: () async {
                await sendForm().then((value) => {});
              },
            )
          ],
        ),
      )
      
    );
  }

}