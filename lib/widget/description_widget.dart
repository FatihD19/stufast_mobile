import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

class TruncatedText extends StatefulWidget {
  final String text;
  final int maxLines;

  TruncatedText({required this.text, this.maxLines = 3});

  @override
  _TruncatedTextState createState() => _TruncatedTextState();
}

class _TruncatedTextState extends State<TruncatedText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      maxLines: isExpanded ? null : widget.maxLines,
      overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textWidget,
        if (widget.text.split('\r\n').length > widget.maxLines)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Sembunyikan' : 'Selanjutnya',
                style: thirdTextStyle,
              ),
            ),
          ),
      ],
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText({required this.text, this.maxLines = 3});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Split the text into lines and trim any leading/trailing whitespace
    final lines = widget.text.split('\n').map((line) => line.trim()).toList();

    // Create a list of lines to display based on the expansion state
    final displayLines =
        isExpanded ? lines : lines.take(widget.maxLines).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var line in displayLines)
          Text(
            line,
            overflow: TextOverflow.ellipsis,
            maxLines: isExpanded ? null : 1,
          ),
        if (lines.length > widget.maxLines)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? 'Sembunyikan' : 'Selanjutnya',
                style: thirdTextStyle,
              ),
            ),
          ),
      ],
    );
  }
}

class DescriptionList extends StatelessWidget {
  final String description;

  DescriptionList({required this.description});

  @override
  Widget build(BuildContext context) {
    // Split the description by '\r\n' to get individual lines.
    final lines = description.split('\r\n');

    return ListView.builder(
      shrinkWrap: true,
      itemCount: lines.length,
      itemBuilder: (context, index) {
        // For lines starting with a number, add a bullet point.
        if (lines[index].trimLeft().startsWith(RegExp(r'^\d+\.'))) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              lines[index].trimLeft(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        } else {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(lines[index].trimLeft()),
          );
        }
      },
    );
  }
}
