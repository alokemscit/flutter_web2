// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/const.dart';

class CustomTextBox extends StatefulWidget {
  String caption;
  double width;
  int maxlength;
  TextEditingController controller;
  TextInputType? textInputType;
  int? maxLine;
  double? height;
  TextAlign? textAlign;

  //final Function(RawKeyEvent event) onKey;
  double borderRadious;
  Color fontColor;
  Color borderColor;
  bool isPassword;
  bool isFilled;
  bool isReadonly;
  bool isDisable;
  Color hintTextColor;
  Color labelTextColor;

  Color focusedBorderColor;
  double focusedBorderWidth;
  Color enabledBorderColor;
  double enabledBorderwidth;
  Color surfixIconColor;
  void Function(String v)? onChange;
  void Function(String) onSubmitted;
  void Function() onEditingComplete;
  FocusNode? focusNode;
  bool isCapitalization;
  bool iSAutoCorrected;
  Color disableBackColor;
  Color fillColor;
  String hintText;
  FontWeight fontWeight;
  bool isError;

  CustomTextBox(
      {super.key,
      this.caption = '',
      this.width = 65,
      this.maxlength = 100,
      required this.controller,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.height = 28,
      this.textAlign = TextAlign.start,
      this.onChange,
      this.borderRadious = 2.0,
      this.fontColor = Colors.black,
      this.borderColor = Colors.black,
      this.isPassword = false,
      this.isFilled = false,
      this.isReadonly = false,
      this.isDisable = false,
      this.hintTextColor = Colors.black,
      this.labelTextColor = appColorGrayDark,
      this.focusedBorderColor = Colors.black,
      this.focusedBorderWidth = 0.4,
      this.enabledBorderColor = Colors.grey,
      this.enabledBorderwidth = 0.6,
      this.disableBackColor = appColorGrayLight,
      this.surfixIconColor = appColorLogo,
      void Function(String)? onSubmitted,
      void Function()? onEditingComplete,
      this.focusNode,
      this.fontWeight = FontWeight.w500,
      this.hintText = '',
      this.fillColor = Colors.white,
      this.isCapitalization = false,
      this.iSAutoCorrected = false,
      this.isError = false})
      : onSubmitted = onSubmitted ?? ((String v) {}),
        onEditingComplete = onEditingComplete ?? (() {});

  @override
  State<CustomTextBox> createState() => _CustomTextBoxState();
}

class _CustomTextBoxState extends State<CustomTextBox> {

  
  @override
  Widget build(BuildContext context) {
    bool isObsText = false;

    return BlocProvider(
      create: (context) => PasswordShowBloc(),
      child: Container(
        //padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadious),
          color: widget.isDisable ? widget.disableBackColor : Colors.white,
          // boxShadow: [
          //   BoxShadow(blurRadius: 0, spreadRadius: 0.01, color: borderColor)
          // ]
        ),
        //  padding: const EdgeInsets.only(top: 4),
        // color: Colors.amber,
        width: widget.width,
        height: widget.height,

        // padding: const EdgeInsets.only(bottom: 12),
        // color:Colors.amber, // const Color.fromARGB(255, 255, 255, 255),
        child: BlocBuilder<PasswordShowBloc, PasswordIconState>(
          builder: (context, state) {
            if (state is PasswordIconShowState) {
              isObsText = state.isShow;
            }
            return TextField(
              textDirection: widget.textAlign == TextAlign.right
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              autocorrect: widget.iSAutoCorrected,
              textCapitalization: widget.isCapitalization == true
                  ? TextCapitalization.characters
                  : TextCapitalization.none,
              focusNode: widget.focusNode,
              enabled: !widget.isDisable,
              readOnly: widget.isReadonly,
              onChanged: (value) {
                if (widget.textInputType == TextInputType.datetime) {
                  // print(value);
                  if (value.length == 10) {
                    if (!mIsValidateDate(value)) {
                      widget.controller.text = '';
                      return;
                    }
                  }
                }
                setState(() {
                  widget.isError = false;
                });
                if (widget.onChange != null) {
                  widget.onChange!(value);
                }
              },
              onSubmitted: (v) {
                widget.onSubmitted(v);
              },

              onEditingComplete: () {
                // print("12121");
                widget.onEditingComplete();
              },
              keyboardType: widget.textInputType,
              obscureText: !isObsText ? widget.isPassword : false,
              inputFormatters: widget.isCapitalization
                  ? [upperCaseTextFormatter()]
                  : widget.textInputType == TextInputType.multiline
                      ? []
                      : widget.textInputType == TextInputType.emailAddress
                          ? []
                          : widget.textInputType == TextInputType.text
                              ? []
                              : widget.textInputType == TextInputType.datetime
                                  ? [
                                      //dateFormatter,
                                      LengthLimitingTextInputFormatter(
                                          10), // Limit to 10 characters
                                      DateInputFormatter(),
                                    ]
                                  : [
                                      widget.textInputType == TextInputType.number
                                          ? FilteringTextInputFormatter.allow(
                                              RegExp(r'^\d+\.?\d*'))
                                          : FilteringTextInputFormatter
                                              .digitsOnly
                                    ],
              maxLength: widget.maxlength,
              // canRequestFocus : false,
              maxLines: widget.maxLine,
              //   textCapitalization : TextCapitalization.none,
              // keyboardType: TextInputType.number,
              style: customTextStyle.copyWith(
                  fontSize: 12, fontWeight: widget.fontWeight, color: widget.fontColor),
              textAlignVertical: TextAlignVertical.center,

              textAlign: widget.textAlign!,
              decoration: InputDecoration(
                  //errorBorder: OutlineInputBorder(),
                  // errorStyle: TextStyle(fontSize: 4,),
                  //error: Icon(Icons.error,size: 4,),

                  fillColor: !widget.isDisable
                      ? widget.fillColor
                      : Colors
                          .white70, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
                  filled: widget.isFilled,
                  labelText: widget.caption,
                  labelStyle: customTextStyle.copyWith(
                      color: widget.labelTextColor.withOpacity(0.8),
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: widget.hintTextColor.withOpacity(0.3),
                      fontWeight: FontWeight.w300),
                  counterText: '',
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadious),
                    borderSide: BorderSide(
                        color: widget.isError
                            ? Colors.red
                            : widget.enabledBorderColor.withOpacity(0.8),
                        width: widget.enabledBorderwidth),
                  ),
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(widget.borderRadious)),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadious),
                    borderSide: BorderSide(
                        color: widget.isError ? Colors.red : widget.focusedBorderColor,
                        width: widget.focusedBorderWidth),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadious),
                    borderSide: BorderSide(
                        color: widget.isError ? Colors.red : widget.enabledBorderColor,
                        width: widget.enabledBorderwidth),
                  ),
                  suffixIcon: widget.isPassword
                      ? InkWell(
                          onTap: () {
                            context
                                .read<PasswordShowBloc>()
                                .add(PasswordShowSetEvent(isShow: !isObsText));
                          },
                          child: Icon(
                            !isObsText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                            color: widget.surfixIconColor,
                          ),
                        )
                      : null,
                  contentPadding: const EdgeInsets.only(
                      bottom: 8,
                      left: 6,
                      right: 6) //.symmetric(vertical: 8, horizontal: 6),
                  ),
              controller: widget.controller,
            );
          },
        ),
      ),
    );
  }
}

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String oldText = oldValue.text;
    String newText = newValue.text;

    // Prevent invalid characters (only digits and "/")
    if (!RegExp(r'^[0-9/]*$').hasMatch(newText)) {
      return oldValue;
    }

    // Handle backspace - allow deletion of "/"
    if (oldText.length > newText.length) {
      return newValue;
    }

    // Automatically insert "/" at the 3rd and 5th positions
    if (newText.length == 2 && !newText.contains("/")) {
      newText += '/';
    } else if (newText.length == 5 && newText.lastIndexOf("/") == 2) {
      newText += '/';
    }

    // Ensure "/" is only at the 3rd and 5th positions
    if (newText.length > 3 && newText[2] != '/') {
      newText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    }
    if (newText.length > 6 && newText[5] != '/') {
      newText = '${newText.substring(0, 5)}/${newText.substring(5)}';
    }

    // Validate day (dd) and month (MM)
    if (newText.length >= 2) {
      String day = newText.substring(0, 2);
      if (int.tryParse(day) != null &&
          (int.parse(day) < 1 || int.parse(day) > 31)) {
        return oldValue; // Invalid day
      }
    }
    if (newText.length >= 5) {
      String month = newText.substring(3, 5);
      if (int.tryParse(month) != null &&
          (int.parse(month) < 1 || int.parse(month) > 12)) {
        return oldValue; // Invalid month
      }
    }

    // Truncate if the user tries to exceed the format
    if (newText.length > 10) {
      newText = newText.substring(0, 10);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}


class upperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

abstract class PasswordIconState {}

class PasswordIconInitState extends PasswordIconState {
  final bool isShow;
  PasswordIconInitState({required this.isShow});
}

class PasswordIconShowState extends PasswordIconState {
  final bool isShow;
  PasswordIconShowState({required this.isShow});
}

abstract class PasswordShowEvent {}

class PasswordShowSetEvent extends PasswordShowEvent {
  final bool isShow;
  PasswordShowSetEvent({required this.isShow});
}

class PasswordShowBloc extends Bloc<PasswordShowEvent, PasswordIconState> {
  PasswordShowBloc() : super(PasswordIconInitState(isShow: false)) {
    on<PasswordShowSetEvent>((event, emit) {
      emit(PasswordIconShowState(isShow: event.isShow));
    });
  }
}
