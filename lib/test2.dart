// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/menubutton.dart';
import 'package:web_2/component/widget/sidemenu.dart';

import 'component/settings/config.dart';

class Test2 extends StatelessWidget {
  //final bool isSelected = true;
//  TextEditingController mycontroller =  TextEditingController();
     TextEditingController controller = TextEditingController();
  // ignore: non_constant_identifier_names
  NextIndex(List<ItemModel> list, int index) {
    if (list.length > 1) {
      ItemModel k = list[list.length - 1 > index ? (index + 1) : (index - 1)];

      return k.id;
    }
    return '';
  }

//  Test2({super.key});
  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MenuItemBloc(),
          ),
          BlocProvider(
            create: (context) => CurrentIDBloc(),
          ),
        ],
        child: Responsive(
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 220),
                //      //  // child:
                child: SideMenu(),
              ),
              Expanded(
                // flex: 10,
                //flex:  _size.width > 1340 ? 11 : 9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 30,
                      child: BlocBuilder<MenuItemBloc, ItemMenuState>(
                        builder: (context, state) {
                          if (state is ItemMenuAdded &&
                              state.menuitem.isNotEmpty) {
                            final itemList = state.menuitem;
                            return BlocBuilder<CurrentIDBloc, CurrentIdState>(
                              builder: (context1, state1) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: itemList.length,
                                    itemBuilder: (context, index) {
                                      final ItemModel menuitem =
                                          itemList[index];
                                      return MenuButton(
                                        isSelected: false,
                                        // state1.id != menuitem.id ? true : false,
                                        isCrossButton: true,
                                        text: menuitem.name,
                                        buttonClick: () {
                                          print('b');
                                          context1.read<CurrentIDBloc>().add(
                                              SetCurrentId(id: menuitem.id));
                                          print(state1.id);
                                          print(menuitem.id);
                                        },
                                        crossButtonClick: () {
                                          context.read<MenuItemBloc>().add(
                                              ItemMenuDelete(
                                                  menuitem: menuitem));
                                          context1.read<CurrentIDBloc>().add(
                                              SetCurrentId(
                                                  id: NextIndex(
                                                      itemList, index)));
                                        },
                                        color: state1.id.trim() !=
                                                menuitem.id.trim()
                                            ? kSecondaryColor
                                            : Color.fromARGB(
                                                255, 255, 255, 255),
                                      );
                                    });
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 30,
                      //width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: BlocBuilder<CurrentIDBloc, CurrentIdState>(
                            builder: (context, state) {
                          var id = state.id;
                          return //TabPageMain(id: state.id);

                              id == '1'
                                  ? Container(
                                      width: double.infinity,
                                      height: 5000,
                                      color: Colors.amber,
                                    )
                                  : id == '2'
                                      ? Container(
                                          width: double.infinity,
                                          height: 5000,
                                          color: Colors.green,
                                        )
                                      : id == '3'
                                          ? Container(
                                              width: double.infinity,
                                              height: 5000,
                                              color: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {},
                                                      child:
                                                          Text("Click Me..")),
                                                   TextField(
                                                   controller: controller,
                                                  )
                                                ],
                                              ),
                                            )
                                          : id == '4'
                                              ? Container(
                                                  width: double.infinity,
                                                  height: 5000,
                                                  color: Colors.amber,
                                                )
                                              : SizedBox();
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabPageMain extends StatelessWidget {
  final String id;
  const TabPageMain({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return id == '1'
        ? Container(
            width: double.infinity,
            height: 5000,
            color: Colors.amber,
          )
        : id == '2'
            ? Container(
                width: double.infinity,
                height: 5000,
                color: Colors.green,
              )
            : id == '3'
                ? Container(
                    width: double.infinity,
                    height: 5000,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(onPressed: () {}, child: Text("Click Me..")),
                        TextField()
                      ],
                    ),
                  )
                : id == '4'
                    ? Container(
                        width: double.infinity,
                        height: 5000,
                        color: Colors.amber,
                      )
                    : SizedBox();
  }
}

class RightPartPanel extends StatelessWidget {
  const RightPartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
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

// class MenubuttonCloseBlocBloc
//     extends Bloc<MenubuttonCloseBlocEvent, MenubuttonCloseBlocState> {
//   MenubuttonCloseBlocBloc() : super(const MenubuttonCloseBlocInitial(false)) {
//     on<MenubuttonCloseBlocEvent>((event, emit) {
//       if (event is IsMenuClose) {
//         emit(MenubuttonCloseBlocInitial(event.IsClose));
//         //  print(event.isHover.toString());
//       }
//     });
//   }
// }

// sealed class MenubuttonCloseBlocState {
//   final bool IsClose;
//   const MenubuttonCloseBlocState(this.IsClose);
// }

// final class MenubuttonCloseBlocInitial extends MenubuttonCloseBlocState {
//   const MenubuttonCloseBlocInitial(super.IsClose);
// }

// sealed class MenubuttonCloseBlocEvent {}

// class IsMenuClose extends MenubuttonCloseBlocEvent {
//   final bool IsClose;
//   IsMenuClose({required this.IsClose});
// }
