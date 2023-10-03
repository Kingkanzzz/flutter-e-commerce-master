import 'package:flutter/material.dart';

class MainColors {
  static const MaterialColor maincolors = const MaterialColor( 
    0xffCC0033, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xffb8002e ),//10% 
      100: const Color(0xffa30029),//20% 
      200: const Color(0xff8f0024),//30% 
      300: const Color(0xff7a001f),//40% 
      400: const Color(0xff66001a),//50% 
      500: const Color(0xff520014),//60% 
      600: const Color(0xff3d000f),//70% 
      700: const Color(0xff29000a),//80% 
      800: const Color(0xff140005),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  );
}