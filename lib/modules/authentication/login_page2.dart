import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/modules/authentication/bloc/login2_bloc.dart';
 
import 'bloc/registration_block.dart';
import 'login2_widget.dart';

class LoginPage2 extends StatelessWidget {
  const LoginPage2({super.key});

  @override
  Widget build(BuildContext context) {
    String? cid;

    return MultiBlocProvider(
      //create: (context) => SubjectBloc(),
      providers: [
          BlocProvider<ComRegBloc>(
              create: (BuildContext context) => ComRegBloc(),
            ),
             BlocProvider<LoginUserBloc>(
              create: (BuildContext context) => LoginUserBloc(),
            ),
            BlocProvider<LoadComBloc>(
              create: (BuildContext context) => LoadComBloc(),
            ),
      ],
      child: Scaffold(
        extendBody: true,
        backgroundColor: kWebBackgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderAppBar("ERP System"),
            Expanded(
              child: Responsive(
                
                mobile: Center(child: rightpart(cid, context)),
        
                tablet: Center(child: rightpart(cid, context)),
                desktop: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    leftPanel(),
                    Expanded(flex: 2, child: rightpart(cid, context))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names



