// video_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms_app/blocs/video/bloc/video_bloc.dart';
import 'package:lms_app/data/api_client.dart';

import 'package:lms_app/widget/simple_video_player.dart';

class VideoListScreen extends StatelessWidget {
  final int moduleId;

  const VideoListScreen({required this.moduleId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VideoBloc(ApiClient())..add(FetchVideos(moduleId)),
        child: BlocConsumer<VideoBloc, VideoState>(
          listener: (context, state) {
            if (state is VideoError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is VideoLoaded) {
              return VideoDetailScreen(video: state.videos[moduleId-1]);
           
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

}
