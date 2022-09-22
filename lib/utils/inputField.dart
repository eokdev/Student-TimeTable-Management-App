// ignore_for_file: file_names, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sstm/utils/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? textEditingController;
  final Widget? widget;
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.textEditingController,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subtitletyle,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(left: 10),
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  controller: textEditingController,
                  cursorColor: Get.isDarkMode ? Colors.grey : Colors.grey[800],
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor, width: 0)),
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        ),
      ],
    );
  }
}
