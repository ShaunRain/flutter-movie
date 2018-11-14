import 'package:flutter/material.dart';

class ExpansionText extends StatefulWidget {
  final String text;
  TextStyle textStyle;
  Color expandColor;
  int expandLine;

  ExpansionText(this.text,
      {this.textStyle =
          const TextStyle(color: Colors.black45, fontSize: 16.0, height: 1.0),
      this.expandColor = Colors.redAccent, this.expandLine = 4});

  @override
  _ExpansionTextState createState() => _ExpansionTextState();
}

class _ExpansionTextState extends State<ExpansionText> {
  int maxLines;

  @override
  void initState() {
    super.initState();
    maxLines = widget.expandLine;
  }

  void _toggle() {
    setState(() {
      if (maxLines <= widget.expandLine) {
        maxLines = 100;
      } else {
        maxLines = widget.expandLine;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 8.0),
        Text(widget.text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: textTheme.body1.copyWith(
                fontSize: widget.textStyle.fontSize,
                color: widget.textStyle.color,
                height: widget.textStyle.height)),
        GestureDetector(
            onTap: _toggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(maxLines <= widget.expandLine ? "more" : "fold",
                    style: textTheme.body1.copyWith(color: widget.expandColor)),
                Icon(
                    maxLines <= widget.expandLine
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: widget.expandColor,
                    size: 18.0)
              ],
            ))
      ],
    );
  }
}
