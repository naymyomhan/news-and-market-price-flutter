import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';

import '../helpers/constants.dart';

class MenuWidget extends StatelessWidget {
  final String menuName;
  final String iconName;
  final int menuIndex;
  final Function changeCurrentPage;

  const MenuWidget({
    super.key,
    required this.menuName,
    required this.iconName,
    required this.menuIndex,
    required this.changeCurrentPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeCurrentPage(menuIndex);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20),
        width: 100,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: myPrimaryColor.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/" + iconName + ".svg",
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 10),
            Text(
              menuName,
              style: TextStyle(
                color: myTextColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
