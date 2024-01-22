import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/module_bloc.dart';
import 'widget/module_page_widget.dart';

class ModulePage extends StatelessWidget {
  const ModulePage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController txtModule = TextEditingController();
    TextEditingController txtSearch = TextEditingController();
    TextEditingController txtDesc = TextEditingController();
    String? iid;
    print("Modle page");
    return MultiBlocProvider(
      // create: (context) => ModuleBloc(),
      providers: [
        BlocProvider(create: (context) => ModuleBloc()),
        BlocProvider(create: (context) => ModuleSearchBloc()),
      ],
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: leftPanel(iid, txtModule, txtDesc, context),
            ),
            Expanded(
              flex: 6,
              child: BlocBuilder<ModuleBloc, ModuleState>(
                builder: (context, state) {
                  // if (state is ModuleSaveSuccessState) {
                  //   //txtSearch.text = '';
                  //   return rightPanel(txtSearch);
                  // }
                  return rightPanel(txtSearch);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
