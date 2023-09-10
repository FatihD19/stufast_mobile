import 'package:flutter/material.dart';
import 'package:stufast_mobile/theme.dart';

enum ChipType {
  Basic,
  Advanced,
  Intermediate,
}

class CustomChip extends StatelessWidget {
  final String label;
  ChipType? type;

  CustomChip({required this.label, this.type});

  Color _getChipColor(String label) {
    switch (label) {
      case 'Basic':
        return Color(0xFF50ABEC);
      case 'Advanced':
        return Color(0xFFFF7474);
      case 'Intermediate':
        return Color(0xFFEEAA6C);
      default:
        return Color(0xFF50ABEC);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: new Matrix4.identity()..scale(0.9),
      child: Chip(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _getChipColor(label)),
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: primaryTextStyle.copyWith(
              fontWeight: bold, color: _getChipColor(label), fontSize: 12),
        ),
      ),
    );
  }
}
