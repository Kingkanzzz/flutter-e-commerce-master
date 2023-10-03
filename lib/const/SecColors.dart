import 'package:flutter/material.dart';

class SecColors {
  static const MaterialColor seccolors = const MaterialColor( 
    0xfff5f5f5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xffC4C4C4 ),//10% 
      100: const Color(0xff9d9d9d),//20% 
      200: const Color(0xff7e7e7e),//30% 
      300: const Color(0xff656565),//40% 
      400: const Color(0xff515151),//50% 
      500: const Color(0xff414141),//60% 
      600: const Color(0xff3434343),//70% 
      700: const Color(0xff2a2a2a),//80% 
      800: const Color(0xff222222),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  );
}