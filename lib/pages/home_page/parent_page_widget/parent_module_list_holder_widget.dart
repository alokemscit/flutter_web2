import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_2/pages/home_page/parent_page_widget/parent_page_module_list_widget.dart';

import '../../admin/module_page/model/module_model.dart';

class ParentPageModuleHolderWidget extends StatelessWidget {
  const ParentPageModuleHolderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size.width.toString());
    return Positioned(
      top: 80,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 80,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: FutureBuilder(
              future: get_module_list(), //menu_app_list(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ParentMainModuleListWidget(
                      list: snapshot.data!
                          .where((element) => element.pid!.toString() == "0")
                          .toList(),
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
