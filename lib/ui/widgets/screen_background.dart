import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {

  final Widget child;

  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        //------------------Background image -----------
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          height: double.maxFinite,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),

        //---------------------child -----------------
        SafeArea(
            child: child
        )

      ],
    );
  }
}
