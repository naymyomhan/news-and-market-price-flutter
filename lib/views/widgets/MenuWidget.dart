import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/utils/constants.dart';

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
        height: 135,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 5,
              color: myPrimaryColor.withOpacity(0.2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svg/$iconName.svg",
              width: 40,
              height: 40,
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              menuName,
              style: const TextStyle(
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
