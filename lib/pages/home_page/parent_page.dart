import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/settings/responsive.dart';
import '../../component/settings/notifers/auth_provider.dart';
import '../admin/module_page/model/module_model.dart';
import '../authentication/login_page.dart';
import 'parent_page_widget/login_user_image_and_details.dart';
 
import 'parent_page_widget/parent_page_module_list_widget.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({super.key});
  
  @override
  Widget build(BuildContext context) {
     Get.reset();
     Get.deleteAll();
    return BlocProvider(
      create: (context) =>
          LoginBloc(Provider.of<AuthProvider>(context, listen: false)),
      child: Scaffold(
          backgroundColor: kWebBackgroundColor,
          body: Stack(
            children: [
              _bodyBackground(),
              _headerPart(),
              _contectPart(),
            ],
          )),
    );
  }
}

_contectPart() =>
     Positioned.fill(top: 90, child: Padding(
        padding:  const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        child: FutureBuilder(
          future: get_module_list(), //menu_app_list(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (!snapshot.hasData) {
              const Text("No Data Found");
            }
            if(snapshot.hasError){
              const Text("Error Found");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ParentMainModuleListWidget(
                  list: snapshot.data!
                      .where((element) => element.pid!.toString() == "0")
                      .toList(),
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        )));




_bodyBackground() => Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 58, 56, 56).withOpacity(0.035),
        image: const DecorationImage(
            image: AssetImage("assets/Backgrounds/Spline.png"),
            fit: BoxFit.cover,
            opacity: 0.051,
            colorFilter: ColorFilter.srgbToLinearGamma()),
      ),
    );

_headerPart() => Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
      child: Responsive(
        desktop: _desktop(),
        tablet: _desktop(),
        mobile: _mobile(),
      ),
    );

_desktop() => Row(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Text(
              "ERP System",
              style: GoogleFonts.carlito(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const LoginUsersImageAndDetails(),
      ],
    );

_mobile() => const Row(
      // mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LoginUsersImageAndDetails(),
      ],
    );
