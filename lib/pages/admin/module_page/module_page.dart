import 'package:flutter/material.dart';

import 'widget/module_page_widget.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController txtModule = TextEditingController();
    TextEditingController txtSearch = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    String? iid = null;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: leftPanel(iid, txtModule, txtDesc),
          ),
         
          Expanded(
              flex: 6,
              child: rightPanel(txtSearch),),
        ],
      ),
    );
  }
}
