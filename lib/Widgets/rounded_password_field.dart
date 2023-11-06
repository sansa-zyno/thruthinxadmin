import 'package:flutter/material.dart';
import 'package:truthinxadmin/Widgets/text_field_container.dart';
import 'package:truthinxadmin/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final iconColor;
  final String? hint;
  const RoundedPasswordField({
    Key? key,
    this.iconColor,
    this.onChanged,
    this.hint,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: !visibility,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hint,
          icon: Icon(
            Icons.lock,
            color: widget.iconColor ?? kPrimaryColor,
          ),
          suffixIcon: IconButton(
              icon: Icon(
                visibility
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: widget.iconColor ?? kPrimaryColor,
              ),
              onPressed: () {
                setState(() {
                  visibility = !visibility;
                });
              }),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
