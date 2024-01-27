// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/menubutton.dart';
import 'package:web_2/component/widget/sidemenu.dart';

import 'component/settings/config.dart';
import 'component/widget/vitalsign.dart';

// ignore: must_be_immutable
class Test2 extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  Test2({super.key});
  // ignore: non_constant_identifier_names
  NextIndex(List<ItemModel> list, int index) {
    if (list.length > 1) {
      ItemModel k = list[list.length - 1 > index ? (index + 1) : (index - 1)];
      return k.id;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MenuItemBloc(),
          ),
          BlocProvider(
            create: (context) => CurrentIDBloc(),
          ),
          BlocProvider(create: (constext) => MenubuttonCloseBlocBloc()),
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
              BlocBuilder<MenubuttonCloseBlocBloc, MenubuttonCloseBlocState>(
                builder: (context, state) {
                  bool b = state.IsClose;
                  double ss = b == true ? 0 : 220;
                  //print(ss);
                  return AnimatedSize(
                    curve: Curves.easeIn,
                    //  vsync: this,
                    duration: const Duration(milliseconds: 300),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: ss),
                      //      //  // child:
                      child: Stack(
                        children: [
                          //const SideMenu(),
                          Positioned(
                            top: 0,
                            right: 1,
                            child: IconButton(
                              splashRadius: 20,
                              iconSize: 20,
                              onPressed: () {
                                context
                                    .read<MenubuttonCloseBlocBloc>()
                                    .add(IsMenuClose(IsClose: !state.IsClose));
                              },
                              icon: const Icon(
                                Icons.arrow_back_sharp,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
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
                      height: 28,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<MenubuttonCloseBlocBloc,
                              MenubuttonCloseBlocState>(
                            builder: (context, state) {
                              return state.IsClose
                                  ? IconButton(
                                      splashRadius: 20,
                                      iconSize: 20,
                                      onPressed: () {
                                        context
                                            .read<MenubuttonCloseBlocBloc>()
                                            .add(IsMenuClose(
                                                IsClose: !state.IsClose));
                                      },
                                      icon: const Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Icon(
                                          Icons.menu_sharp,
                                          size: 20,
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          ),
                          BlocBuilder<MenuItemBloc, ItemMenuState>(
                            builder: (context, state) {
                              if (state is ItemMenuAdded &&
                                  state.menuitem.isNotEmpty) {
                                final itemList = state.menuitem;
                                return BlocBuilder<CurrentIDBloc,
                                    CurrentIdState>(
                                  builder: (context1, state1) {
                                    return ListView.builder(
                                      padding: const EdgeInsets.only(left: 4),
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
                                              //  print('b');
                                              context1
                                                  .read<CurrentIDBloc>()
                                                  .add(SetCurrentId(
                                                      id: menuitem.id));
                                              //  print(state1.id);
                                              //print(menuitem.id);
                                            },
                                            crossButtonClick: () {
                                              context.read<MenuItemBloc>().add(
                                                  ItemMenuDelete(
                                                      menuitem: menuitem));
                                              context1
                                                  .read<CurrentIDBloc>()
                                                  .add(SetCurrentId(
                                                      id: NextIndex(
                                                          itemList, index)));
                                            },
                                            color: state1.id.trim() !=
                                                    menuitem.id.trim()
                                                ? kSecondaryColor
                                                : const Color.fromARGB(
                                                    255, 255, 255, 255),
                                          );
                                        });
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height - 28,
                        //width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 0),
                           // padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(4)),
                             border:Border.fromBorderSide(BorderSide(color: Colors.grey,width: 0.1),),
                                  
                              // boxShadow: [
                              //   BoxShadow(
                              //     blurRadius: 0.5,
                              //     spreadRadius: 0.1,
                              //     color: Color.fromARGB(255, 225, 226, 226)
                              //   )

                              // ]
                                      ),
                            child: BlocBuilder<CurrentIDBloc, CurrentIdState>(
                                builder: (context, state) {
                              var id = state.id;
                              //   return //TabPageMain(id: state.id);
                                            
                              switch (id) {
                                case "1":
                                  {
                                    return 
                                         Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {},
                                                      child:
                                                          const Text("Click Me..")),
                                                
                                                CapWithTextFields(
                                        caption: 'Heaght(CM)',
                                          controller: controller,
                                          width: 250,
                                        maxlength: 150,
                                           ),
                                                
                                                
                                                  // TextField(
                                                  //   controller: controller,
                                                  // )
                                                ],
                                                                           );
                                  }
                                            
                                case "2":
                                  {
                                    return Text("2");
                                  }
                                            
                                case "3":
                                  {
                                    return Text("3");
                                  }
                                            
                                case "4":
                                  {
                                    return Text("4");
                                  }
                                            
                                default:
                                  return SizedBox();
                              }
                              
                                            
                            }),
                          ),
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

class MenubuttonCloseBlocBloc
    extends Bloc<MenubuttonCloseBlocEvent, MenubuttonCloseBlocState> {
  MenubuttonCloseBlocBloc()
      : super(MenubuttonCloseBlocInitial(IsClose: false)) {
    on<MenubuttonCloseBlocEvent>((event, emit) {
      if (event is IsMenuClose) {
        emit(MenubuttonCloseBlocInitial(IsClose: event.IsClose));
        //  print(event.isHover.toString());
      }
    });
  }
}

sealed class MenubuttonCloseBlocState {
  final bool IsClose;

  MenubuttonCloseBlocState({required this.IsClose});
}

final class MenubuttonCloseBlocInitial extends MenubuttonCloseBlocState {
  MenubuttonCloseBlocInitial({required super.IsClose});
}

sealed class MenubuttonCloseBlocEvent {}

class IsMenuClose extends MenubuttonCloseBlocEvent {
  final bool IsClose;
  IsMenuClose({required this.IsClose});
}
