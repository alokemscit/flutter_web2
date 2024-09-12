import 'package:equatable/equatable.dart';

import '../../../../data/data_api.dart';
import '../model/doctor_leave_list.dart';
import '../model/doctor_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DoctorDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorDataLoading extends DoctorDataState {}

class DoctorDataLoaded extends DoctorDataState {
  final List<DoctorList> list;

  DoctorDataLoaded({required this.list});
}

abstract class DoctorDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorDataLoadEvent extends DoctorDataEvent {}

class DoctorDataBloc extends Bloc<DoctorDataEvent, DoctorDataState> {
  final data_api apiRepository;
  DoctorDataBloc(this.apiRepository) : super(DoctorDataLoading()) {
    on<DoctorDataLoadEvent>((event, emit) async {
      try {
        final mList = await apiRepository.createLead([
          {
            'tag': '63',
          }
        ]);
        List<DoctorList> lst =
            mList.map((e) => DoctorList.fromJson(e)).toList();
        emit(DoctorDataLoaded(list: lst));
      } on Error {
        emit(DoctorDataLoaded(list: const []));
      }
    });
  }
}

abstract class DoctorSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorSearchInitState extends DoctorSearchState {
  final bool isSelected;
  final List<DoctorList> list;
  DoctorSearchInitState({required this.isSelected, required this.list});
}

class DoctorSearchIsSelectedState extends DoctorSearchState {
  final bool isSelected;
  DoctorSearchIsSelectedState({required this.isSelected});
}

class DoctorSearchCloseState extends DoctorSearchState {
  final bool isSelected;
  DoctorSearchCloseState({required this.isSelected});
}

class DoctorSearchCheckAllState extends DoctorSearchState {
  final bool isSChecked;
  DoctorSearchCheckAllState({required this.isSChecked});
}

class DoctorListLoadingState extends DoctorSearchState {}

class DoctorListLoadingLeaveDataState extends DoctorSearchState {}

class DoctorListRefreshState extends DoctorSearchState {}

class DoctorListSearchState extends DoctorSearchState {
  final String txt;

  DoctorListSearchState({required this.txt});
}

class DoctorListGetDocIdNameState extends DoctorSearchState {
  final String docId;
  final String docName;
  DoctorListGetDocIdNameState({required this.docId, required this.docName});
}

class DoctorListLeaviveDoadedState extends DoctorSearchState {
  final bool isChecked;
  final List<DoctorLeaveList> lList;
  DoctorListLeaviveDoadedState({required this.isChecked, required this.lList});
}

class DoctorSearchSetDoctorListState extends DoctorSearchState {
  final bool isSelected;
  final List<DoctorList> list;
  DoctorSearchSetDoctorListState(
      {required this.isSelected, required this.list});
}

abstract class DoctorSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DoctorListSearchEvent extends DoctorSearchEvent {
  final String txt;

  DoctorListSearchEvent({required this.txt});
}

class DoctorSearchIsSelectedEvent extends DoctorSearchEvent {
  final bool isSelected;
  DoctorSearchIsSelectedEvent({required this.isSelected});
}

class DoctorSearchCloseEvent extends DoctorSearchEvent {
  final bool isSelected;
  DoctorSearchCloseEvent({required this.isSelected});
}

class DoctorSearchCheckAllEvent extends DoctorSearchEvent {
  final String docID;
  final bool isSChecked;
  DoctorSearchCheckAllEvent({required this.docID, required this.isSChecked});
}

//List<DoctorList>

class DoctorSearchSetDoctorListEvent extends DoctorSearchEvent {
  final bool isSelected;
  final List<DoctorList> list;
  final String docId;
  final String docName;
  DoctorSearchSetDoctorListEvent(
      {required this.isSelected,
      required this.list,
      required this.docId,
      required this.docName});
}

class DoctorSearchDoctorSelectEvent extends DoctorSearchEvent {
  final String docid;
  DoctorSearchDoctorSelectEvent({required this.docid});
}

class DoctorListGetDocIdNameEvent extends DoctorSearchEvent {
  final String docId;
  final String docName;

  DoctorListGetDocIdNameEvent({required this.docId, required this.docName});
}

class DoctorSearchInitEvent extends DoctorSearchEvent {}

class DoctorSearchBloc extends Bloc<DoctorSearchEvent, DoctorSearchState> {
  final data_api apiRepository;
  DoctorSearchBloc(this.apiRepository) : super(DoctorListLoadingState()) {
    
    on<DoctorSearchCheckAllEvent>(
      (event, emit) async {
        //  emit(DoctorSearchCheckAllState(isSChecked: event.isSChecked));

        emit(DoctorListLoadingLeaveDataState());

        await Future.delayed(const Duration(milliseconds: 500));
        try {
          final mList = await apiRepository.createLead([
            {
              'tag': '64',
            }
          ]);
          List<DoctorLeaveList> lst =
              mList.map((e) => DoctorLeaveList.fromJson(e)).toList();
          //print(mList.length);
          if (event.docID != '') {
            emit(DoctorListRefreshState());
            // emit(DoctorSearchCheckAllState(isSChecked: false));
            List<DoctorLeaveList> lst1 =
                lst.where((element) => element.dOCID == event.docID).toList();
            emit(DoctorListLeaviveDoadedState(lList: lst1, isChecked: false));
          } else {
            // print(lst.length);
            emit(DoctorListLeaviveDoadedState(lList: lst, isChecked: event.isSChecked));
          }
        } on Error {
          // print('Error');
          emit(DoctorListLeaviveDoadedState(lList: const [], isChecked: false));
        }

        // emit(DoctorListRefreshState());
      },
    );

    on<DoctorSearchSetDoctorListEvent>(
      (event, emit) async {

 emit(DoctorSearchSetDoctorListState(
            isSelected: event.isSelected, list: event.list));
        await  Future.delayed( const Duration(microseconds: 500));

        emit(DoctorListGetDocIdNameState(
            docId: event.docId, docName: event.docName));

        //emit(DoctorListRefreshState());
      //  
       
      },
    );
    on<DoctorSearchCloseEvent>(
      (event, emit) {
        emit(DoctorSearchCloseState(isSelected: event.isSelected));
      },
    );

    on<DoctorSearchIsSelectedEvent>((event, emit) {
      emit(DoctorSearchIsSelectedState(isSelected: event.isSelected));
      //print("2");
    });
    on<DoctorListSearchEvent>(
      (event, emit) {
        // print("3");
        emit(DoctorListRefreshState());
        emit(DoctorListSearchState(txt: event.txt));
      },
    );

  
  }
}
