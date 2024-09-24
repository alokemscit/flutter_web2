import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_2/component/widget/custom_elevated_button.dart';
import 'package:web_2/modules/home_page/parent_page.dart';

import '../../core/config/const.dart';

import '../../model/model_company.dart';
import '../../model/model_country.dart';
import 'bloc/login2_bloc.dart';
import 'bloc/registration_block.dart';

// ignore: non_constant_identifier_names
Widget HeaderAppBar(String title) => Padding(
      padding: const EdgeInsets.only(left: 36, top: 30),
      child: Row(
        children: [
          const Icon(
            Icons.ac_unit_outlined,
            color: kHeaderolor,
            size: 40,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: customTextStyle.copyWith(color: kHeaderolor, fontSize: 24),
          )
        ],
      ),
    );

Widget leftPanel() => Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.only(left: 36, top: 80, bottom: 80),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.6), // Adjust the color and opacity
            BlendMode.srcATop,
          ),
          child: Center(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                image: DecorationImage(
                  image: AssetImage('assets/images/login_back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );

Widget rightpart(
  String? cid,
  BuildContext context,
) {
  TextEditingController txt_uid = TextEditingController();
  TextEditingController txt_pws = TextEditingController();
  CustomAwesomeDialog dialog = CustomAwesomeDialog(context: context);
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Welcome.......!",
            style:
                customTextStyle.copyWith(color: kWebHeaderColor, fontSize: 24),
          ),
          Text(
            "Use your user id & password to Login!",
            style:
                customTextStyle.copyWith(color: kWebHeaderColor, fontSize: 12),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              decoration: customBoxDecoration.copyWith(
                  color: kBgColorG.withOpacity(0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.italic,
                        color: kWebHeaderColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<LoadComBloc, LoadComState>(
                    builder: (context, state) {
                      return _dropdown(cid);
                    },
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      labelTextColor: Colors.black54,
                      isFilled: true,
                      width: double.infinity,
                      maxlength: 15,
                      caption: "User ID",
                      controller: txt_uid,
                      onChange: (v) {}),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      surfixIconColor: kWebHeaderColor.withOpacity(0.5),
                      maxlength: 15,
                      isFilled: true,
                      isPassword: true,
                      caption: "Password",
                      controller: txt_pws,
                      onChange: (v) {}),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _login(txt_uid, txt_pws, cid, context),
                      const Spacer(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child: BlocListener<ComRegBloc, ComRegState>(
                              listener: (context, state) {
                                if (state is ComRegErrorState) {
                                  dialog
                                    ..dialogType = DialogType.error
                                    ..message = state.message
                                    ..show();
                                  // customAwesamDialodOk(
                                  //     context,
                                  //     DialogType.error,
                                  //     "Error!",
                                  //     state.message,
                                  //     () {});
                                }
                                if (state is ComRegSuccessState) {
                                  dialog
                                    ..dialogType = DialogType.success
                                    ..message = state.message
                                    ..show()
                                    ..onTap = () {
                                      Navigator.of(context).pop();

                                      context.read<LoadComBloc>().add(
                                          LoadComLoadEvent(cid: state.comid));
                                      cid = state.comid;
                                    };
                                }
                              },
                              child: _createAcc(),
                            )),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          // const Spacer(
          //   flex: 2,
          // ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    ),
  );
}

_createAcc() => BlocBuilder<ComRegBloc, ComRegState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Dont have account?",
              overflow: TextOverflow.clip,
              style:
                  customTextStyle.copyWith(fontSize: 12, color: Colors.black54),
            ),
            InkWell(
                onTap: () {
                  _dialogBox(context);
                },
                child: Text(
                  "Create One",
                  overflow: TextOverflow.clip,
                  style: customTextStyle.copyWith(
                      fontSize: 10, color: kWebHeaderColor),
                )),
          ],
        );
      },
    );

_login(TextEditingController txt_uid, TextEditingController txt_pws,
    String? cid, BuildContext cntx) {
  CustomAwesomeDialog dialog = CustomAwesomeDialog(context: cntx);
  return BlocListener<LoginUserBloc, LoginUserState>(
    listener: (context, state) {
      if (state is LoginUserErrorState) {
        dialog
          ..dialogType = DialogType.error
          ..message = state.message
          ..show();
      }
      if (state is LoginUserSuccessState) {
        dialog
          ..dialogType = DialogType.error
          ..message = state.message
          ..show();

        Future.delayed(const Duration(milliseconds: 2000));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ParentPage()),
        );
      }
      if (state is LoginUserGetComIDState) {
        cid = state.cid;
      }
    },
    child: BlocBuilder<LoginUserBloc, LoginUserState>(
      builder: (context, state) {
        if (state is LoginUserLoadingState) {
          return const Center(child: CupertinoActivityIndicator());
        }

        return BlocListener<ComRegBloc, ComRegState>(
          listener: (context, state) {
            if (state is ComRegSuccessState) {
              cid = state.comid;
            }
          },
          child: CustomElevatedButton(
            onTap: () {
              CustomAwesomeDialog dialog =
                  CustomAwesomeDialog(context: context);
              if (cid == null) {
                dialog
                  ..dialogType = DialogType.warning
                  ..message = 'Please select company name'
                  ..show();

                return;
              }
              if (txt_uid.text.length < 4) {
                dialog
                  ..dialogType = DialogType.warning
                  ..message = 'Please enter valid user ID'
                  ..show();

                return;
              }
              if (txt_pws.text.length < 6) {
                dialog
                  ..dialogType = DialogType.warning
                  ..message = 'Please enter valid password'
                  ..show();

                return;
              }
              context.read<LoginUserBloc>().add(LoginUserLoginEvent(
                  uid: txt_uid.text, pws: txt_pws.text, cid: cid!));
            },
            style: customButtonStyle.copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(
                    kWebHeaderColor.withOpacity(0.6))),
            child: Text(
              "Login Now",
              style:
                  customTextStyle.copyWith(fontSize: 12, color: Colors.white),
            ),
          ),
        );
      },
    ),
  );
}

_dialogBox(
  BuildContext context,
) {
  String? code;
  TextEditingController cname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController uid = TextEditingController();
  TextEditingController pws = TextEditingController();
  TextEditingController cpws = TextEditingController();
  TextEditingController mob = TextEditingController();

  return CustomDialog(
      context,
      Padding(
        padding: const EdgeInsets.only(left: 12, top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.computer_rounded,
              color: kWebHeaderColor.withOpacity(0.8),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              "Company Registration",
              style: customTextStyle.copyWith(
                  fontSize: 16, color: kWebHeaderColor),
            ),
          ],
        ),
      ),
      SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: customBoxDecoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      maxlength: 150,
                      isFilled: true,
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      caption: "Company Name",
                      controller: cname,
                      onChange: (onChange) {})
                    ..paddingOnly(bottom: 4),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      maxlength: 150,
                      isFilled: true,
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      caption: "User's Full Name",
                      controller: name,
                      onChange: (onChange) {}),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: get_country(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<ModelCountry>> snapshot) {
                          List<ModelCountry> listD = [];

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          }
                          if (snapshot.hasError) {
                            return const Text(
                              "Network connection error!",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            );
                          }
                          if (snapshot.hasData) {
                            listD = snapshot.data!;
                            // print(listD);
                          }
                          return CustomDropDown(
                              id: code,
                              labeltext: "Code",
                              list: listD
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.id!.toString(),
                                        child: Text(e.code!),
                                      ))
                                  .toList(),
                              onTap: (v) {
                                code = v;
                              },
                              width: 75);
                        },
                      ),
                      Expanded(
                        child: CustomTextBox(
                            maxlength: 15,
                            isFilled: true,
                            labelTextColor: Colors.black54,
                            caption: "Mobile Number",
                            controller: mob,
                            onChange: (onChange) {}),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      maxlength: 11,
                      isFilled: true,
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      caption: "User ID",
                      controller: uid,
                      onChange: (onChange) {}),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      maxlength: 25,
                      isFilled: true,
                      surfixIconColor: kWebHeaderColor.withOpacity(0.5),
                      isPassword: true,
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      caption: "Password",
                      controller: pws,
                      onChange: (onChange) {}),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomTextBox(
                      maxlength: 25,
                      isFilled: true,
                      surfixIconColor: kWebHeaderColor.withOpacity(0.5),
                      isPassword: true,
                      labelTextColor: Colors.black54,
                      width: double.infinity,
                      caption: "Confirm Password",
                      controller: cpws,
                      onChange: (onChange) {}),
                ],
              ),
            ),
          ),
        ),
      ), () {
    CustomAwesomeDialog dialog = CustomAwesomeDialog(context: context);
    showDialog(String text, [DialogType dialogType = DialogType.warning]) {
      dialog
        ..dialogType = dialogType
        ..message = text
        ..show();
    }

    if (cname.text.length < 3) {
      dialog
        ..dialogType = DialogType.warning
        ..message = "Please enter valid company name"
        ..show();
      return;
    }
    if (name.text.isEmpty) {
      showDialog("Please enter your full name");
      return;
    }
    if (code == null) {
      showDialog("Please select country code");

      return;
    }
    if (mob.text.isEmpty) {
      showDialog("Please enter your mobile number");
      return;
    }
    if (uid.text.length < 4) {
      showDialog("New user ID lenth should be atleast 4");

      return;
    }
    if (pws.text.length < 6) {
      showDialog(
          "Please enter new password, Password length should be atleast 6");

      return;
    }
    if (pws.text != cpws.text) {
      showDialog("New password and confirm passord should be same");

      return;
    }
    context.read<ComRegBloc>().add(ComRegSaveEvent(
          name: name.text,
          mob: mob.text,
          uid: uid.text,
          pws: pws.text,
          code: code!,
          cname: cname.text,
        ));
  });
}

Widget _dropdown(String? cid) => FutureBuilder(
      future: get_company(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ModelComapny>> snapshot) {
        List<ModelComapny> list = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (snapshot.hasError) {
          return const Text(
            "Network Error......!",
            style: TextStyle(color: Colors.red, fontSize: 12),
          );
        }
        if (snapshot.hasData) {
          list = snapshot.data!;
        }
        return list.isEmpty
            ? Text(
                'Connectrion Error',
                style: customTextStyle.copyWith(color: Colors.red),
              )
            : CustomDropDown(
                isFilled: true,
                labelTextColor: Colors.black54,
                id: cid,
                labeltext: "Select Your Company",
                list: list
                    .map((e) => DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.name!),
                        ))
                    .toList(),
                onTap: (v) {
                  // print(v);
                  context
                      .read<LoginUserBloc>()
                      .add(LoginUserSetComIDEvent(cid: v!));
                },
                width: double.infinity);
      },
    );

// ignore: non_constant_identifier_names
Future<List<ModelComapny>> get_company() async {
  data_api2 repo = data_api2();
  List<ModelComapny> list = [];
  // String jsonString = jsonEncode([
  //   {"tag": "9"}
  // ]);
  // print(jsonString);
 // String d = base64Encode(utf8.encode(jsonString));
  //print(d);
 // var dec = decription(d);
  //print(dec);
  var x = await repo.createLead([
   {"tag": "9"}
  ]);
  if (checkJson(x)) {
    list = x.map((e) => ModelComapny.fromJson(e)).toList();
  }
  return list;
}

// ignore: non_constant_identifier_names
Future<List<ModelCountry>> get_country() async {
  List<ModelCountry> list = [];
  data_api2 api = data_api2();
  var x = await api.createLead([
    {"tag": "10"}
  ]);
  // print(x);
  list = x.map((e) => ModelCountry.fromJson(e)).toList();
  return list;
}
