import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/app_theme/app_theme.dart';
import '../core/singleton/ws_app_data.dart';

import '../business_layer/image_page_bloc.dart/image_page_bloc.dart';
import '../business_layer/main_page_bloc/main_page_bloc.dart';
import '../business_layer/video_page_bloc.dart/video_page_bloc.dart';
import '../core/access_permissions/access_permissions_wrapper.dart';
import '../core/local_storage/shared_preference_manager.dart';
import '../core/method_channels/ws_platform_channel.dart';

//This will hold dependency injection
///setting [di] naming from dependency injection

final di = GetIt.instance;

Future<void> init() async {
  //!Bloc
  di.registerLazySingleton<MainPageBloc>(() => MainPageBloc(
        accessPermissionsWrapper: di(),
        sharedPreferenceManager: di(),
        appData: di(),
      ));

  di.registerFactory<ImagePageBloc>(() => ImagePageBloc());
  di.registerFactory<VideoPageBloc>(() => VideoPageBloc());

  //!Repository
  //!Data Provider
  //!View logic

  //! Access Permissions
  di.registerLazySingleton<AccessPermissionsWrapper>(
      () => AccessPermissionsWrapper());

  //! Shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // di.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  di.registerLazySingleton<SharedPreferenceManager>(
      () => SharedPreferenceManager(sharedPreferences: sharedPreferences));

  //! WSPlatformChannel
  di.registerLazySingleton<WSPlatformChannel>(() => WSPlatformChannel());

//! Utils
  di.registerLazySingleton<WSAppTheme>(() => WSAppTheme());

  //! Singleton
  di.registerLazySingleton<WsAppData>(() => WsAppData());
}
