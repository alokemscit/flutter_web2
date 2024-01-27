part of 'tabblock_bloc.dart';

sealed class TabblockEvent {}

// ignore: camel_case_types
class addTabIndex extends TabblockEvent {
  final int index;

  addTabIndex({required this.index});
}
