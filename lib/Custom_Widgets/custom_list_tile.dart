import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final IconData? leadingIcon;
  final String? title;
  final String? trailingText;
  final bool? isTrailingNeeded;

  const CustomListTile({
    super.key,
    this.leadingIcon,
    this.title,
    this.trailingText,
    this.isTrailingNeeded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title ?? "title"),
      trailing: Text(isTrailingNeeded == true ? trailingText.toString() : ""),
    );
  }
}
