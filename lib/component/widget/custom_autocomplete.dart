import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAutoComplete extends StatelessWidget {
  const CustomAutoComplete({
    super.key,
    required List<String> fruitOptions,
    required this.caption,
    this.width = 65,
    this.maxlength = 100,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.height = 32,
    this.textAlign = TextAlign.start,
    required this.onChange,
    this.dropDownHeight = 80,
    this.dropDownWidth = 65,
    this.onSelected,
    this.borderColor=Colors.black38
  }) : _fruitOptions = fruitOptions;

  final List<String> _fruitOptions;
  final String caption;
  final double width;
  final int maxlength;
  final TextEditingController controller;
  final TextInputType? textInputType;

  final double? height;
  final TextAlign? textAlign;
  final Function(String value) onChange;
  final double dropDownHeight;
  final double dropDownWidth;
  final Function(String)? onSelected;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue fruitTextEditingValue) {
          if (fruitTextEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return _fruitOptions.where((String option) {
            return option.contains(fruitTextEditingValue.text.toLowerCase());
          });
        },
        fieldViewBuilder: (
          BuildContext context,
          //TextEditingController textEditingController,
          controller,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          return TextFormField(
            onChanged: (value) => onChange(value),
            maxLength: maxlength,
            controller: controller,
            // canRequestFocus : false,
            maxLines: 1,

            keyboardType: textInputType,
            inputFormatters: textInputType == TextInputType.multiline
                ? []
                : textInputType == TextInputType.text
                    ? []
                    : [
                        textInputType == TextInputType.number
                            ? FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*'))
                            : FilteringTextInputFormatter.digitsOnly
                      ],

            //   textCapitalization : TextCapitalization.none,
            // keyboardType: TextInputType.number,
            style:
                GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w600),
            textAlignVertical: TextAlignVertical.center,

            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelText: caption,
               labelStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w300,
                      fontSize: 13),
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.w300),
              counterText: '',
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 0.5),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),

            // controller: textEditingController,
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        optionsViewBuilder: (
          BuildContext context,
          onSelected,
          Iterable<String> options,
        ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              shape: Border.all(color: Colors.grey),
              elevation: 0,
              color: Colors.white,
              child: SizedBox(
                height: dropDownHeight,
                width: dropDownWidth,
                child: ListView.builder(
                  // reverse : true,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String option = options.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        onSelected(option);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Colors.grey.shade200, width: 0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(option),
                          )),
                    );
                  },
                ),
              ),
            ),
          );
        },
        onSelected: (String value) {
          controller.text = value;
          //debugPrint('You just selected $value');
          // ignore: void_checks
          return onSelected!(value);
        },
      ),
    );
  }
}
