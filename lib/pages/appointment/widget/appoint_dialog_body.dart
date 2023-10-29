import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_2/model/patient_with_mob.dart';

import '../bloc/mobile_search_bloc.dart';
import 'dialog_body_part_one.dart';
import 'search_box_with_mobile.dart';

// ignore: must_be_immutable
class AppointmentDialogBody extends StatelessWidget {
  AppointmentDialogBody({
    super.key,
  });
  // ignore: non_constant_identifier_names
  List<patient_with_mob> patient_list = [];
  final TextEditingController mobileTextController = TextEditingController();
  final TextEditingController dateTextController = TextEditingController();
  // ignore: non_constant_identifier_names
  bool? IsSerarch = false;
  @override
  Widget build(BuildContext context) {
    String? genderID;
    return BlocProvider(
      create: (context) => MobSearchBloc(),
      child: BlocListener<MobSearchBloc, MobSearchState>(
        listener: (context, state) {
          if (state is MobSearchSetStatus) {
            IsSerarch = state.isSearch;
            print('Mob Search State');
          }
          if (state is MobSearchDataLoaded) {
            // print('Data Loaded' + state.list.toString());
            patient_list = state.list;
          }
        },
        child: BlocBuilder<MobSearchBloc, MobSearchState>(
          builder: (context, state) {
            if (state is MobSearchSetStatus) {
              IsSerarch = state.isSearch;
              print('Mob Serch');
            }
            return Container(
              height: 480,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: Stack(
                children: [
                  DialogBodyPartOne(
                    genderID: genderID,
                    mobileTextController: mobileTextController,
                    dateTextController: dateTextController,
                  ),

                  // ignore: dead_code
                  IsSerarch!
                      // ignore: dead_code
                      ? Positioned(
                          top: 38,
                          left: 0,
                          right: 0,
                          child: SearchBoxWithMobile(
                            patient_list: patient_list,
                            onTap: (int index) {
                              print(index.toString());
                            },
                          ),
                        )
                      : const SizedBox(),
                  // ignore: dead_code
                  IsSerarch!
                      // ignore: dead_code
                      ? Positioned(
                          top: 32,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              context.read<MobSearchBloc>().add(
                                  MobSearcheventSetStatus(
                                      isSearch: false, mobNo: ''));
                            },
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: const Icon(
                                Icons.close_rounded,
                                size: 16,
                                color: Colors.white60,
                              ),
                            ),
                          ))
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
