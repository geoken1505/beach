import 'package:flutter/material.dart';
import 'package:yui/constant/contstant.dart';

class ButtonUi extends StatefulWidget {
  const ButtonUi({super.key, required this.text});

  final String text;

  @override
  State<ButtonUi> createState() => _ButtonUiState();
}

class _ButtonUiState extends State<ButtonUi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: MediaQuery.of(context).size.width-60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: kPrimaryColor,
          boxShadow: [
            BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 3),
                blurRadius: 6
            )
          ]
      ),
      alignment: Alignment.center,
      child: Text(widget.text, style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          fontFamily: "Poppins",
          color: Colors.white

      ),),
    );
  }
}
