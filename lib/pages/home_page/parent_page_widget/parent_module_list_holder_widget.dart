
import 'package:flutter/material.dart';
import 'package:web_2/pages/home_page/parent_page_widget/parent_page_module_list_widget.dart';
import '../../../model/main_app_menu.dart';

class ParentPageModuleHolderWidget extends StatelessWidget {
  const ParentPageModuleHolderWidget({
    super.key,
    required this.size,
  });

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: FutureBuilder(
              future: menu_app_list(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ParentMainModuleListWidget(
                      size: size,
                      list: snapshot.data!,
                    );
                  } else {
                    return const SizedBox();
                  }
                } else {
                  return const SizedBox();
                }
              },
            )),
      ),
    );
  }
}
