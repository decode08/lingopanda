import 'package:flutter/material.dart';
import 'package:lingopanda/res/color.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback func;
  const CustomButton({required this.text, required this.func, super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.3,
      child: ElevatedButton(
        onPressed: widget.func,
        child: Text(
          widget.text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.appBarColor,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width * 0.02)))),
      ),
    );
  }
}
