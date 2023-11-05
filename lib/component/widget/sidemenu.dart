import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_2/component/widget/custom_avater.dart';
import 'package:web_2/model/main_app_menu.dart';
import 'package:web_2/model/user_model.dart';
import 'package:web_2/pages/authentication/login_page.dart';
import 'package:web_2/pages/home_page/home_page.dart';

import '../settings/config.dart';
import '../settings/notifers/auth_provider.dart';
import 'sidemenu_item.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

isExists(List<ItemModel> list, String id) {
  for (int i = 0; i < list.length; i++) {
    if (list[i].id == id) {
      return true;
    }
  }
  return false;
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.module});
  final main_app_menu module;

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
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text(module.name!),
              FutureBuilder<User_Model>(
                future: getUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      // Attempt to decode the base64 image
                      try {
                        final MemoryImage backgroundImage = MemoryImage(base64.decode(snapshot.data!.iMAGE!));
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAvater(
                                    size: 60, backgroundImage: backgroundImage),
                                HomeLogOut(module: module)
                              ],
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                             HomeLoginUserDetails(
                              snapshot: snapshot,
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
                      return const SizedBox(); // Handle the case when the image couldn't be loaded
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
                      color: Colors.black12.withOpacity(0.1),
                    ),
                  )
                ],
              ),


             Text(
                    module.name!,
                      style: GoogleFonts.bungeeInline(fontSize: 14, fontWeight: FontWeight.w100, fontStyle: FontStyle.italic, color: Color.fromARGB(255, 0, 97, 136).withOpacity(0.5)),
                    ),
              const SizedBox(
                height: 15,
              ),
          Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 1,
                      color: Colors.black12.withOpacity(0.1),
                    ),
                  )
                ],
              ),

      DrawerMenuItemList(module: module),

              




           //   const SizedBox(height: kDefaultPadding * 2),
              // Tags
              // Tags(),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeLoginUserDetails extends StatelessWidget {
  const HomeLoginUserDetails({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot<User_Model> snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140, maxHeight: 30),
            child: Text(
              snapshot.data!.eMPNAME!,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140, maxHeight: 10),
            child: Text(
              snapshot.data!.dSGNAME!,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }
}

class HomeLogOut extends StatelessWidget {
  const HomeLogOut({
    super.key,
    required this.module,
  });

  final main_app_menu module;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(Provider.of<AuthProvider>(context, listen: false)),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextButton(
              onPressed: () {
                context.read<LoginBloc>().add(LogOutEvent());

                Navigator.pop(context, HomePage(module: module));
              },
              child: const Text(
                'Log out',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ));
        },
      ),
    );
  }
}

class DrawerMenuItemList extends StatelessWidget {
  const DrawerMenuItemList({super.key, required this.module});
  final main_app_menu module;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemBloc, ItemMenuState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenuItem(
              press: () {
                final itemList = state.menuitem;
                if (!isExists(itemList, "1")) {
                  // ignore: non_constant_identifier_names
                  final Item = ItemModel(id: "1", name: "Inbox");
                  context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
                }
                context.read<CurrentIDBloc>().add(SetCurrentId(id: "1"));
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
                  context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
                }
                context.read<CurrentIDBloc>().add(SetCurrentId(id: "2"));
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
                  final Item = ItemModel(id: "3", name: "Doctors Duty tme Slot");
                  context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
                }
                context.read<CurrentIDBloc>().add(SetCurrentId(id: "3"));
              },
              title: "Doctors Duty tme Slot",
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
                  context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
                }
                context.read<CurrentIDBloc>().add(SetCurrentId(id: "4"));
              },
              title: "Deleted",
              iconSrc: "assets/Icons/Trash.svg",
              isActive: true,
              showBorder: false,
              isHover: true,
              itemCount: 0,
            ),
            SideMenuItem(
              press: () {
                Navigator.pop(context, HomePage(module: module));
              },
              title: "Close module",
              iconSrc: "assets/Icons/Trash.svg",
              isActive: true,
              showBorder: false,
              isHover: true,
              itemCount: 0,
            ),
          ],
        );
      },
    );
  }
}
