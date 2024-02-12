import 'package:flutter/material.dart';

import '../../injection/injection_container.dart';
import '../../resources/text_styles.dart';
import '../singleton/ws_app_data.dart';

class WSCommonDialog extends StatefulWidget {
  final String headingText;
  final String? subHeadingText;
  final Widget body;
  final String? negativeBtnText;
  final String? positiveBtnText;
  final Function()? positiveBtnCallback;
  final bool showNegativeBtn;
  final bool showPositiveBtn;
  final Color? bodyColor;
  const WSCommonDialog({
    super.key,
    required this.headingText,
    required this.body,
    this.subHeadingText,
    this.negativeBtnText,
    this.positiveBtnText,
    this.positiveBtnCallback,
    this.bodyColor,
    this.showNegativeBtn = false,
    this.showPositiveBtn = false,
  });

  @override
  State<WSCommonDialog> createState() => _WSCommonDialogState();
}

class _WSCommonDialogState extends State<WSCommonDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _dialogAnimationController;
  late Animation<double> _dialogAnimation;
  late Animation<double> _dialogCurve;

  @override
  void initState() {
    super.initState();
    _dialogAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _dialogCurve = CurvedAnimation(
        parent: _dialogAnimationController, curve: Curves.fastOutSlowIn);
    _dialogAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_dialogCurve);

    //start the animation
    _dialogAnimationController.forward();
  }

  @override
  void dispose() {
    _dialogAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _dialogAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Material(
            color: widget.bodyColor ?? Colors.white,
            elevation: 15.0,
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  right: 8,
                  child: IconButton(
                      style: Theme.of(context).iconButtonTheme.style,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close,
                        color: di<WsAppData>().isDarkMode
                            ? Colors.white
                            : Colors
                                .blueGrey, //appTextTheme(context).displayMedium?.color,
                        size: 34,
                      )),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTop(),
                    _buildBottomBtns(),
                  ],
                ),
              ],
            ),
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
            widget.headingText,
            style: appTextTheme(context)
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          if (widget.subHeadingText != null)
            const SizedBox(
              height: 5,
            ),
          if (widget.subHeadingText != null)
            Text(
              widget.subHeadingText ?? '',
              style: appTextTheme(context)
                  .bodyMedium
                  ?.copyWith(color: Colors.blueGrey[800]),
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
        if (widget.showNegativeBtn)
          _buildButtonContainer(
              widget.negativeBtnText ?? 'Cancel',
              appTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: Colors.grey[800]),
              buttonStyle: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.white))),

        //Positive button
        if (widget.showPositiveBtn)
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
