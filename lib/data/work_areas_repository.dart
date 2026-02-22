import 'package:session3_task/models/work_area.dart';
import 'work_area_api.dart';

class WorkAreasRepository {
  WorkAreasRepository._();
  static setWorkAreasWithSearch({
    int page = 1,
    int limit = 2,
    String search = '',
  }) async {
    List<WorkArea> workAreaList = [];
    var response = await WorkAreaApi.getRequestOfWorkArea(
      page: page,
      limit: limit,
    );

    if (search.isEmpty) {
      for (Map<String, dynamic> workArea in response['workAreas']) {
        workAreaList.add(WorkArea.fromJson(workArea));
      }
    } else {
      for (Map<String, dynamic> workArea in response['workAreas']) {
        if (workArea['name'].toString().toLowerCase().contains(
          search.toLowerCase(),
        )) {
          workAreaList.add(WorkArea.fromJson(workArea));
        }
      }
    }
    return workAreaList;
  }
}
