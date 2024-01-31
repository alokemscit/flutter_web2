// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/data_api.dart';
import 'bloc/doctor_leave_bloc.dart';
import 'data/data_doctor_leave.dart';
import 'widget/doctor_leave_widget.dart';

// ignore: must_be_immutable
class DoctorLeave extends StatelessWidget {
  const DoctorLeave({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepositoryProvider(
        create: (context) => data_api(),
        child: MultiBlocProvider(
          //create: (context) => DropdownBloc(),
          providers: [
            BlocProvider<DoctorSearchBloc>(
              create: (BuildContext context) => DoctorSearchBloc(
                RepositoryProvider.of<data_api>(context),
              ),
            ),
            BlocProvider<DoctorDataBloc>(
              create: (BuildContext context) => DoctorDataBloc(
                RepositoryProvider.of<data_api>(context),
              )..add(DoctorDataLoadEvent()),
            ),
          ],

          child: BlocBuilder<DoctorDataBloc, DoctorDataState>(
            builder: (context, state) {
              if (state is DoctorDataLoaded) {
                //dList = state.list;
                // dlistMain = state.list;
                Data_doctor_leave.dList = state.list;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        children: [
                          searchPanel(),
                          doctorSelectionPanel(),
                          doctorLeaveEntry(),
                          listGenerator(),
                          closeButtonPanel(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SingleChildScrollView(child: expandedPanel()

                          //  DoctorLeaveExpandedPanel()

                          ),
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
