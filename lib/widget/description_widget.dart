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
        if (widget.text.length > widget.maxLines)
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

class DescriptionText extends StatefulWidget {
  final String text;
  final int maxLines;

  DescriptionText({required this.text, this.maxLines = 3});

  @override
  _DescriptionTextState createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<DescriptionText> {
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
            maxLines: isExpanded ? null : 6,
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
