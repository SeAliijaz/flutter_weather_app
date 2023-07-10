import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String? title;
  final String? subtitle;
  final String? trailingText;
  final bool? isTrailingNeeded;
  final bool? isWhiteColorNeeded;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isSubtitleNeeded;

  const CustomListTile({
    super.key,
    this.leadingIcon,
    this.title,
    this.subtitle,
    this.trailingText,
    this.isTrailingNeeded = false,
    this.isWhiteColorNeeded = false,
    this.fontSize,
    this.fontWeight,
    this.isSubtitleNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: isWhiteColorNeeded == true ? Colors.white : Colors.black,
      ),
      title: Text(
        title ?? "title",
        style: TextStyle(
          fontSize: fontSize,
          color: isWhiteColorNeeded == true ? Colors.white : Colors.black,
          fontWeight: fontWeight,
        ),
      ),
      subtitle: Text(
        isSubtitleNeeded == true ? subtitle.toString() : "",
        style: TextStyle(
          color: isWhiteColorNeeded == true ? Colors.white : Colors.black,
          fontWeight: fontWeight,
        ),
      ),
      trailing: Text(
        isTrailingNeeded == true ? trailingText.toString() : "",
        style: TextStyle(
          color: isWhiteColorNeeded == true ? Colors.white : Colors.black,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
