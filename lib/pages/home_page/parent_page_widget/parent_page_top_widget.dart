import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_user_image_and_details.dart';

class ParentPageTopWidget extends StatelessWidget {
  const ParentPageTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      left: 0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width < 380 ? 4 : 24),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "ERP System",
                style: GoogleFonts.carlito(
                    fontSize: size.width < 400 ? 30 : 34,
                    fontWeight: FontWeight.bold),
              ),
              const LoginUsersImageAndDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
