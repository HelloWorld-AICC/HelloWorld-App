import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final int minLines;
  final int maxLines;
  final EdgeInsetsGeometry padding;
  final Function(String) onChanged;

  const CustomTextFormField({
    Key? key,
    this.hintText = "Enter text here...",
    this.hintStyle,
    this.textStyle,
    this.minLines = 1,
    this.maxLines = 10,
    this.padding = const EdgeInsets.all(8.0),
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.grey),
          // borderRadius: BorderRadius.circular(8),
          ),
      child: TextField(
        controller: _controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        style: widget.textStyle,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          border: InputBorder.none,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
