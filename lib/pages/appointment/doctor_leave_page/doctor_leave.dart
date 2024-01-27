import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_2/component/settings/responsive.dart';

import 'package:web_2/pages/appointment/doctor_leave_page/model/doctor_list_model.dart';

import '../../../data/data_api.dart';
import 'bloc/doctor_leave_bloc.dart';
import 'model/doctor_leave_list.dart';
import 'widget/doctor_leave_widget.dart';

// ignore: must_be_immutable
class DoctorLeave extends StatelessWidget {
  DoctorLeave({super.key});

  String? did;
  String? docId = '', docName = '';
  bool isSected = true;
  List<DoctorList> dList = [];
  List<DoctorList> dlistMain = [];
  List<DoctorList> dlistCombo = [];
  bool isChecked = false;
  List<DoctorLeaveList> lLst = [];
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _fdateController = TextEditingController();
  final TextEditingController _tdateController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget commonPart(BuildContext context, DoctorSearchState state) {
      return Stack(
        children: [
          searchBoxDoctor(size, _searchController, () {
            dList = dlistMain
                .where((element) =>
                    element.dOCTORNAME!.toLowerCase().contains(
                        _searchController.text.toString().toLowerCase()) ||
                    element.uNIT!.toLowerCase().contains(
                        _searchController.text.toString().toLowerCase()) ||
                    element.dOCID!.toLowerCase().contains(
                        _searchController.text.toString().toLowerCase()))
                .toList();

            context.read<DoctorSearchBloc>().add(DoctorListSearchEvent());
          }, () {
            context
                .read<DoctorSearchBloc>()
                .add(DoctorSearchIsSelectedEvent(isSelected: true));
          }),
          doctorSelectedPart(size, docId, docName!),
          leaveInfoEntry(size, _fdateController, _tdateController,
              _remarksController, dlistCombo, did, (val) {
            did = val.toString();
          }),
          docId == '' ? disableCover(size) : const SizedBox(),
          isSected
              ? doctorListGenator(
                  size, did, docId, docName, dList, dlistMain, dlistCombo,
                  (docID, dName, uname) {
                  docId = docID;
                  docName = dName;
                  did = null;
                  dlistCombo = dlistMain
                      .where((element) =>
                          element.uNIT == uname &&
                          element.dOCTORNAME != docName)
                      .toList();
                  context
                      .read<DoctorSearchBloc>()
                      .add(DoctorSearchIsSelectedEvent(isSelected: false));
                })
              : const SizedBox(),
          isSected ? closeButton(context) : const SizedBox(),
        ],
      );
    }

    Widget mainWidget(
        BuildContext context, DoctorSearchState state, bool isDesktop) {
      return isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonPart(context, state),
                expandedDetailsPart(size, lLst, isChecked, state, (isCheck) {
                  isChecked = isCheck!;
                  if (isCheck == true) {
                    context
                        .read<DoctorSearchBloc>()
                        .add(DoctorSearchDoctorSelectEvent(docid: ''));
                  } else {
                    context
                        .read<DoctorSearchBloc>()
                        .add(DoctorListSearchEvent());
                  }
                })
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonPart(context, state),
                expandedDetailsPart(size, lLst, isChecked, state, (isCheck) {
                  isChecked = isCheck!;
                  if (isCheck == true) {
                    context
                        .read<DoctorSearchBloc>()
                        .add(DoctorSearchDoctorSelectEvent(docid: ''));
                  }
                })
              ],
            );
    }

     

    // ignore: unnecessary_null_comparison
     
      return RepositoryProvider(
        create: (context) => data_api(),
        child: BlocProvider(
          create: (context) => DoctorSearchBloc(
            RepositoryProvider.of<data_api>(context),
          )..add(DoctorSearchInitEvent()),
          child: Scaffold(
            backgroundColor: Colors.white, //kDefaultIconLightColor,
            body: SizedBox(
              width: double.infinity,
              height: size.height - 28,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: BlocBuilder<DoctorSearchBloc, DoctorSearchState>(
                  builder: (context, state) {
                    print(state.toString());
                    if (state is DoctorSearchIsSelectedState) {
                      // _width = 0;
                      isSected = state.isSelected;
                    }
                    if (state is DoctorSearchInitState) {
                      dList = state.list;
                      dlistMain = state.list;
                      isSected = state.isSelected;
                      // print(dList.length.toString());
                    }
                    if (state is DoctorListLeaviveDoadedState) {
                      lLst = state.lList;
                    }
                    return Responsive(
                        mobile: mainWidget(context, state, false),
                        tablet: mainWidget(context, state, true),
                        desktop: mainWidget(context, state, true));
                  },
                ),
              ),
            ),
          ),
        ),
      );
     
  }
}
