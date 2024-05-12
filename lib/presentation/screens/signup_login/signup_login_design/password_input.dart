import 'package:exercise_app/presentation/screens/signup_login/signup_login_design/text_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class PasswordInput extends StatefulWidget {
   PasswordInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.inputAction,
    required this.onPassChanged,
  }) : super(key: key);
  final IconData icon;
  final String hint;
  final TextInputAction inputAction;
  final void Function(String?) onPassChanged;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _passController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[600]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: _passController,
          onChanged: (value){
            widget.onPassChanged(value);
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                  color: Colors.white,
                  size: 20,
                  _isHidden ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
                  onPressed: _toggleVisibility,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 20),
            border: InputBorder.none,
            hintText: widget.hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            hintStyle: kBodyText,
          ),
          obscureText: _isHidden,
          style: kBodyText,
          textInputAction: widget.inputAction,
        ),
      ),
    );
  }
}


/*
*/
