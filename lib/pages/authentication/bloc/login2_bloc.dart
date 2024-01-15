import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LoginUserState {}

class LoginUserIntialState extends LoginUserState {}

class LoginUserLoadingState extends LoginUserState {}

class LoginUserLoadedState extends LoginUserState {}

class LoginUserComapnyDataState extends LoginUserState {}

class LoginUserComapnyLoadedState extends LoginUserState {}

abstract class LoginUserEvent {}

class LoginUserCompanyLoadedEvent extends LoginUserEvent {}

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserIntialState()) {
    on<LoginUserCompanyLoadedEvent>((event, emit) {
      emit(LoginUserComapnyLoadedState());
    });
  }
}
