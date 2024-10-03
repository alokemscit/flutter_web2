// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';
 
 
 
import 'package:web_2/core/config/const.dart';
import 'package:web_2/core/config/notifers/apptheame_provider.dart';
 
 

import 'core/config/notifers/auth_provider.dart';
 
import 'modules/authentication/login_page2.dart';
import 'modules/home_page/parent_page.dart';
 



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
          return GetMaterialApp(

  //  localizationsDelegates: const [
  //       GlobalMaterialLocalizations.delegate,
  //       GlobalWidgetsLocalizations.delegate,
  //     ],
  //     supportedLocales: const [
  //       Locale('en', 'GB'), // Define the supported locale
  //     ],

        scrollBehavior: kIsWeb? CustomScrollBehavior():null,
        debugShowCheckedModeBanner: false,
       // title: appName,
         supportedLocales: const [
        Locale('en', 'GB'), // Define the supported locale
      ],

            
       
        title: appName,
        theme: ThemeData(
          fontFamily: appFontOpenSans,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          scaffoldBackgroundColor: kBgLightColor,
          //colorScheme: ColorScheme.fromSeed(seedColor: appColorPista),
          colorScheme: const ColorScheme.light(primary: kWebHeaderColor),
          buttonTheme:
          const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          primaryColor: kWebHeaderColor,
          useMaterial3: true,
          ),
            home:   //SearchableDropdownTypeAhead(),

            userProvider.user != null
                ?  const Material(child: ParentPage())
                 
                : const LoginPage2(),

          );
        }));
  }
}


