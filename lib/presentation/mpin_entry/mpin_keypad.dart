// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MpinKeypad extends StatelessWidget {
  final Function(String) numberKeyPressed;
  final VoidCallback backSpacePressed;
  final VoidCallback donePressed;
  const MpinKeypad({
    Key? key,
    required this.numberKeyPressed,
    required this.backSpacePressed,
    required this.donePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1 / .5),
        itemCount: 12,
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 20.0),
        itemBuilder: (context, index) {
          return Center(
            child: index < 9
                ? NumberKey(
                    index: index + 1, numberKeyPressed: numberKeyPressed)
                : index == 9
                    ? IconKey(
                        icon: Icons.backspace_rounded,
                        onPressed: backSpacePressed)
                    : index == 11
                        ? IconKey(
                            icon: Icons.check_circle_rounded,
                            size: 80.0,
                            onPressed: donePressed)
                        : NumberKey(
                            index: 0, numberKeyPressed: numberKeyPressed),
          );
        },
      ),
    );
  }
}

class IconKey extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onPressed;
  const IconKey({
    Key? key,
    required this.icon,
    this.size = 32.0,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      icon: Icon(
        icon,
        size: size,
        color: Colors.indigo[700],
      ),
    );
  }
}

class NumberKey extends StatelessWidget {
  final Function(String) numberKeyPressed;
  final int index;
  const NumberKey({
    Key? key,
    required this.numberKeyPressed,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        numberKeyPressed.call(index.toString());
      },
      child: Text(
        '$index',
        style: TextStyle(fontSize: 32.0, color: Colors.indigo[700]),
      ),
    );
  }
}
