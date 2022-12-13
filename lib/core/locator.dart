import 'package:get_it/get_it.dart';
import 'package:watsapcloneee/core/services/auth_service.dart';
import 'package:watsapcloneee/core/services/firestore.dart';
import 'package:watsapcloneee/viewModels/sign_in_model.dart';

import '../viewModels/chatsviewmodel.dart';

GetIt getIt = GetIt.instance;

setupLocators() {
  getIt.registerLazySingleton(() => FirestoreDB());
  getIt.registerLazySingleton(() => AuthService());
  getIt.registerFactory(() => ChatsModel());
  getIt.registerFactory(() => SignInModel());
}
