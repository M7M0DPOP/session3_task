import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session3_task/cubit/work_areas_cubit.dart';

import '../data/work_areas_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Home Screen')),
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: BlocProvider(
          create: (context) => WorkAreasCubit(),
          child: BlocBuilder<WorkAreasCubit, WorkAreasState>(
            builder: (context, state) {
              if (state is WorkAreasInitial) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<WorkAreasCubit>().loadWorkAreas(1, 10);
                    },
                    child: Text('Load Work Areas'),
                  ),
                );
              }
              if (state is WorkAreasError) {
                return Center(child: Text(state.errorMessage));
              }
              if (state is WorkAreasLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is WorkAreasLoaded) {
                return ListView.builder(
                  itemCount: WorkAreasRepository.workAreaList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        WorkAreasRepository.workAreaList[index].title_en,
                      ),
                      subtitle: Text(
                        WorkAreasRepository.workAreaList[index].description_en,
                      ),
                      leading: Image.network(
                        WorkAreasRepository.workAreaList[index].image_url,
                      ),
                    );
                  },
                );
              }return const Center(
                child: Text('No work areas available'),
              );
            },
          ),
        ),
      ),
    );
  }
}
