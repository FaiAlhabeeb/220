import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.colors.dart';


class AppTextStyle {
  static TextStyle title = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  static TextStyle subTitle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static TextStyle hintText = GoogleFonts.inter(
    fontSize: 14,
    color: const Color(0xFF1B2A3B).withOpacity(0.40),
    fontWeight: FontWeight.w400,
  );

  static TextStyle inputText = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
}