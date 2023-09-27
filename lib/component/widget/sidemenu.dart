
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../settings/config.dart';
import '../settings/responsive.dart';
import 'sidemenu_item.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class SideMenu extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            
            children: [
              Row(
               
                children: [
                  Image.asset(
                    "assets/images/Logo Outlook.png",
                    width: 32,
                  ),
                  const Spacer(),
                  // We don't want to show this close button on Desktop mood
                  //if (!Responsive.isDesktop(context)) 
                  const CloseButton(),
                ],
              ),
             // const SizedBox(height: kDefaultPadding),
              // ElevatedButton.icon(onPressed: (){}, icon: WebsafeSvg.asset("assets/Icons/Edit.svg", width: 16), 
              // label: const Text("Aloke")),
              // .addNeumorphism(
              //    topShadowColor: Colors.white,
                
              //    bottomShadowColor: Color(0xFF234395).withOpacity(0.2),
              //  ),
              
              // FlatButton.icon(
              //   minWidth: double.infinity,
              //   padding: EdgeInsets.symmetric(
              //     vertical: kDefaultPadding,
              //   ),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   color: kPrimaryColor,
              //   onPressed: () {},
              //   icon: WebsafeSvg.asset("assets/Icons/Edit.svg", width: 16),
              //   label: Text(
              //     "New message",
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ).addNeumorphism(
              //   topShadowColor: Colors.white,
              //   bottomShadowColor: Color(0xFF234395).withOpacity(0.2),
              // ),
            //  SizedBox(height: kDefaultPadding),
           
           
              // FlatButton.icon(
              //   minWidth: double.infinity,
              //   padding: EdgeInsets.symmetric(
              //     vertical: kDefaultPadding,
              //   ),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   color: kBgDarkColor,
              //   onPressed: () {},
              //   icon: WebsafeSvg.asset("assets/Icons/Download.svg", width: 16),
              //   label: Text(
              //     "Get messages",
              //     style: TextStyle(color: kTextColor),
              //   ),
              // ).addNeumorphism(),
            //  SizedBox(height: kDefaultPadding * 2),
              // Menu Items
              const SizedBox(height: 25,),
              SideMenuItem(
                press: () {},
                title: "Inbox",
                iconSrc: "assets/Icons/Inbox.svg",
                isActive: true,isHover: true,   showBorder: true,
                itemCount: 3,
              ),
              SideMenuItem(
                press: () {},
                title: "Sent",
                iconSrc: "assets/Icons/Send.svg",
                isActive: true,isHover: true, itemCount: 3, showBorder: true,
              ),
              SideMenuItem(
                press: () {},
                title: "Drafts",
                iconSrc: "assets/Icons/File.svg",
                isActive: true, isHover: true, itemCount: 0, showBorder: true,
              ),
              SideMenuItem(
                press: () {},
                title: "Deleted",
                iconSrc: "assets/Icons/Trash.svg",
                isActive: true,
                showBorder: false,isHover: true, itemCount: 0, 
              ),

              SizedBox(height: kDefaultPadding * 2),
              // Tags
             // Tags(),
            ],
          ),
        ),
      ),
    );
  }
}
