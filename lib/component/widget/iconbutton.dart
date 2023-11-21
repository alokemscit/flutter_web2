// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyIconButton extends StatelessWidget {
  final String text;
  final Function() buttonClick;
  final IconData icon;
  final Color color;
  final double width;

  const MyIconButton({
    Key? key,
    required this.text,
    required this.buttonClick,
    required this.icon,
    this.color = const Color.fromARGB(255, 248, 248, 248),  this.width=0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IconButtonBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<IconButtonBloc, IconButtonBlocState>(
            builder: (context, state) {
              return InkWell(
                onHover: (value) {
                  context
                      .read<IconButtonBloc>()
                      .add(SetHoverStatus(isHover: value));
                  //  print(value.toString());
                },
                onTap: buttonClick,
                child: Container(
                  width: width==0?double.infinity:width,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black38, width: 0.1),
                    //  boxShadow: const [
                    //   BoxShadow(
                    //       blurRadius: 0.0, spreadRadius: 0.1, offset: Offset(0, 0))
                    // ]
                  ),
                  child: Row(
                    children: [
                      Container(
                        //color: Colors.red,
                        margin: const EdgeInsets.only(right: 2),
                        child: Icon(
                          icon,
                          size: 18,
                          weight: 0.1,
                          color: state.isHover == true
                              ? const Color.fromARGB(255, 100, 130, 143)
                              : const Color.fromARGB(255, 58, 56, 56),
                        ),
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: state.isHover == true
                                ? const Color.fromARGB(255, 100, 130, 143)
                                : const Color.fromARGB(255, 58, 56, 56),
                            backgroundColor: Colors.transparent),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class IconButtonBloc extends Bloc<IconButtonBlocEvent, IconButtonBlocState> {
  IconButtonBloc() : super(const MenubuttonBlocInitial(false)) {
    on<IconButtonBlocEvent>((event, emit) {
      if (event is SetHoverStatus) {
        emit(MenubuttonBlocInitial(event.isHover));
        //  print(event.isHover.toString());
      }
    });
  }
}

sealed class IconButtonBlocState {
  final bool isHover;
  const IconButtonBlocState(this.isHover);
}

final class MenubuttonBlocInitial extends IconButtonBlocState {
  const MenubuttonBlocInitial(super.isHover);
}

sealed class IconButtonBlocEvent {}

class SetHoverStatus extends IconButtonBlocEvent {
  final bool isHover;
  SetHoverStatus({required this.isHover});
}
