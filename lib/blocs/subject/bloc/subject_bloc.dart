import 'package:bloc/bloc.dart';
import 'package:lms_app/data/api_client.dart';
import 'package:lms_app/model/subject.dart';
import 'package:meta/meta.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final ApiClient apiClient;

  SubjectBloc(this.apiClient) : super(SubjectInitial()) {
    on<FetchSubjects>(_onFetchSubjects);
  }

  Future<void> _onFetchSubjects(
    FetchSubjects event,
    Emitter<SubjectState> emit,
  ) async {
    emit(SubjectLoading());
    try {
      final response = await apiClient.get('subjects.php');
      final subjects =
          (response)
              .map((subjectJson) => Subject.fromJson(subjectJson))
              .toList();

      emit(SubjectLoaded(subjects));
    } catch (e) {
      emit(SubjectError(e.toString()));
    }
  }
}
