import '../../../../data/data_api.dart';
import '../model/doctor_leave_list.dart';
import '../model/doctor_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DoctorSearchState {}

class DoctorSearchInitState extends DoctorSearchState {
  final bool isSelected;
  final List<DoctorList> list;
  DoctorSearchInitState({required this.isSelected, required this.list});
}

class DoctorSearchIsSelectedState extends DoctorSearchState {
  final bool isSelected;
  DoctorSearchIsSelectedState({required this.isSelected});
}

class DoctorListLoadingState extends DoctorSearchState {}

class DoctorListSearchState extends DoctorSearchState {}

class DoctorListLeaviveDoadedState extends DoctorSearchState {
  final List<DoctorLeaveList> lList;
  DoctorListLeaviveDoadedState({required this.lList});
}

abstract class DoctorSearchEvent {}

class DoctorListSearchEvent extends DoctorSearchEvent {}

class DoctorSearchIsSelectedEvent extends DoctorSearchEvent {
  final bool isSelected;
  DoctorSearchIsSelectedEvent({required this.isSelected});
}

class DoctorSearchDoctorSelectEvent extends DoctorSearchEvent {
  final String docid;
  DoctorSearchDoctorSelectEvent({required this.docid});
}

class DoctorSearchInitEvent extends DoctorSearchEvent {}

class DoctorSearchBloc extends Bloc<DoctorSearchEvent, DoctorSearchState> {
  final data_api apiRepository;
  DoctorSearchBloc(this.apiRepository)
      : super(DoctorSearchIsSelectedState(isSelected: false)) {
    on<DoctorSearchInitEvent>(
      (event, emit) async {
        emit(DoctorListLoadingState());
        try {
          final mList = await apiRepository.createLead([
            {
              'tag': '63',
            }
          ]);
          List<DoctorList> lst =
              mList.map((e) => DoctorList.fromJson(e)).toList();
          emit(DoctorSearchInitState(isSelected: false, list: lst));
        } on Error {
          emit(DoctorSearchInitState(isSelected: false, list: []));
        }
        //emit(DoctorListLoadedState());
      },
    );
    on<DoctorSearchIsSelectedEvent>((event, emit) {
      emit(DoctorSearchIsSelectedState(isSelected: event.isSelected));
    });
    on<DoctorListSearchEvent>(
      (event, emit) {
        emit(DoctorListSearchState());
      },
    );

    on<DoctorSearchDoctorSelectEvent>(
      (event, emit) async {
        emit(DoctorListLoadingState());
        await Future.delayed(const Duration(milliseconds: 300));
        try {
          final mList = await apiRepository.createLead([
            {
              'tag': '64',
            }
          ]);
          List<DoctorLeaveList> lst =
              mList.map((e) => DoctorLeaveList.fromJson(e)).toList();
          // print(mList.length);
          if (event.docid != '') {
            List<DoctorLeaveList> lst1 =
                lst.where((element) => element.dOCID == event.docid).toList();
            emit(DoctorListLeaviveDoadedState(lList: lst1));
          } else {
            emit(DoctorListLeaviveDoadedState(lList: lst));
          }
        } on Error {
          // print('Error');
          emit(DoctorSearchInitState(isSelected: false, list: []));
        }
      },
    );
  }
}
