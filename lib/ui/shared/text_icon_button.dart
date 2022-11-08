import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:flutter/material.dart';

class TextIcon extends StatefulWidget {
  final String? text;
  final IconData? icon;
  Function? onPressed;
  Color? color;
  TextIcon({this.icon, this.onPressed, this.text, this.color});
  @override
  TextIconState createState() => TextIconState();
}

class TextIconState extends State<TextIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 8,
            width: MediaQuery.of(context).size.width / 8,
            child: Center(
              child: Icon(
                widget.icon,
                size: TextSize().h(context),
                color: ceoWhite,
              ),
            ),
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(
                    (MediaQuery.of(context).size.width / 8) / 2)),
          ),
          Container(
            margin: EdgeInsets.only(top: 3),
            child: Text(
              widget.text!,
              style: TextStyle(
                  color: ceoPurple, fontSize: TextSize().custom(9, context)),
            ),
          )
        ],
      ),
    );
  }
}
