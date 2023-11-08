// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/notifers/apptheame_provider.dart';

import 'component/settings/notifers/auth_provider.dart';
import 'pages/authentication/login_page.dart';

import 'pages/home_page/parent_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userProvider = AuthProvider();
  
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => userProvider,
          ),
          ChangeNotifierProvider<AppTheme>(
            create: (context) => appTheame,
          ),
        ],
        child: Consumer2<AuthProvider,AppTheme>(
            builder: (context, AuthProvider authNotifier,AppTheme appThemes, child) {
          return MaterialApp(
            scrollBehavior: CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            theme:ThemeData( 
              brightness: appThemes.darkTheme?Brightness.dark:Brightness.light,
               //appThemes.darkTheme==true?Brightness.dark:Brightness.light
               ),
            home: userProvider.user != null ? const ParentPage() : Login(),
          );
        }));
  }
}



// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final prefs = await SharedPreferences.getInstance();
//   final String? eMPID = prefs.getString('eMPID');

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => AuthProvider()),
//       ],
//       child: MyApp(eMPID: eMPID),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key, required this.eMPID});
//   final String? eMPID;

//   @override
//   Widget build(BuildContext context) {
//     //print(eMPID);
//     return MaterialApp(
//         scrollBehavior: CustomScrollBehavior(),
//         debugShowCheckedModeBanner: false,
//         home: eMPID==null?Login():Test5(),
//         //const Test5(), //
//         // Test2(),
//         //const DoctorAppointment(),
//         );
//   }
// }
