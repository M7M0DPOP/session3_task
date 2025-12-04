import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/work_areas_cubit.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({super.key});

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<WorkAreasCubit>().extendWorkAreas(
          WorkAreasLoaded.page,
          WorkAreasLoaded.limit,
        );
        WorkAreasLoaded.page++;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocBuilder<WorkAreasCubit, WorkAreasState>(
        builder: (context, state) {
          if (state is WorkAreasInitial) {
            return RefreshIndicator(
              child: ListView.builder(
                itemCount: 0,
                itemBuilder: (context, index) {
                  return ListTile();
                },
              ),
              onRefresh: () =>
                  context.read<WorkAreasCubit>().initialaizWorkAreas(1, 2),
            );
          }
          if (state is WorkAreasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<WorkAreasCubit>().initialaizWorkAreas(1, 2);
                    },
                    child: Text('Retry'),
                  ),
                  Text(state.errorMessage),
                ],
              ),
            );
          }
          if (state is WorkAreasLoading) {

            return const Center(child: CircularProgressIndicator());
          }
          if (state is WorkAreasLoaded) {
            return RefreshIndicator(
              onRefresh: () =>
                  context.read<WorkAreasCubit>().initialaizWorkAreas(1, 2),
              child: ListView.builder(
                controller: scrollController,
                itemCount: WorkAreasLoaded.workAreasList.length + 1,
                itemBuilder: (context, index) {
                  if (WorkAreasLoaded.workAreasList.length != index) {
                    return ListTile(
                      minTileHeight: 450,

                      title: Text(
                        WorkAreasLoaded.workAreasList[index].title_en,
                      ),
                      subtitle: Text(
                        WorkAreasLoaded.workAreasList[index].description_en,
                      ),
                      leading: Image.network(
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        WorkAreasLoaded.workAreasList[index].image_url,
                      ),
                    );
                  } else {
                    if (WorkAreasLoaded.workAreasList.length <
                        (WorkAreasLoaded.page - 1) * WorkAreasLoaded.limit) {
                      WorkAreasLoaded.isHasMore = false;
                    }
                    return WorkAreasLoaded.isHasMore
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Center(child: Text('No more data')),
                          );
                  }
                },
              ),
            );
          }
          return const Center(child: Text('No work areas available'));
        },
      ),
    );
  }
}
