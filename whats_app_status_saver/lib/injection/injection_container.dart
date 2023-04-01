import 'package:get_it/get_it.dart';

import '../business_layer/image_bloc/main_page_bloc.dart';
import '../core/access_permissions/access_permissions_wrapper.dart';

//This will hold dependency injection
///setting [di] naming from dependency injection

final di = GetIt.instance;

Future<void> init() async {
  //!Bloc
  di.registerFactory<MainPageBloc>(
      () => MainPageBloc(accessPermissionsWrapper: di()));
  //!Repository
  //!Data Provider
  //!View logic

  //! Access Permissions
  di.registerLazySingleton<AccessPermissionsWrapper>(
      () => AccessPermissionsWrapper());
}
