part of 'module_bloc.dart';

@immutable
abstract class ModuleState {}
class ModuleInitial extends ModuleState {}
class ModuleLoading extends ModuleState {}
class ModuleLoaded extends ModuleState {
  final List<Module> modules;
  ModuleLoaded(this.modules);
}
class ModuleError extends ModuleState {
  final String message;
  ModuleError(this.message);
}