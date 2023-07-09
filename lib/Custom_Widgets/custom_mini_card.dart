import 'package:flutter/material.dart';

class CustomMiniCard extends StatelessWidget {
  final IconData? iconData;
  final String? title;

  const CustomMiniCard({
    super.key,
    this.iconData,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Expanded(child: Icon(iconData)),
            Expanded(
              child: Text(title ?? "title"),
            ),
          ],
        ),
      ),
    );
  }
}
