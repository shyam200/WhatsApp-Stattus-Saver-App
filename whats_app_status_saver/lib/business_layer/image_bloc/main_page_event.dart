import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();
}

class MainPageLoadingEvent extends MainPageEvent {
  @override
  List<Object?> get props => [];
}
