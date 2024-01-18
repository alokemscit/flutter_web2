import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_2/component/settings/responsive.dart';
import '../../component/settings/notifers/auth_provider.dart';
import '../authentication/login_page.dart';
import 'parent_page_widget/login_user_image_and_details.dart';

import 'parent_page_widget/parent_module_list_holder_widget.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(Provider.of<AuthProvider>(context, listen: false)),
      child: Scaffold(
          body: Stack(
        children: [
           _bodyBackground(),
            _headerPart(),
          
        const Positioned.fill(
          top: 80,
          child: ParentPageModuleHolderWidget())
         
        ],
      )),
    );
  }
}

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
        desktop: _desktop(), tablet: _desktop(), mobile: _mobile(),
      ),
    );

  _desktop()=> Row(
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

        _mobile()=> const Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            LoginUsersImageAndDetails(),
          ],
        );