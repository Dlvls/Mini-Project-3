import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class Styles {
  static final TextStyle appbarText = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static final TextStyle title = GoogleFonts.plusJakartaSans(
      fontSize: 14, fontWeight: FontWeight.w600, color: primaryText);

  static final TextStyle subtitle = GoogleFonts.plusJakartaSans(
      fontSize: 14, color: primaryText);

  static final TextStyle category = GoogleFonts.plusJakartaSans(
      fontSize: 12, fontWeight: FontWeight.w500, color: secondaryText);
}
