import 'package:session3_task/models/work_area.dart';
import 'work_area_api.dart';

class WorkAreasRepository {
  WorkAreasRepository._();
  static setWorkAreas(int page, int limit) async {
    List<WorkArea> workAreaList = [];
    var response = await WorkAreaApi.getRequestOfWorkArea(
      page: page,
      limit: limit,
    );

    for (Map<String, dynamic> workArea in response['workAreas']) {
      workAreaList.add(WorkArea.fromJson(workArea));
    }return workAreaList;
  }
}
