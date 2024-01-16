import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../component/settings/notifers/auth_provider.dart';
import '../authentication/login_page.dart';
import 'parent_page_widget/parent_background_widget.dart';
import 'parent_page_widget/parent_page_top_widget.dart';
import 'parent_page_widget/parent_module_list_holder_widget.dart';

class ParentPage extends StatelessWidget {
  const ParentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => LoginBloc(
                                Provider.of<AuthProvider>(context,
                                    listen: false)),
      child: const Scaffold(
          body: SafeArea(
        child: Stack(
          children: [
            ParentPageBackground(),
            ParentPageTopWidget(),
            ParentPageModuleHolderWidget(),
          ],
        ),
      )),
    );
  }
}
