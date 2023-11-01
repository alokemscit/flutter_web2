import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/model/user_model.dart';
import 'package:web_2/pages/home_page/home_page.dart';
import '../settings/config.dart';
import 'sidemenu_item.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  isExists(List<ItemModel> list, String id) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: kIsWeb ? 8 : 0),
      decoration: const BoxDecoration(
          color: kBgLightColor,
          border: Border(right: BorderSide(color: Colors.black12, width: 0.5))),
      child: SafeArea(

        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              

FutureBuilder<User_Model>(
  future: getUserInfo(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        // Attempt to decode the base64 image
        try {
          final MemoryImage backgroundImage =
              MemoryImage(base64.decode(snapshot.data!.iMAGE!));
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  radius: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(0.1),
                    child: CircleAvatar(
                      radius: 220,
                      backgroundImage: backgroundImage,
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 60,
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text(snapshot.data!.eMPNAME!,style:TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                    Text(snapshot.data!.dSGNAME!,style:TextStyle(fontSize: 11,fontWeight: FontWeight.w300),)
                  ],
                             ),
               )
            ],
          );
        } catch (e) {
          // Handle the error by displaying a placeholder or an error message
          return CircleAvatar(
            radius: 220,
            backgroundColor: Colors.red.withOpacity(0.05),
          );
        }
      } else {
        return SizedBox(); // Handle the case when the image couldn't be loaded
      }
    } else {
      return const CircularProgressIndicator(); // Display a loading indicator while fetching the image
    }
  },
),

Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1,
        color: Colors.black12,
      ),
    )
  ],
),


              const SizedBox(
                height: 15,
              ),

              BlocBuilder<MenuItemBloc, ItemMenuState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SideMenuItem(
                        press: () {
                          final itemList = state.menuitem;
                          if (!isExists(itemList, "1")) {
                            final Item = ItemModel(id: "1", name: "Inbox");
                            context
                                .read<MenuItemBloc>()
                                .add(ItemMenuAdd(menuitem: Item));
                          }
                          context
                              .read<CurrentIDBloc>()
                              .add(SetCurrentId(id: "1"));
                        },
                        title: "Inbox",
                        iconSrc: "assets/Icons/Inbox.svg",
                        isActive: true,
                        isHover: true,
                        showBorder: true,
                        itemCount: 3,
                      ),
                      SideMenuItem(
                        press: () {
                          final itemList = state.menuitem;
                          if (!isExists(itemList, "2")) {
                            final Item = ItemModel(id: "2", name: "Sent");
                            context
                                .read<MenuItemBloc>()
                                .add(ItemMenuAdd(menuitem: Item));
                          }
                          context
                              .read<CurrentIDBloc>()
                              .add(SetCurrentId(id: "2"));
                        },
                        title: "Sent",
                        iconSrc: "assets/Icons/Send.svg",
                        isActive: true,
                        isHover: true,
                        itemCount: 3,
                        showBorder: true,
                      ),
                      SideMenuItem(
                        press: () {
                          final itemList = state.menuitem;
                          if (!isExists(itemList, "3")) {
                            final Item = ItemModel(id: "3", name: "Drafts");
                            context
                                .read<MenuItemBloc>()
                                .add(ItemMenuAdd(menuitem: Item));
                          }
                          context
                              .read<CurrentIDBloc>()
                              .add(SetCurrentId(id: "3"));
                        },
                        title: "Drafts",
                        iconSrc: "assets/Icons/File.svg",
                        isActive: true,
                        isHover: true,
                        itemCount: 0,
                        showBorder: true,
                      ),
                      SideMenuItem(
                        press: () {
                          final itemList = state.menuitem;
                          if (!isExists(itemList, "4")) {
                            final Item = ItemModel(id: "4", name: "Deleted");
                            context
                                .read<MenuItemBloc>()
                                .add(ItemMenuAdd(menuitem: Item));
                          }
                          context
                              .read<CurrentIDBloc>()
                              .add(SetCurrentId(id: "4"));
                        },
                        title: "Deleted",
                        iconSrc: "assets/Icons/Trash.svg",
                        isActive: true,
                        showBorder: false,
                        isHover: true,
                        itemCount: 0,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: kDefaultPadding * 2),
              // Tags
              // Tags(),
            ],
          ),
        ),
      
      ),
    );
  }
}
