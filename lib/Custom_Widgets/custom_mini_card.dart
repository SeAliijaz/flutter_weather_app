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
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
        ),
        height: MediaQuery.sizeOf(context).height * 0.30,
        width: MediaQuery.sizeOf(context).height * 0.25,
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
