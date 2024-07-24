import 'package:flutter/material.dart';

const kWhite = Color(0xFFFFFFFF);

// const kPrimary = Color(0xFF00C2B3);
const kPrimary = Color(0xFF0192ff);
const kSecondary = Color(0xFF00C2B3);

const kPrimaryText = Color(0xFF0F153F);

const kSecondaryText = Color(0xFF9C9FB7);

const kRed = Color(0xFFFC4850);

const kTextRegular14 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 14,
  color: kPrimaryText,
);

const kTextRegular16 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 16,
  color: kPrimaryText,
);

const kTextRegular22 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22,
  color: kPrimaryText,
);

const kTextRegular32 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 32,
  color: kPrimaryText,
);

const kTextMedium14 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 14,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);
const kTextMedium16 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 16,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

const kTextMedium22 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

const kTextMedium32 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 32,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

const kTextBold14 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 14,
  color: kPrimaryText,
  fontWeight: FontWeight.bold,
);
const kTextBold16 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 16,
  color: kPrimaryText,
  fontWeight: FontWeight.bold,
);

const kTextBold22 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 22,
  color: kPrimaryText,
  fontWeight: FontWeight.bold,
);

const kTextBold32 = TextStyle(
  fontFamily: 'Cairo',
  fontSize: 32,
  color: kPrimaryText,
  fontWeight: FontWeight.w500,
);

ButtonStyle kMainButton = ElevatedButton.styleFrom(
  backgroundColor: kPrimary,
  foregroundColor: kWhite,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: BorderSide.none,
  ),
  minimumSize: const Size.fromHeight(56),
);

ButtonStyle kSecondaryButton = ElevatedButton.styleFrom(
  backgroundColor: kWhite,
  foregroundColor: kPrimary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
    side: const BorderSide(color: kPrimary, width: 2),
  ),
  minimumSize: const Size.fromHeight(56),
);
