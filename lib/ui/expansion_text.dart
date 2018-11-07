import 'package:flutter/material.dart';

class ExpansionText extends StatefulWidget {
  final String text;

  ExpansionText(this.text);

  @override
  _ExpansionTextState createState() => _ExpansionTextState();
}

class _ExpansionTextState extends State<ExpansionText> {
  int maxLines = 4;

  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      if (maxLines <= 4) {
        maxLines = 100;
      } else {
        maxLines = 4;
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
        Text(
          "Story Line",
          style: textTheme.subhead.copyWith(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Text(widget.text,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: textTheme.body1
                .copyWith(fontSize: 16.0, color: Colors.black45)),
        GestureDetector(
            onTap: _toggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(maxLines <= 4 ? "more" : "fold",
                    style: textTheme.body1.copyWith(color: Colors.redAccent)),
                Icon(
                    maxLines <= 4
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.redAccent,
                    size: 18.0)
              ],
            ))
      ],
    );
  }
}
