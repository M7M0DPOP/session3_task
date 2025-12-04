part of 'work_areas_cubit.dart';

@immutable
sealed class WorkAreasState {}

final class WorkAreasInitial extends WorkAreasState {}

final class WorkAreasLoading extends WorkAreasState {}

final class WorkAreasLoaded extends WorkAreasState {
  static bool isHasMore = true;
  static int page = 1;
  static int limit = 2;
  static List<WorkArea> workAreasList = [];

  WorkAreasLoaded.initial(List<WorkArea> workAreasList) {
    WorkAreasLoaded.workAreasList.clear();
    WorkAreasLoaded.workAreasList = workAreasList;
  }
  WorkAreasLoaded.extend(List<WorkArea> workAreasList) {
    WorkAreasLoaded.workAreasList.addAll(workAreasList);
    WorkAreasLoaded.workAreasList=List.from(Set.of(WorkAreasLoaded.workAreasList));
  }
}

final class WorkAreasError extends WorkAreasState {
  final String errorMessage;

  WorkAreasError(this.errorMessage);
}
