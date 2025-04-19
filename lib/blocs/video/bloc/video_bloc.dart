import 'package:bloc/bloc.dart';
import 'package:lms_app/data/api_client.dart';
import 'package:lms_app/model/video.dart';
import 'package:meta/meta.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final ApiClient apiClient;

  VideoBloc(this.apiClient) : super(VideoInitial()) {
    on<FetchVideos>(_onFetchVideos);
  }

  Future<void> _onFetchVideos(
    FetchVideos event,
    Emitter<VideoState> emit,
  ) async {
    emit(VideoLoading());
    try {
      final response = await apiClient.get(
        'videos.php?module_id=${event.moduleId}',
      );
      final videos = (response).map((json) => Video.fromJson(json)).toList();
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }
}
