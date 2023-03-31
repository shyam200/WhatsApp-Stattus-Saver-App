import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_page_event.dart';
import 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc() : super(MainPageInitialState()) {
    on<MainPageLoadingEvent>(_onLoading);
  }

  void _onLoading(MainPageEvent event, Emitter<MainPageState> emit) async {
    // print('loading.....');
    // emit(MainPageLoadingState());
    // print('loading completed......');
    // emit(MainPageDataLoadedState());
  }
}
