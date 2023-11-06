import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web_2/component/widget/custom_avater.dart';
import 'package:web_2/model/main_app_menu.dart';
import 'package:web_2/model/menu_data_model.dart';
import 'package:web_2/model/user_model.dart';
import 'package:web_2/pages/authentication/login_page.dart';
import 'package:web_2/pages/home_page/home_page.dart';

import '../settings/config.dart';
import '../settings/notifers/auth_provider.dart';

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
      height: MediaQuery.of(context).size.height,
      //padding: const EdgeInsets.only(top: kIsWeb ? 8 : 0),
      decoration: const BoxDecoration(
          color: kBgLightColor,
          border: Border(right: BorderSide(color: Colors.black12, width: 0.5))),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: kIsWeb ? 18 : 0, left: 6, right: 4),
                child: UserDetailsForDrawer(module: module),
              ),
              HomeLogOut(module: module),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                child: ModuleNameDisplay(module: module),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: GenerateMenuItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenerateMenuItems extends StatelessWidget {
  const GenerateMenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: get_menu_data_list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<MenuData> list = snapshot.data!;
              return BlocBuilder<MenuItemBloc, ItemMenuState>(
                builder: (context, state) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(list.length, (index) {
                        return ExpansionTile(
                            title: Container(
                                // padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      const Color.fromARGB(255, 197, 197, 197)
                                          .withOpacity(0.09),
                                ),
                                child: Text(
                                  list[index].name!,
                                  style: GoogleFonts.titilliumWeb(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                            tilePadding: EdgeInsets.zero,

                            //  leading: const Icon(Icons.insert_emoticon),
                            // childrenPadding: EdgeInsets.only(left: 4),
                            children: list[index].smenu!.map((e) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                horizontalTitleGap: 0,
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    e.smName!,
                                    style: GoogleFonts.titilliumWeb(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                onTap: () {
                                  final itemList = state.menuitem;
                                  if (!isExists(itemList, e.smId.toString())) {
                                    // ignore: non_constant_identifier_names
                                    final Item = ItemModel(
                                        id: e.smId.toString(),
                                        name: e.smName.toString());
                                    context
                                        .read<MenuItemBloc>()
                                        .add(ItemMenuAdd(menuitem: Item));
                                  }
                                  context
                                      .read<CurrentIDBloc>()
                                      .add(SetCurrentId(id: e.smId.toString()));
                                },
                              );
                            }).toList());
                      }));
                },
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const CircularProgressIndicator(); // Display a loading indicator while fetching the image
          }
        });
  }
}

class ModuleNameDisplay extends StatelessWidget {
  const ModuleNameDisplay({
    super.key,
    required this.module,
  });

  final main_app_menu module;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 0.5,
                //color: Colors.black12.withOpacity(0.1),
              ),
            )
          ],
        ),
        Text(
          module.name!,
          style: GoogleFonts.bungeeInline(
              fontSize: 14,
              fontWeight: FontWeight.w100,
              fontStyle: FontStyle.italic,
              color: const Color.fromARGB(255, 15, 20, 22).withOpacity(0.5)),
        ),
        // const SizedBox(
        //   height: 15,
        // ),
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
      ],
    );
  }
}

class UserDetailsForDrawer extends StatelessWidget {
  const UserDetailsForDrawer({
    super.key,
    required this.module,
  });

  final main_app_menu module;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User_Model>(
      future: getUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            // Attempt to decode the base64 image
            try {
              final MemoryImage backgroundImage =
                  MemoryImage(base64.decode(snapshot.data!.iMAGE!));
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAvater(size: 55, backgroundImage: backgroundImage),
                      const SizedBox(
                        width: 4,
                      ),
                      HomeLoginUserDetails(
                        snapshot: snapshot,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          height: 1,
                          color: Colors.black12.withOpacity(0.1),
                        ),
                      )
                    ],
                  ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140, maxHeight: 30),
            child: Text(
              snapshot.data!.eMPNAME!,
              style: GoogleFonts.headlandOne(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140, maxHeight: 10),
            child: Text(
              snapshot.data!.dSGNAME!,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w200),
            ),
          ),
          //SizedBox(height: 2,)
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
          return SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LogOutEvent());

                      Navigator.pop(context, HomePage(module: module));
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.w600),
                    )),
                TextButton(
                    //style: ButtonStyle(textStyle: TextStyle()) ),
                    onPressed: () {
                      //  context.read<LoginBloc>().add(LogOutEvent());

                      Navigator.pop(context, HomePage(module: module));
                    },
                    child: const Text(
                      '< Back To Main',
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(255, 1, 10, 65),
                          fontWeight: FontWeight.normal),
                    )),
              ],
            ),
          );
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
        return FutureBuilder(
            future: get_menu_data_list(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<MenuData> list = snapshot.data!;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Text(list[index].name!);
                    },
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const CircularProgressIndicator(); // Display a loading indicator while fetching the image
              }
            });

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     SideMenuItem(
        //       press: () {
        //         final itemList = state.menuitem;
        //         if (!isExists(itemList, "1")) {
        //           // ignore: non_constant_identifier_names
        //           final Item = ItemModel(id: "1", name: "Inbox");
        //           context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
        //         }
        //         context.read<CurrentIDBloc>().add(SetCurrentId(id: "1"));
        //       },
        //       title: "Inbox",
        //       iconSrc: "assets/Icons/Inbox.svg",
        //       isActive: true,
        //       isHover: true,
        //       showBorder: true,
        //       itemCount: 3,
        //     ),
        //     SideMenuItem(
        //       press: () {
        //         final itemList = state.menuitem;
        //         if (!isExists(itemList, "2")) {
        //           final Item = ItemModel(id: "2", name: "Sent");
        //           context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
        //         }
        //         context.read<CurrentIDBloc>().add(SetCurrentId(id: "2"));
        //       },
        //       title: "Sent",
        //       iconSrc: "assets/Icons/Send.svg",
        //       isActive: true,
        //       isHover: true,
        //       itemCount: 3,
        //       showBorder: true,
        //     ),
        //     SideMenuItem(
        //       press: () {
        //         final itemList = state.menuitem;
        //         if (!isExists(itemList, "3")) {
        //           final Item =
        //               ItemModel(id: "3", name: "Doctors Duty tme Slot");
        //           context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
        //         }
        //         context.read<CurrentIDBloc>().add(SetCurrentId(id: "3"));
        //       },
        //       title: "Doctors Duty tme Slot",
        //       iconSrc: "assets/Icons/File.svg",
        //       isActive: true,
        //       isHover: true,
        //       itemCount: 0,
        //       showBorder: true,
        //     ),
        //     SideMenuItem(
        //       press: () {
        //         final itemList = state.menuitem;
        //         if (!isExists(itemList, "4")) {
        //           final Item = ItemModel(id: "4", name: "Deleted");
        //           context.read<MenuItemBloc>().add(ItemMenuAdd(menuitem: Item));
        //         }
        //         context.read<CurrentIDBloc>().add(SetCurrentId(id: "4"));
        //       },
        //       title: "Deleted",
        //       iconSrc: "assets/Icons/Trash.svg",
        //       isActive: true,
        //       showBorder: false,
        //       isHover: true,
        //       itemCount: 0,
        //     ),
        //     SideMenuItem(
        //       press: () {
        //         Navigator.pop(context, HomePage(module: module));
        //       },
        //       title: "Close module",
        //       iconSrc: "assets/Icons/Trash.svg",
        //       isActive: true,
        //       showBorder: false,
        //       isHover: true,
        //       itemCount: 0,
        //     ),
        //   ],
        // );
      },
    );
  }
}
