import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/work_areas_repository.dart' show WorkAreasRepository;
import '../models/work_area.dart';
part 'work_areas_state.dart';

class WorkAreasCubit extends Cubit<WorkAreasState> {
  WorkAreasCubit() : super(WorkAreasInitial());
  Future<void> initialaizWorkAreas(int page, int limit) async {
                WorkAreasLoaded.isHasMore = true;
            WorkAreasLoaded.page = 2;
    emit(WorkAreasLoading());
    try {
      List<WorkArea> workAreaList = await WorkAreasRepository.setWorkAreas(
        page,
        limit,
      );
      emit(WorkAreasLoaded.initial(workAreaList));
    } catch (e) {
      emit(WorkAreasError(e.toString()));
    }
  }

  Future<void> extendWorkAreas(int page, int limit) async {
    try {
      List<WorkArea> workAreaList = await WorkAreasRepository.setWorkAreas(
        page,
        limit,
      );
      emit(WorkAreasLoaded.extend(workAreaList));
    } catch (e) {
      emit(WorkAreasError(e.toString()));
    }
  }
}
