import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final Color borderBolor;
  final bool isPassword;
  final bool isFilled;

  const CustomTextBox(
      {Key? key,
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
      this.borderBolor = Colors.black38,
      this.isPassword = false,  this.isFilled=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isObsText = false;
    return BlocProvider(
      create: (context) => PasswordShowBloc(),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: fontColor),
                textAlignVertical: TextAlignVertical.center,

                textAlign: textAlign!,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: isFilled,
                  labelText: caption,
                  labelStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w300,
                      fontSize: 14),
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400, fontWeight: FontWeight.w300),
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadious)),
                    // borderSide: const BorderSide(color: Colors.white)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadious),
                    borderSide: BorderSide(color: borderBolor, width: 0.5),
                  ),
                  suffixIcon: isPassword
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
                          ),
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
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
