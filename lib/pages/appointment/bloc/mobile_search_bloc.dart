import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_api.dart';
import '../../../model/patient_with_mob.dart';

abstract class MobSearchState extends Equatable {}

class MobSearchInit extends MobSearchState {
  final bool isSearch;
  MobSearchInit({required this.isSearch});
  @override
  List<Object?> get props => [];
}

class MobSearchSetStatus extends MobSearchState {
  final bool isSearch;
  MobSearchSetStatus({required this.isSearch});

  @override
  List<Object?> get props => [];
}

class MobSearchDataLoaded extends MobSearchState {
  final List<patient_with_mob> list;
  MobSearchDataLoaded({required this.list});
  @override
  List<Object?> get props => [list];
}

abstract class MobSearchevent extends Equatable {}

class MobSearcheventSetStatus extends MobSearchevent {
  final bool isSearch;
  final String mobNo;
  MobSearcheventSetStatus({required this.isSearch, required this.mobNo});

  @override
  List<Object?> get props => [isSearch, mobNo];
}

class MobSearchBloc extends Bloc<MobSearchevent, MobSearchState> {
  MobSearchBloc() : super(MobSearchSetStatus(isSearch: false)) {
    on<MobSearcheventSetStatus>((event, emit) async {
      List<patient_with_mob> mlist1 = [];
      if (event.isSearch == true && event.mobNo.length == 11) {
        var apiRepository = data_api();
        final mList = await apiRepository.createLead([
          {
            'tag': '61',
            'p_hcn_or_cell_phone': event.mobNo,
          }
        ]);

        Set<patient_with_mob> mlist0 = mList.map((item) {
          return patient_with_mob(
            hCN: item['HCN'],
            pATNAME: item['PAT_NAME'],
            dOB: item['DOB'],
            sEX: item['SEX'],
            eMAIL: item['EMAIL'],
            cELLPHONE: item['CELL_PHONE'],
            hOMEPHONE: item['HOME_PHONE'],
            tHANACODE: item['THANA_CODE'],
            dISTRICTCODE: item['DISTRICT_CODE'],
            cOUNTRY: item['COUNTRY'],
          );
        }).toSet();
        mlist1 = mlist0.toList();
        //print('Call data loaded');
      }
      emit(MobSearchDataLoaded(list: mlist1));
      emit(MobSearchSetStatus(isSearch: event.isSearch));
    });
  }
}