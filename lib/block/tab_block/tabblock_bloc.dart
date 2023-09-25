import 'package:flutter_bloc/flutter_bloc.dart';

part 'tabblock_event.dart';
part 'tabblock_state.dart';

class TabblockBloc extends Bloc<TabblockEvent, TabblockInitial> {
  final int index = 0;
  TabblockBloc() : super( const TabblockInitial(0)) {
    on<TabblockEvent>((event, emit) {
      if (event is addTabIndex) {
        // index = event.index;
        emit(TabblockInitial(event.index));
        //print(event.index.toString());
      }

      //emit(TabblockState(event.));
    });
  }
}
