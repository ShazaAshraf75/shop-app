import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/shared/network/local/cache_helper.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = true;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
    }
    CacheHelper.putBoolean(key: "isDark", value: isDark).then((value) {
      emit(ChangeAppModeState());
    });
  }
}
