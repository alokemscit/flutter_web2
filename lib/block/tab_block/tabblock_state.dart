part of 'tabblock_bloc.dart';
sealed class TabblockState {
  final int index;
  const TabblockState(this.index);
}

final class TabblockInitial extends TabblockState {
  const TabblockInitial(super.index);
}
