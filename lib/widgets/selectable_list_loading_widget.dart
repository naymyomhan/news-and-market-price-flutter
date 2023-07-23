import 'package:flutter/material.dart';

class SelectableListLoadingWidget extends StatelessWidget {
  const SelectableListLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: Colors.grey.shade200,
    );
  }
}
