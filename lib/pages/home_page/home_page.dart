// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/menubutton.dart';
import 'package:web_2/component/widget/sidemenu.dart';
 import '../../component/settings/config.dart';
import '../../component/settings/router.dart';
 import '../admin/module_page/model/module_model.dart';
 import 'parent_page_widget/parent_background_widget.dart';

// ignore: must_be_immutable

// ignore: non_constant_identifier_names
NextIndex(List<ItemModel> list, int index) {
  if (list.length > 1) {
    ItemModel k = list[list.length - 1 > index ? (index + 1) : (index - 1)];
    return k.id;
  }
  return '';
}

List<dynamic> textControllerListGenerator(int length) {
  return List.generate(length, (index) => TextEditingController());
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final ModuleMenuList module;
  const HomePage({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          const ParentPageBackground(imageOpacity: 0.03),
          HomePagebodyWidget(module: module),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePagebodyWidget extends StatelessWidget {
  HomePagebodyWidget({
    super.key,
    required this.module,
  });

  final ModuleMenuList module;

  final List<SingleChildWidget> providers = [
    BlocProvider(
      create: (context) => MenuItemBloc(),
    ),
    BlocProvider(
      create: (context) => CurrentIDBloc(),
    ),
    BlocProvider(create: (constext) => MenubuttonCloseBlocBloc()),
  ];

  @override
  Widget build(BuildContext context) {
    var sidemenu = SideMenu(
      module: module,
      userDetailsForDrawer: UserDetailsForDrawer(module: module),
      generateMenuItems: GenerateMenuItems(mid: module.id.toString()),
    );
    return MultiBlocProvider(
      providers: providers,
      child: Responsive(
        mobile: Container(
          color: const Color.fromARGB(255, 235, 233, 230),
        ),
        tablet: DesktopWidget(module: module, sidemenu: sidemenu),
        desktop: DesktopWidget(module: module, sidemenu: sidemenu),
      ),
    );
  }
}

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    super.key,
    required this.module,
    required this.sidemenu,
  });
  final SideMenu sidemenu;
  final ModuleMenuList module;

  @override
  Widget build(BuildContext context) {
    print('Secon-----------  widget');
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Drawer Menu Item

        // DrawerWithBackArrow(module: module),

        BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
          builder: (context, state) {
            bool b = false;
            if (state is MenubuttonCloseBlocInitial) {
              b = state.isClose;
            }

            double ss = b == true ? 0 : 220;
            //print(ss);
            return AnimatedSize(
              curve: Curves.easeIn,
              //  vsync: this,
              duration: const Duration(milliseconds: 200),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: ss),
                //      //  // child:
                child: Stack(
                  children: [
                    sidemenu,
                    const ArrowBackPositioned(),
                  ],
                ),
              ),
            );
          },
        ),

        TabAndBodyWidget(
          module: module,
        ),
      ],
    );
  }
}

class TabAndBodyWidget extends StatelessWidget {
  const TabAndBodyWidget({
    super.key,
    required this.module,
  });
  final ModuleMenuList module;
  @override
  Widget build(BuildContext context) {
    //print('Render Main Body ..........main00000000');
    // Size size = MediaQuery.of(context).size;
    return Expanded(
      // flex: 10,
      //flex:  _size.width > 1340 ? 11 : 9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const DrawerBackIconWithTabEvent(),
          Expanded(
            child: BlocBuilder<CurrentIDBloc, CurrentIdState>(
                builder: (context, state) {
              var id = state.id;
              print(id);
            return  getPage(module, id);
              //   return //TabPageMain(id: state.id);
              //  print('Render Main Body ..........111');
              // return (() {
              //   switch (id) {
              //     case "28":
              //       {
              //         return const TimeSlotPage();
              //       }
              //     case "30":
              //       {
              //         return const DoctorAppointment();
              //       }
              //     case "31":
              //       {
              //         return const DoctorLeave();
              //       }

              //     case "4":
              //       {
              //         return const Text("4");
              //       }
              //     case "24":
              //       {
              //         return const ModulePage();
              //       }
              //     case "25":
              //       {
              //         return const FormPage();
              //       }

              //     default:
              //       return SizedBox();
              //   }
              // })();
            }),
          )
        ],
      ),
    );
  }
}

class DrawerBackIconWithTabEvent extends StatelessWidget {
  const DrawerBackIconWithTabEvent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgLightColor,
      width: double.infinity,
      height: 28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrawerMenueIcon(),
          SizedBox(
            width: MediaQuery.of(context).size.width - 252,
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TabMenuWithEvent(),
            ),
          ),
        ],
      ),
    );
  }
}

class TabMenuWithEvent extends StatelessWidget {
  const TabMenuWithEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuItemBloc, ItemMenuState>(
      builder: (context, state) {
        if (state is ItemMenuAdded && state.menuitem.isNotEmpty) {
          final itemList = state.menuitem;
          return BlocBuilder<CurrentIDBloc, CurrentIdState>(
            builder: (context1, state1) {
              return ListView.builder(
                  padding: const EdgeInsets.only(left: 4),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    final ItemModel menuitem = itemList[index];
                    return MenuButton(
                      isSelected: false,
                      // state1.id != menuitem.id ? true : false,
                      isCrossButton: true,
                      text: menuitem.name,
                      buttonClick: () {
                        //  print('b');
                        context1
                            .read<CurrentIDBloc>()
                            .add(SetCurrentId(id: menuitem.id));
                        //  print(state1.id);
                        //print(menuitem.id);
                      },
                      crossButtonClick: () {
                        context
                            .read<MenuItemBloc>()
                            .add(ItemMenuDelete(menuitem: menuitem));
                        context1
                            .read<CurrentIDBloc>()
                            .add(SetCurrentId(id: NextIndex(itemList, index)));
                      },
                      color: state1.id.trim() != menuitem.id.trim()
                          ? kSecondaryColor
                          : const Color.fromARGB(255, 255, 255, 255),
                      textColor: state1.id.trim() != menuitem.id.trim()
                          ? Colors.black.withOpacity(0.8)
                          : const Color.fromARGB(255, 1, 114, 108),
                    );
                  });
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class DrawerMenueIcon extends StatelessWidget {
  const DrawerMenueIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
      builder: (context, state) {
        return state.isClose
            ? InkWell(
                onTap: () {
                  context
                      .read<MenubuttonCloseBlocBloc>()
                      .add(IsMenuClose(isClose: !state.isClose));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: Icon(
                    Icons.menu_sharp,
                    size: 22,
                  ),
                ),
              )
            : const SizedBox();
      },
    );
  }
}

class ArrowBackPositioned extends StatelessWidget {
  const ArrowBackPositioned({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final MenuCloseController yourController = Get.put(MenuCloseController());
    return Positioned(
        top: 0,
        right: 1,
        child: BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
          builder: (context, state) {
            return InkWell(
              onTap: () {
                context
                    .read<MenubuttonCloseBlocBloc>()
                    .add(IsMenuClose(isClose: !state.isClose));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ));
  }
}

class ItemModel {
  final String id;
  final String name;
  ItemModel({required this.id, required this.name});
}

abstract class ItemMenuState {
  final List<ItemModel> menuitem;
  ItemMenuState({required this.menuitem});
}

class ItemMenuInit extends ItemMenuState {
  ItemMenuInit({required List<ItemModel> menuitem}) : super(menuitem: menuitem);
}

class ItemMenuAdded extends ItemMenuState {
  ItemMenuAdded({required List<ItemModel> menuitem})
      : super(menuitem: menuitem);
}

abstract class ItemMenuEvent {}

class ItemMenuAdd extends ItemMenuEvent {
  final ItemModel menuitem;
  ItemMenuAdd({required this.menuitem});
}

class ItemMenuDelete extends ItemMenuEvent {
  final ItemModel menuitem;
  ItemMenuDelete({required this.menuitem});
}

class MenuItemBloc extends Bloc<ItemMenuEvent, ItemMenuState> {
  MenuItemBloc() : super(ItemMenuInit(menuitem: [])) {
    on<ItemMenuAdd>(_addItem);
    on<ItemMenuDelete>(_deleteItem);
  }

  FutureOr<void> _addItem(ItemMenuAdd event, Emitter<ItemMenuState> emit) {
    state.menuitem.add(event.menuitem);
    // List<ItemModel> lst = [];
    //lst.add(event.menuitem);

    emit(ItemMenuAdded(menuitem: state.menuitem));
  }

  FutureOr<void> _deleteItem(
      ItemMenuDelete event, Emitter<ItemMenuState> emit) {
    state.menuitem.remove(event.menuitem);
    emit(ItemMenuAdded(menuitem: state.menuitem));
  }
}

abstract class CurrentIdState {
  final String id;
  CurrentIdState({required this.id});
}

class CurrentIDInit extends CurrentIdState {
  CurrentIDInit({required super.id});
}

class CurrentIDSet extends CurrentIdState {
  CurrentIDSet({required super.id});
}

abstract class CurrenIdEvent {
  final String id;

  CurrenIdEvent({required this.id});
}

class SetCurrentId extends CurrenIdEvent {
  SetCurrentId({required super.id});
}

class CurrentIDBloc extends Bloc<CurrenIdEvent, CurrentIdState> {
  CurrentIDBloc() : super(CurrentIDInit(id: "")) {
    on<CurrenIdEvent>((event, emit) {
      if (event is SetCurrentId) {
        emit(CurrentIDSet(id: event.id));
      }
    });
  }
}

class MenubuttonCloseBlocBloc
    extends Bloc<MenubuttonCloseBlocEvent, MenubuttonCloseBlocState> {
  MenubuttonCloseBlocBloc()
      : super(MenubuttonCloseBlocInitial(isClose: false)) {
    on<MenubuttonCloseBlocEvent>((event, emit) {
      if (event is IsMenuClose) {
        emit(MenubuttonCloseBlocInitial(isClose: event.isClose));
        //  print(event.isHover.toString());
      }
    });
  }
}

sealed class MenubuttonCloseBlocState {
  final bool isClose;

  // ignore: non_constant_identifier_names
  MenubuttonCloseBlocState({required this.isClose});
}

final class MenubuttonCloseBlocInitial extends MenubuttonCloseBlocState {
  MenubuttonCloseBlocInitial({required super.isClose});
}

sealed class MenubuttonCloseBlocEvent {}

class IsMenuClose extends MenubuttonCloseBlocEvent {
  final bool isClose;
  IsMenuClose({required this.isClose});
}
