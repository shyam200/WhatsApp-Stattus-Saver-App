import 'package:equatable/equatable.dart';

abstract class VideoPageEvent extends Equatable {
  const VideoPageEvent();
  @override
  List<Object?> get props => [];
}

class GetStatusVideoDownloadEvent extends VideoPageEvent {
  final String url;

  const GetStatusVideoDownloadEvent({required this.url});

  @override
  List<Object?> get props => [url];
}
