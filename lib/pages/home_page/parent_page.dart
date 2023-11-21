import 'package:flutter/material.dart';
import 'parent_page_widget/parent_background_widget.dart';
import 'parent_page_widget/parent_page_top_widget.dart';
import 'parent_page_widget/parent_module_list_holder_widget.dart';
class ParentPage extends StatelessWidget {
  const ParentPage({super.key});
  @override
  Widget build(BuildContext context) {
     
    return const Scaffold(
        body: SafeArea(
     child : Stack(
        children: [
          ParentPageBackground(),
            ParentPageTopWidget(),
            ParentPageModuleHolderWidget(),
            
        ],
      ),
    ));
  }
}



