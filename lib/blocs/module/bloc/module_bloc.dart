import 'package:bloc/bloc.dart';
import 'package:lms_app/data/api_client.dart';
import 'package:lms_app/model/module.dart';
import 'package:meta/meta.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final ApiClient apiClient;

  ModuleBloc(this.apiClient) : super(ModuleInitial()) {
    on<FetchModules>(_onFetchModules);
  }

  Future<void> _onFetchModules(
    FetchModules event,
    Emitter<ModuleState> emit,
  ) async {
    emit(ModuleLoading());
    try {
      final response = await apiClient.get('modules.php?subject_id=${event.subjectId}');
      final modules =
          (response).map((moduleJson) => Module.fromJson(moduleJson)).toList();
      emit(ModuleLoaded(modules));
    } catch (e) {
      emit(ModuleError(e.toString()));
    }
  }
}
