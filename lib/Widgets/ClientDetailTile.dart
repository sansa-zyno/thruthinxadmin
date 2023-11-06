import 'package:flutter/material.dart';

class ClientDetailTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final String? subtitle;

  ClientDetailTile({this.icon, this.subtitle, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey[350],
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
      title: Text(title!),
      subtitle: Text(subtitle!),
    );
  }
}
