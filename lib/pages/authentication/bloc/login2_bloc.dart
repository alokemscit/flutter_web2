import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_2/data/data_api.dart';
import 'package:web_2/model/model_user.dart';

import '../../../component/settings/notifers/auth_provider.dart';

abstract class LoginUserState {}

class LoginUserIntialState extends LoginUserState {}

class LoginUserGetComIDState extends LoginUserState {
  final String cid;

  LoginUserGetComIDState({required this.cid});
}

class LoginUserErrorState extends LoginUserState {
  final String message;
  LoginUserErrorState({required this.message});
}

class LoginUserSuccessState extends LoginUserState {
  final String message;
  final ModelUser userData;
  LoginUserSuccessState({required this.message, required this.userData});
}

class LoginUserLoadingState extends LoginUserState {}

abstract class LoginUserEvent {}

class LoginUserSetComIDEvent extends LoginUserEvent {
  final String cid;
  LoginUserSetComIDEvent({required this.cid});
}

class LoginUserLoginEvent extends LoginUserEvent {
  final String uid;
  final String pws;
  final String cid;
  LoginUserLoginEvent(
      {required this.uid, required this.pws, required this.cid});
}

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserIntialState()) {
    on<LoginUserSetComIDEvent>((event, emit) {
      emit(LoginUserGetComIDState(cid: event.cid));
    });

    on<LoginUserLoginEvent>((event, emit) async {
      emit(LoginUserLoadingState());
      AuthProvider authProvider = AuthProvider();
      data_api2 api = data_api2();
      late List<dynamic> mList = [];
      try {
        mList = await api.createLead(
          [
            {"tag": "12", "uid": event.uid, "pws": event.pws, "cid": event.cid}
          ],
        );
          //print(mList);
      } on Exception catch (e) {
        emit(LoginUserErrorState(message: e.toString()));
        return;
      }

      List<ModelUser> lst =
          mList.map((post) => ModelUser.fromJson(post)).toList();

      if (lst.isEmpty) {
        emit(LoginUserErrorState(message: 'Invalid User ID or Passwors'));
        return;
      } else if (lst[0].status.toString() != '1') {
        // print(lst[0].sMSG.toString());
        emit(LoginUserErrorState(message: lst[0].msg.toString()));

        return;
      }

      ModelUser lsta = lst.first;
    await  authProvider.login(
          lsta.uid!,
          lsta.cid!,
          lsta.depId!,
          lsta.desigId!,
          lsta.name!,
          lsta.img!,
          lsta.code!,
          lsta.cname!,
          lsta.dpname!,
          lsta.dgname!,
          lsta.face1!,
          lsta.face2!,
          lsta.mob!);
      emit(LoginUserSuccessState(message: 'Login Success', userData: lsta));
    });
  }
}

abstract class LoadComState {}

class LoadComInitState extends LoadComState {}

class LoadComLoadedState extends LoadComState {
  final String cid;
  LoadComLoadedState({required this.cid});
}

abstract class LoadComEvent {}

class LoadComLoadEvent extends LoadComEvent {
  final String cid;
  LoadComLoadEvent({required this.cid});
}

class LoadComBloc extends Bloc<LoadComEvent, LoadComState> {
  LoadComBloc() : super(LoadComInitState()) {
    on<LoadComLoadEvent>((event, emit) {
      emit(LoadComLoadedState(cid: event.cid));
    });
  }
}
