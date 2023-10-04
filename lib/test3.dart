
import 'package:flutter/material.dart';

class MyExpansionTileList extends StatefulWidget {
  final List<dynamic> elementList;

  MyExpansionTileList({Key? key, required this.elementList}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DrawerState();
}

class _DrawerState extends State<MyExpansionTileList> {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  //final Controller c = Get.find();

  List<Widget> _getChildren(final List<dynamic> elementList) {
    List<Widget> children = [];
    elementList.toList().asMap().forEach((index, element) {
      int selected = 0;
      final subMenuChildren = <Widget>[];
      // try {
      //   for (var i = 0; i < element['children'].length; i++) {
      //     subMenuChildren.add(new ListTile(
      //       leading: Visibility(
      //         child: Icon(
      //           Icons.account_box_rounded,
      //           size: 15,
      //         ),
      //         visible: false,
      //       ),
      //       onTap: () => {
      //         setState(() {
      //         //  log("The item clicked is " + element['children'][i]['state']);

      //           //from the json we got which contains the menu and submenu we will need the "state"
      //           // json item to get the unique identifier so we know what to open

      //           switch (element['children'][i]['state']) {
      //             case '/fund-type':
      //               //setting current index and opening a new screen using page controller with animations
      //               _selectedPageIndex = 1;
      //               WidgetsBinding.instance.addPostFrameCallback((_) {
      //                 if (_pageController.hasClients) {
      //                   _pageController.animateToPage(1, duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
      //                 }
      //               });
      //               c.title.value = "Fund Type";
      //               Navigator.pop(context);


      //               break;
      //             case '/fund-sources':
      //               _selectedPageIndex = 2;
      //               // _pageController.jumpToPage(2);
      //               WidgetsBinding.instance.addPostFrameCallback((_) {
      //                 if (_pageController.hasClients) {
      //                   _pageController.animateToPage(2,
      //                       duration: Duration(milliseconds: 1),
      //                       curve: Curves.easeInOut);
      //                 }
      //               });
      //               c.title.value = "Fund Source";

      //               Navigator.pop(context);

      //               break;
      //           }
      //         })
      //       },
      //       title: Text(
      //         element['children'][i]['title'],
      //         style: TextStyle(fontWeight: FontWeight.w700),
      //       ),
      //     ));
      //   }
        children.add(
          new ExpansionTile(
            key: Key(index.toString()),
            initiallyExpanded: index == selected,
            leading: Icon(
              Icons.audiotrack,
              color: Colors.green,
              size: 30.0,
            ),
            title: Text(
              element['title'],
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: subMenuChildren,
            onExpansionChanged: ((newState) {
              if (newState) {
                Duration(seconds: 20000);
                selected = index;
               // log(' selected ' + index.toString());
              } else {
                selected = -1;
                //log(' selected ' + selected.toString());
              }
            }),
          ),
        );
      }
    );
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: _getChildren(widget.elementList),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}