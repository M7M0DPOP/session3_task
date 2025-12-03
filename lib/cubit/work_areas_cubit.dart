import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/work_areas_repository.dart' show WorkAreasRepository;
import '../models/work_area.dart';
part 'work_areas_state.dart';

class WorkAreasCubit extends Cubit<WorkAreasState> {
  WorkAreasCubit() : super(WorkAreasInitial());
  void loadWorkAreas(int page, int limit) async {
    emit(WorkAreasLoading());
    try {
      List<WorkArea> workAreaList = await WorkAreasRepository.setWorkAreas(
        page,
        limit,
      );
      emit(WorkAreasLoaded(workAreaList));
    } catch (e) {
      emit(WorkAreasError(e.toString()));
    }
  }
}
