import 'package:flutter/material.dart';
import 'parent_page_widget/parent_background_widget.dart';
import 'parent_page_widget/parent_page_top_widget.dart';
import 'parent_page_widget/parent_module_list_holder_widget.dart';
class ParentPage extends StatelessWidget {
  const ParentPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
  //  print('Size ' + size.width.toString());
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          const ParentPageBackground(),
            ParentPageTopWidget(size: size),
            ParentPageModuleHolderWidget(size: size)
        ],
      ),
    ));
  }
}



