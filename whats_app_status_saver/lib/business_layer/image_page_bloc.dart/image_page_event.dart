import 'package:equatable/equatable.dart';

abstract class ImagePageEvent extends Equatable {
  const ImagePageEvent();
  @override
  List<Object?> get props => [];
}

class ImagePageInitialEvent extends ImagePageEvent {}

class GetStatusImageDownloadEvent extends ImagePageEvent {
  final String url;

  const GetStatusImageDownloadEvent({required this.url});

  @override
  List<Object?> get props => [url];
}
