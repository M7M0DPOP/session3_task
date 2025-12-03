part of 'work_areas_cubit.dart';

@immutable
sealed class WorkAreasState {}

final class WorkAreasInitial extends WorkAreasState {}

final class WorkAreasLoading extends WorkAreasState {}

final class WorkAreasLoaded extends WorkAreasState {
  final List<WorkArea> workAreas;

  WorkAreasLoaded(this.workAreas);
}

final class WorkAreasError extends WorkAreasState {
  final String errorMessage;

  WorkAreasError(this.errorMessage);
}
