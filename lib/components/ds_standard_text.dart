import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DSStandardText extends StatelessWidget {
  final Color color;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  const DSStandardText(
      {Key? key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
