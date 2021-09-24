import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:revent/constants/colors.dart';
import 'package:revent/models/commons.dart';
import 'package:revent/widgets/custom_button.dart';

class SelectInterestsPage extends StatefulWidget {
  @override
  _SelectInterestsPageState createState() => _SelectInterestsPageState();
}

class _SelectInterestsPageState extends State<SelectInterestsPage> {
  Map<int, bool> _cardsValue = {};

  @override
  void initState() {
    super.initState();

    for (int index = 0; index < Genre.values.length; index++) {
      _cardsValue[index] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Genre.values.length,
            itemBuilder: (BuildContext context, int index) => Card(
                color: _cardsValue[index] ? primary : Colors.grey,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _cardsValue[index] = !_cardsValue[index];
                    });
                  },
                  child: Container(
                      width: size.width * 0.25,
                      child: Center(
                          child: Text(
                        Genre.values[index].toString().split(".").last,
                        style: TextStyle(color: Colors.white),
                      ))),
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(25),
          child: CustomButton(
            buttonText: "Continue",
            onPress: () {},
          ),
        )
      ],
    )));
  }
}
