import 'package:flutter/cupertino.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 20,
          width: 4,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: Color(0xFF343434)),
        ),
        Text(
          text,
          style: TextStyle().copyWith(
            fontSize: 17.0,
          ),
        ),
        const Spacer(),
        CupertinoButton(
          child: Image.asset(
            'assets/images/icon/avatar.png',
            width: 36,
            height: 36,
          ),
          onPressed: onPressed as void Function()?,
        )
      ],
    );
  }
}
