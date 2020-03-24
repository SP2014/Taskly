import 'package:flutter_playground/core/data_sources/task_local_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/repository/task_repository.dart';
import 'core/repository/task_repository_impl.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator() async{

  // DataSources
  locator.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl());

  // Repositories
  locator.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl());

  locator.registerLazySingleton<HiveInterface>(() => Hive);
}