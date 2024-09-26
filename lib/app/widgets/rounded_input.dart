import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/my_colors.dart';
import '../style/text_style/description_txt.dart';

class RoundedInputIcon extends StatefulWidget {
  final String hintTxt;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final double maxWidth = 600;

  const RoundedInputIcon({
    Key? key,
    required this.hintTxt,
    required this.icon,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  _RoundedInputIconState createState() => _RoundedInputIconState();
}

class _RoundedInputIconState extends State<RoundedInputIcon> {
  final FocusNode focusNode = FocusNode();
  late final ValueNotifier<bool> focusNotifier;

  @override
  void initState() {
    super.initState();
    focusNotifier = ValueNotifier(focusNode.hasFocus);
    focusNode.addListener(() {
      focusNotifier.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    focusNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: Container(
        width: Get.width - 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          focusNode: focusNode,
          decoration: InputDecoration(
            prefixIcon: ValueListenableBuilder(
              valueListenable: focusNotifier,
              builder: (context, hasFocus, child) {
                return Icon(
                  widget.icon,
                  color: hasFocus ? MyColors.blue : MyColors.cutGrey,
                );
              },
            ),
            label: DescriptionTxt(txt: widget.hintTxt),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: MyColors.cutGrey, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: MyColors.blue, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
