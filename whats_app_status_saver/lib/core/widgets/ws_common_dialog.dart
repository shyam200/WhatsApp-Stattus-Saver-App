import 'package:flutter/material.dart';
import '../../resources/text_styles.dart';

class WSCommonDialog extends StatefulWidget {
  final String? headingText;
  final Widget body;
  final String? negativeBtnText;
  final String? positiveBtnText;
  final Function() positiveBtnCallback;
  const WSCommonDialog({
    super.key,
    required this.headingText,
    required this.body,
    this.negativeBtnText,
    this.positiveBtnText,
    required this.positiveBtnCallback,
  });

  @override
  State<WSCommonDialog> createState() => _WSCommonDialogState();
}

class _WSCommonDialogState extends State<WSCommonDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: Colors.white,
          elevation: 15.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTop(),
              _buildBottomBtns(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTop() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.headingText ?? '',
            style: appTextTheme(context).bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
                fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          widget.body,
        ],
      ),
    );
  }

  _buildBottomBtns() {
    return Row(
      children: [
        //Ngative button
        _buildButtonContainer(widget.negativeBtnText ?? 'Cancel',
            appTextTheme(context).labelLarge?.copyWith(color: Colors.grey[800]),
            buttonStyle: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white))),

        //Positive button
        _buildButtonContainer(
            widget.positiveBtnText ?? 'Ok', appTextTheme(context).labelLarge,
            onPressed: widget.positiveBtnCallback),
      ],
    );
  }

  Expanded _buildButtonContainer(
    String buttonText,
    TextStyle? textStyle, {
    ButtonStyle? buttonStyle,
    Function()? onPressed,
  }) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        child: TextButton(
            style: buttonStyle,
            onPressed: onPressed ??
                () {
                  Navigator.of(context).pop();
                },
            child: Text(buttonText, style: textStyle)),
      ),
    );
  }
}
