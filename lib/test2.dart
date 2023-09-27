// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/menubutton.dart';
import 'package:web_2/component/widget/sidemenu.dart';

import 'component/settings/config.dart';
import 'component/widget/iconbutton.dart';
import 'component/widget/sidemenu_item.dart';

class Test2 extends StatelessWidget {
  
  const Test2({super.key});
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,

       


      body: Responsive(
        mobile: Container(
          color: const Color.fromARGB(255, 235, 233, 230),
        ),
        tablet: Container(
          color: Colors.blueGrey,
        ),
        desktop: Row(
          mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Once our width is less then 1300 then it start showing errors
            // Now there is no error if our width is less then 1340
            //Expanded(
             // flex: _size.width > 1340 ? 2 : 3,
             

     ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: SideMenu(),

// ListView(
//     children:  <Widget>[
//       ExpansionTile(
//         title: Text("Expansion Title"),
//         children: <Widget>[
//           SideMenuItem(
//                 press: () {},
//                 title: "Inbox",
//                 iconSrc: "assets/Icons/Inbox.svg",
//                 isActive: true,isHover: true,   showBorder: true,
//                 itemCount: 3,
//               ),
//           Text("children 2")],
//       )
//     ],
//   ),

      ),



              //  Container(
              //   width: 240,
              //  //  constraints: const BoxConstraints(maxWidth: 50),
              //    color: Colors.amber,
              //   ),
           
           
            Expanded(
              //flex:  _size.width > 1340 ? 11 : 9,
              child:     Container(
                width: double.infinity,
                 padding: const EdgeInsets.only(bottom: 4),
                 decoration: const BoxDecoration(
                color: kBgLightColor
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                children: [
                  MenuButton(
                    isSelected: true,
                    isCrossButton: true,
                    text: 'Menubutton',
                    buttonClick: () {
                      print('b');
                    },
                    crossButtonClick: () {
                      print('object');
                    },
                    color: kSecondaryColor,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  MenuButton(
                    isCrossButton: true,
                    text: 'Menubutton',
                    buttonClick: () {
                      print('b');
                    },
                    crossButtonClick: () {
                      print('object');
                    },
                  ),
                  CustomIconButton(
                    icon: Icons.menu,
                    text: 'Click',
                    buttonClick: () {},
                  )
                ],
                          ),
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
