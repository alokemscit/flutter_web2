// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/notifers/apptheame_provider.dart';

import 'component/settings/notifers/auth_provider.dart';
import 'pages/authentication/login_page2.dart';
import 'pages/home_page/parent_page.dart';
 



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final userProvider = AuthProvider();
// if (kIsWeb) {
// setPathUrlStrategy();
// }
  //await appTheame.darkTheme;
  await userProvider.loadUser();
  runApp(MyApp(
    userProvider: userProvider,
  ));
}

class MyApp extends StatelessWidget {
  final AuthProvider userProvider; // = AuthProvider();
  final appTheame = AppTheme();
  MyApp({super.key, required this.userProvider});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness: Brightness.dark));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => userProvider,
          ),
          ChangeNotifierProvider<AppTheme>(
            create: (context) => appTheame,
          ),
        ],
        child: Consumer2<AuthProvider, AppTheme>(builder:
            (context, AuthProvider authNotifier, AppTheme appThemes, child) {
          return MaterialApp(
            scrollBehavior: kIsWeb? CustomScrollBehavior():null,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: kWebHeaderColor,
              brightness:
                  appThemes.darkTheme ? Brightness.dark : Brightness.light,


              useMaterial3: true,
 
              //appThemes.darkTheme==true?Brightness.dark:Brightness.light
            ),
            home: userProvider.user != null
                ? const ParentPage()
                // const EmployeeMaster()
                //: Login(),
                : const LoginPage2(),
          );
        }));
  }
}


