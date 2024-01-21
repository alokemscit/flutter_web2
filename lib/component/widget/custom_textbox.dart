import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../settings/config.dart';

class CustomTextBox extends StatelessWidget {
  final String caption;
  final double width;
  final int maxlength;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? maxLine;
  final double? height;
  final TextAlign? textAlign;
  final Function(String value) onChange;
  final double borderRadious;
  final Color fontColor;
  final Color borderColor;
  final bool isPassword;
  final bool isFilled;
  final bool isReadonly;
  final bool isDisable;
  final Color hintTextColor;
  final Color labelTextColor;

  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderwidth;
  final Color surfixIconColor;

  const CustomTextBox({
    super.key,
    required this.caption,
    this.width = 65,
    this.maxlength = 6,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.maxLine = 1,
    this.height = 32,
    this.textAlign = TextAlign.start,
    required this.onChange,
    this.borderRadious = 4.0,
    this.fontColor = Colors.black87,
    this.borderColor = Colors.black,
    this.isPassword = false,
    this.isFilled = false,
    this.isReadonly = false,
    this.isDisable = true,
    this.hintTextColor = Colors.black,
    this.labelTextColor = Colors.black,
    this.focusedBorderColor = CPLineCChart,
    this.focusedBorderWidth = 0.5,
    this.enabledBorderColor = CPLineCChart,
    this.enabledBorderwidth = 0.25,  this.surfixIconColor=kWebHeaderColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isObsText = false;
    return BlocProvider(
      create: (context) => PasswordShowBloc(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: SizedBox(
          //  padding: const EdgeInsets.only(top: 4),
          // color: Colors.amber,
          width: width,
          height: height,

          // padding: const EdgeInsets.only(bottom: 12),
          // color:Colors.amber, // const Color.fromARGB(255, 255, 255, 255),
          child: BlocBuilder<PasswordShowBloc, PasswordIconState>(
            builder: (context, state) {
              if (state is PasswordIconShowState) {
                isObsText = state.isShow;
              }
              return TextField(
                enabled: isDisable,
                readOnly: isReadonly,
                onChanged: (value) => onChange(value),
                keyboardType: textInputType,
                obscureText: !isObsText ? isPassword : false,
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
                maxLength: maxlength,
                // canRequestFocus : false,
                maxLines: maxLine,
                //   textCapitalization : TextCapitalization.none,
                // keyboardType: TextInputType.number,
                style: GoogleFonts.cabin(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: fontColor),
                textAlignVertical: TextAlignVertical.center,

                textAlign: textAlign!,
                decoration: InputDecoration(
                    fillColor: Colors
                        .white, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
                    filled: isFilled,
                    labelText: caption,
                    labelStyle: TextStyle(
                        color: labelTextColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 14),
                    hintStyle: TextStyle(
                        color: hintTextColor, fontWeight: FontWeight.w300),
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(borderRadious)),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadious),
                      borderSide: BorderSide(
                          color: focusedBorderColor, width: focusedBorderWidth),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(borderRadious),
                      borderSide: BorderSide(
                          color: enabledBorderColor, width: enabledBorderwidth),
                    ),
                    suffixIcon: isPassword
                        ? InkWell(
                            onTap: () {
                              context.read<PasswordShowBloc>().add(
                                  PasswordShowSetEvent(isShow: !isObsText));
                            },
                            child: Icon(
                              !isObsText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20,color: surfixIconColor,
                            ),
                          )
                        : null,
                    contentPadding: const EdgeInsets.only(
                        bottom: 8,
                        left: 6,
                        right: 6) //.symmetric(vertical: 8, horizontal: 6),
                    ),
                controller: controller,
              );
            },
          ),
        ),
      ),
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
