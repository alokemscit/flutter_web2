
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_status.dart';

abstract class ComRegState {}

class ComRegIntialState extends ComRegState {}

class ComRegLoadingState extends ComRegState {}

class ComRegErrorState extends ComRegState {
  final String message;
  ComRegErrorState({required this.message});
}

class ComRegSuccessState extends ComRegState {
  final String message;
  final String comid;
  ComRegSuccessState({required this.message,required this.comid});
}

abstract class ComRegEvent {}

class ComRegSaveEvent extends ComRegEvent {
  final String cname;
  final String code;
  final String name;
  final String mob;
  final String uid;
  final String pws;
  ComRegSaveEvent(
      {required this.name,
      required this.mob,
      required this.uid,
      required this.pws,
      required this.code,
      required this.cname});
}

class ComRegBloc extends Bloc<ComRegEvent, ComRegState> {
  ComRegBloc() : super(ComRegIntialState()) {
    on<ComRegSaveEvent>((event, emit) async {
      emit(ComRegLoadingState());
      data_api2 api = data_api2();
      // print(event.name);
      ModelStatus ms = ModelStatus();
      var x = await api.createLead([
        {
          //@cname,@code,@uid ,@uname,@pws
          "tag": "11",
          "cname": event.cname,
          "code": event.code,
          "uid": event.uid,
          "uname": event.name,
          "pws": event.pws,
          "mob":event.mob
        }
      ]);
      //print(x);
      ms = x.map((e) => ModelStatus.fromJson(e)).toList().first;
      // ignore: unrelated_type_equality_checks
      if (ms.status != "1") {
        emit(ComRegErrorState(message: ms.msg!));
        return;
      }
      emit(ComRegSuccessState(message: ms.msg!,comid: ms.id!));
    });
  }
}
