import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NewsListImageErrorWidget extends StatelessWidget {
  const NewsListImageErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          size: 40,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
