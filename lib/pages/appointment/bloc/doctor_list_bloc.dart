
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_api.dart';
import '../../../data/data_docror_image.dart';
import '../../../model/app_time.dart';

abstract class DoctorShowEvent extends Equatable {}

class DoctorShowSubmitEvent extends DoctorShowEvent {
  final String date;
  final String did;
  final String unit;

  DoctorShowSubmitEvent(
      {required this.date, required this.did, required this.unit});
  @override
  List<Object?> get props => [];
}

abstract class DoctorShowState extends Equatable {}

class DoctorShowInit extends DoctorShowState {
  @override
  List<Object?> get props => [];
}

class DoctorShowLoding extends DoctorShowState {
  @override
  List<Object?> get props => [];
}

class DoctorShowLoded extends DoctorShowState {
  final List<AppTime>? list;
  final List<DistinctDoctor>? dList;
  DoctorShowLoded(this.list, this.dList);
  @override
  List<Object?> get props => [list];
}

class NetError extends Error {}

class DoctorShowError extends DoctorShowState {
  final String? error;

  DoctorShowError(this.error);

  @override
  List<Object?> get props => [error];
}

class DoctorShowBloc extends Bloc<DoctorShowEvent, DoctorShowState> {
  final data_api apiRepository;
  DoctorShowBloc(this.apiRepository) : super(DoctorShowInit()) {
    on<DoctorShowSubmitEvent>((event, emit) async {
      emit(DoctorShowLoding());
      try {
        final mList = await apiRepository.createLead([
          {
            'tag': '60',
            'p_dept_id': event.did,
            'p_unit_id': event.unit,
            'p_sysdate_date': event.date,
            'p_entry_by': '1000'
          }
        ]);
        List<DoctorImage> docImage = await GetDoctorImage().ImageList();

       // print('${docImage.length}len');
        Set<AppTime> mlist1 = mList.map((item) {
          //var x = docImage.where((e) => e.id == item['DOCTOR_ID'].toString());

          // .first
          // .image;
          // print(x);

          return AppTime(
            id: item['DOCTOR_ID'] == null ? '' : item['DOCTOR_ID'].toString(),
            name: item['DOCTOR_NAME'] == null
                ? ''
                : item['DOCTOR_NAME'].toString(),
            designation: item['DEG'] == null ? '' : item['DEG'].toString(),
            stime: item['ATIME'] == null ? '' : item['ATIME'].toString(),
            status: item['TP'] == null ? '' : item['TP'].toString(),
            image: (docImage.where((e) => e.id == item['DOCTOR_ID'].toString()))
                    .toList()
                    .isEmpty
                ? 'https://web.asgaralihospital.com/assets/img/media-user.png'
                : 'https://www.asgaralihospital.com/storage/${docImage.where((e) => e.id == item['DOCTOR_ID'].toString()).first.image}',
            //'https://www.asgaralihospital.com/storage/doctors/vczm1a75nsZZfBfxqpXWvZzDI.webp',
            comments:
                item['COMMENTS'] == null ? '' : item['COMMENTS'].toString(),
            sl: int.parse(item['FSL']),
            date: event.date,
          );
        }).toSet();
      //  print('Tot doc-' + mlist1.toList().length.toString());

        Set<DistinctDoctor> dList = mList.map((item) {
          return DistinctDoctor(
            id: item['DOCTOR_ID'].toString(),
          );
        }).toSet();

      //  print('doc-' + dList.length.toString());

        await Future.delayed(const Duration(milliseconds: 100));
        emit(DoctorShowLoded(mlist1.toList(), dList.toList()));

        // emit(DoctorShowLoded(mlist.toList()));
      } on Error {
        emit(DoctorShowError('Network face error'));
      }
    });
  }
}
