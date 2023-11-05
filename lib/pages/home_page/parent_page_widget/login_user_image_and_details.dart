
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../component/settings/config.dart';
import '../../../component/settings/notifers/auth_provider.dart';
import '../../../component/widget/custom_avater.dart';
import '../../../model/user_model.dart';
import '../../authentication/login_page.dart';


class LoginUsersImageAndDetails extends StatelessWidget {
  const LoginUsersImageAndDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4, bottom: 4),
      child: FutureBuilder<User_Model>(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // Attempt to decode the base64 image
                try {
                  final MemoryImage backgroundImage =
                      MemoryImage(base64.decode(snapshot.data!.iMAGE!));
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomAvater(
                        backgroundImage: backgroundImage,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: 160, maxHeight: 12),
                              child: Text(
                                snapshot.data!.eMPNAME!,
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
                                  snapshot.data!.dSGNAME!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),

                            // const SizedBox(width: 2,),

                            BlocProvider(
                              create: (context) => LoginBloc(
                                  Provider.of<AuthProvider>(context,
                                      listen: false)),
                              child: BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  return InkWell(
                                      onTap: () {
                                        context
                                            .read<LoginBloc>()
                                            .add(LogOutEvent());
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
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
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w800),
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
                } catch (e) {
                  return const CustomAvater(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    size: 40,
                  );
                }
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}
