part of 'module_bloc.dart';

@immutable
sealed class ModuleEvent {}
class FetchModules extends ModuleEvent {
  final int subjectId;
  FetchModules(this.subjectId);
}