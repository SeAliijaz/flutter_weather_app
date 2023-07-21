import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String? title;
  final String? subtitle;
  final String? trailingText;
  final bool? isTrailingNeeded;
  final double? fontSize;
  final bool? isSubtitleNeeded;

  const CustomListTile({
    super.key,
    this.leadingIcon,
    this.title,
    this.subtitle,
    this.trailingText,
    this.isTrailingNeeded = false,
    this.fontSize,
    this.isSubtitleNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(
          title ?? "title",
          style: TextStyle(
            fontSize: fontSize,
          ),
        ),
        subtitle: Text(
          isSubtitleNeeded == true ? subtitle.toString() : "",
          style: TextStyle(),
        ),
        trailing: Text(
          isTrailingNeeded == true ? trailingText.toString() : "",
          style: TextStyle(),
        ),
      ),
    );
  }
}
