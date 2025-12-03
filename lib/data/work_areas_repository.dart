import 'package:session3_task/models/work_area.dart';
import 'work_area_api.dart';

class WorkAreasRepository {
  static List<WorkArea> workAreaList = [];
  WorkAreasRepository._();
  static setWorkAreas(int page, int limit) async {
    workAreaList.clear();
    var response = await WorkAreaApi.getRequestOfWorkArea(
      page: page,
      limit: limit,
    );

    for (Map<String, dynamic> workArea in response['workAreas']) {
      workAreaList.add(WorkArea.fromJson(workArea));
    }
  }
}
