import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:web_2/component/widget/custom_snakbar.dart';
import 'package:web_2/model/model_user.dart';

import '../../component/settings/notifers/auth_provider.dart';
import '../../component/settings/rive_config.dart';
import '../../component/widget/custom_textbox.dart';
import '../../data/data_api.dart';
import '../../model/user_model.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Login({super.key});

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;

  // StateMachineController getRiveController(Artboard artboard) {
  //   StateMachineController? controller =
  //       StateMachineController.fromArtboard(artboard, "State Machine 1");
  //   artboard.addController(controller!);
  //   return controller;
  // }
  final TextEditingController _uid = TextEditingController();
  final TextEditingController _pws = TextEditingController();
  late bool isLoading;
  bool isDisable = false;
  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              width: MediaQuery.of(context).size.width * 1.7,
              left: 50,
              bottom: 100,
              child: Image.asset(
                "assets/Backgrounds/Spline.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 30),
                child: const SizedBox(),
              ),
            ),
            const RiveAnimation.asset(
              "assets/RiveAssets/shapes.riv",
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: const SizedBox(),
              ),
            ),
            AnimatedPositioned(
              // top: isShowSignInDialog ? -50 : 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 260),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Center(
                        child: BlocProvider(
                          create: (context) => LoginBloc(
                              Provider.of<AuthProvider>(context,
                                  listen: false)),
                          child: Container(
                            decoration: BoxDecoration(
                                //color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                // border: Border.all(color: const Color.fromARGB(255, 255, 255, 255),width: 0.1),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 1, 0, 12)
                                        .withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 0),
                                  )
                                ]),
                            width: 350,
                            height: 350,
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                if (state is LoginInitSate) {
                                  isLoading = false;
                                  isDisable = false;
                                }
                                if (state is LoginRefrashSate) {
                                  isLoading = false;
                                  isDisable = false;
                                  print('Refresh');
                                }
                                if (state is LoginSubmitSate) {
                                  isDisable = true;
                                  isLoading = true;
                                  // error.fire();
                                }
                                if (state is LoginSuccessSate) {
                                  // isLoading = false;
                                  //confetti.fire();
                                  //isDisable = false;
                                  check.fire();
                                  // error.fire();
                                  // isDisable = false;
                                }
                                if (state is LoginErrorSate) {
                                  // isLoading = false;
                                  //confetti.fire();
                                  //isDisable = false;
                                  // check.fire();
                                  error.fire();
                                  // isDisable = false;
                                }
                                if (state is LoginNavigateSate) {
                                  isLoading = false;
                                  isDisable = false;
                                  confetti.fire();
                                  //check.fire();

                                  //  Navigator.pop(context);
                                }

                                return Stack(children: [
                                  Positioned(
                                    // width: MediaQuery.of(context).size.width * 1.7,
                                    right: 8,
                                    top: 1,
                                    child: Image.asset(
                                      "assets/images/logo.png",
                                      width: 100,
                                      height: 40,
                                      color:
                                          const Color.fromARGB(255, 2, 174, 253)
                                              .withOpacity(0.7),
                                      // fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    right: 8,
                                    top: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        CustomTextBox(
                                          //isPassword:true,

                                          height: 42,
                                          fontColor: Colors.white,

                                          caption: 'EMP ID',
                                          borderRadious: 10.0,

                                          width: 300,
                                          maxlength: 4,
                                          controller: _uid,
                                          onChange: (String value) {},
                                        ),

                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CustomTextBox(
                                          isPassword: true,
                                          height: 42,
                                          fontColor: Colors.white,
                                          caption: 'Password',
                                          borderRadious: 10.0,
                                          width: 300,
                                          maxlength: 20,
                                          controller: _pws,
                                          onChange: (String value) {},
                                        ),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        // MyIconButton(buttonClick: () {

                                        // }, text: 'Login', icon: Icons.lock_open ,width: 75,
                                        // color: Color.fromARGB(255, 2, 112, 131) .withOpacity(0.5),)

                                        ElevatedButton.icon(
                                          onPressed: () {
                                            if (_uid.text.length < 3 ||
                                                _pws.text.isEmpty) {
                                              CustomSnackbar(
                                                  context: context,
                                                  message:
                                                      "Invalid User ID or Password!",
                                                  type: MsgType.error);

                                              return;
                                            }

                                            context
                                                .read<LoginBloc>()
                                                .add(LoginSubmitEvent(
                                                  uid: _uid.text.toString(),
                                                  pws: _pws.text.toString(),
                                                ));
                                          },
                                          icon: const Icon(
                                            Icons.lock_open_rounded,
                                            size: 20,
                                          ),
                                          label: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Text("Login"),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(const Color.fromARGB(
                                                        255, 117, 117, 117)
                                                    .withOpacity(0.01)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // ignore: dead_code
                                  isLoading
                                      ? Customposition(
                                          isDisable: isDisable,
                                          size: 80,
                                          child: RiveAnimation.asset(
                                            "assets/RiveAssets/check.riv",
                                            onInit: (artboard) {
                                              StateMachineController
                                                  controller =
                                                  getRiveController(artboard);
                                              check =
                                                  controller.findSMI("Check")
                                                      as SMITrigger;
                                              error =
                                                  controller.findSMI("Error")
                                                      as SMITrigger;
                                              reset =
                                                  controller.findSMI("Reset")
                                                      as SMITrigger;
                                            },
                                          ))
                                      : const SizedBox(),

                                  Customposition(
                                      child: Transform.scale(
                                    scale: 7,
                                    child: RiveAnimation.asset(
                                      "assets/RiveAssets/confetti.riv",
                                      onInit: (artboard) {
                                        StateMachineController controller =
                                            getRiveController(artboard);

                                        confetti = controller.findSMI(
                                            "Trigger explosion") as SMITrigger;
                                      },
                                    ),
                                  ))
                                ]);
                              },
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Your Best Friend for find doctors",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Customposition extends StatelessWidget {
  const Customposition(
      {super.key,
      this.size = 100,
      required this.child,
      this.isDisable = false});
  final double size;
  final Widget child;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: isDisable
          ? Container(
              color: Colors.white.withOpacity(0.05),
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(width: size, height: size, child: child),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                const Spacer(),
                SizedBox(width: size, height: size, child: child),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
    );
  }
}

abstract class LoginState {}

class LoginInitSate extends LoginState {}

class LoginRefrashSate extends LoginState {}

class LoginSubmitSate extends LoginState {}

class LoginErrorSate extends LoginState {
  final String msg;

  LoginErrorSate({required this.msg});
}

class LoginSuccessSate extends LoginState {}

class LoginNavigateSate extends LoginState {}

class LoginOutSate extends LoginState {}

abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  final String uid;
  final String pws;

  LoginSubmitEvent({required this.uid, required this.pws});
}

class LogOutEvent extends LoginEvent {}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthProvider authProvider;
  LoginBloc(this.authProvider) : super(LoginInitSate()) {
    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginSubmitSate());
      var apiRepository = data_api();
      late List<dynamic> mList = [];
      try {
        mList = await apiRepository.createLead([
          {
            "tag": "35",
            "p_emp_id": event.uid,
            "p_emp_pws": event.pws,
            "p_token": "0"
          }
        ], "userlogin");
        //  print(event.pws);
      } on Exception catch (e) {
        //  print(e.toString());
      }

      List<ModelUser> lst =
          mList.map((post) => ModelUser.fromJson(post)).toList();
      // print(lst[0].eMPNAME);
      await Future.delayed(const Duration(milliseconds: 1000));

      if (lst.isEmpty) {
        emit(LoginErrorSate(msg: 'Invalid User ID or Passwors'));
        //return;
      } else if (lst[0].status.toString() != '1') {
        // print(lst[0].sMSG.toString());
        emit(LoginErrorSate(msg: lst[0].msg.toString()));

        // return;
      } else {
        emit(LoginSuccessSate());

        await Future.delayed(const Duration(milliseconds: 2000));
        emit(LoginNavigateSate());
        await Future.delayed(const Duration(milliseconds: 2000));
        // ignore: use_build_context_synchronously
        ModelUser lsta = lst.first;
        authProvider.login(
            lsta.uid!,
            lsta.cid!,
            lsta.depId!,
            lsta.desigId!,
            lsta.name!,
            lsta.img!,
            lsta.code!,
            lsta.cname!,
            lsta.dpname!,
            lsta.dgname!,
            lsta.face1!,
            lsta.face2!,
            lsta.mob!);
      }
      await Future.delayed(const Duration(milliseconds: 2000));

      emit(LoginRefrashSate());
    });
    on<LogOutEvent>((event, emit) async {
      await authProvider.logout();
      //print("object log out");
      emit(LoginOutSate());
    });
  }
}
