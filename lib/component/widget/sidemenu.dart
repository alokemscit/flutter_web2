import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/test2.dart';
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
      padding: const EdgeInsets.only(top: kIsWeb ? kDefaultPadding : 0),
      color: kBgLightColor,
      child: SafeArea(
        child: BlocBuilder<MenuItemBloc, ItemMenuState>(
          builder: (context, state) {
            return BlocBuilder<CurrentIDBloc, CurrentIdState>(
              builder: (context1, state1) {
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                          //   const CloseButton(
                          //  ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),
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
                          context1
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
                           context1
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
                           context1
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

                      SizedBox(height: kDefaultPadding * 2),
                      // Tags
                      // Tags(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
