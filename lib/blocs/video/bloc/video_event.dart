part of 'video_bloc.dart';

@immutable
sealed class VideoEvent {}
class FetchVideos extends VideoEvent {
  final int moduleId;
  FetchVideos(this.moduleId);
}