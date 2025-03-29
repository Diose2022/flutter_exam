import 'package:flutter/cupertino.dart';

class Sizeconfig {
  static const double DESIGN_WIDTH = 375.0;
  static const double DESIGN_HEIGH = 812.0;

  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double pixelRatio;
  static late Orientation orientation;
  static bool isTablet = false;
  static bool isDarkMode = false;

  static final Map<int, double> _widthPercentages = {};
  static final Map<int, double> _heightPercentages = {};

  static void init(BuildContext context){
    //Permet de recuperer les infos de l'appareil
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    pixelRatio = _mediaQueryData.devicePixelRatio;
    isDarkMode = _mediaQueryData.platformBrightness == Brightness.dark;

    print("screenWith: $screenWidth");
    print("screeHeight: $screenHeight");
    print("Orientation: $orientation");
    print("PixelRation: $pixelRatio");
    print("isDarkmode: $isDarkMode");

  }
/*
Calcul une largeur proportionnel
Convertit une largeur du design de reference en une largeur adapte a l'ecrant actuel
 */
  static double getProportionateScreenWidth(double inputWidth){
    return (inputWidth / DESIGN_WIDTH) * screenWidth;
  }

/*
  Calcul une hauteur proportionnel
  Convertit une hauteur du design de reference en une hauteur adapte a l'ecrant actuel
  */
  static double getProportionateScreenHeight(double inputHeight){
    return (inputHeight / DESIGN_HEIGH) * screenHeight;
  }

}