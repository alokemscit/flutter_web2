import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
import 'package:web_2/model/model_user.dart';
import 'package:web_2/modules/authentication/login_page2.dart';

import '../../../component/settings/config.dart';
 


import '../../../component/widget/custom_cached_network_image.dart';
import '../../authentication/login_page.dart';
//import 'package:flutter/foundation.dart' show kIsWeb;

class LoginUsersImageAndDetails extends StatelessWidget {
  const LoginUsersImageAndDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 0),
      child: FutureBuilder<ModelUser?>(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState==ConnectionState.waiting) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (!snapshot.hasData) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: const TextStyle(color: Colors.red, fontSize: 12),
              );
            } else if (snapshot.hasData) {
              
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomCachedNetworkImage(
                    height: 55,
                    width: 55,
                    img: snapshot.data!.img!,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth: 160, maxHeight: 13),
                          child: Text(
                            snapshot.data!.name!,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          constraints: const BoxConstraints(
                              maxWidth: 160, maxHeight: 15),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Text(
                              snapshot.data!.dgname!,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
    
                        // const SizedBox(width: 2,),
    
                        BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state is LoginOutSate) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage2()),
                              );
                            }
                          },
                          child: BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              return InkWell(
                                  onTap: () {
                                    context
                                        .read<LoginBloc>()
                                        .add(LogOutEvent());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colors.amber,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Text(
                                            'Log out',
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 51, 1, 138),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        )),
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const Text("No Data");
            }
          }),
    );
  }
}
