import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laatte/viewmodel/model/basic_info.dart';
import 'package:laatte/viewmodel/model/irl.dart';
import 'package:laatte/viewmodel/model/irl.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
part 'app_state.dart';

class AppStateCubit extends Cubit<AppStateInitial> {
  final BuildContext context;
  AppStateCubit({required this.context}) : super(AppStateInitial()) {
    initializeCubit();
  }

  int get currentPage => state.currentPage;
  bool get isDarkMode => state.isDarkMode;
  bool get isSystemDarkMode => state.isSystemDarkMode;
  bool get isOpenDrawer => state.isOpenDrawer;

  set currentPage(int currentPage) {
    emit(state.copyWith(currentPage: currentPage));
  }

  set isDarkMode(bool isDarkMode) {
    // emit(state.copyWith(isDarkMode: isDarkMode));
    // emit(state.copyWith(isSystemDarkMode: false));
    // toggleDarkMode(isDarkMode);
  }

  Future toggleDarkMode(bool isDarkMode) async {
    // final Box settings = await Hive.openBox('settings');
    // settings.put('isDarkMode', isDarkMode);
    // settings.put('isSystemDarkMode', false);
  }

  Future toggleDarkModeInit(Brightness platformBrightness) async {
    // final Box settings = await Hive.openBox('settings');
    // bool isDarkMode = settings.get('isDarkMode', defaultValue: false);
    // emit(state.copyWith(isDarkMode: isDarkMode));
    // bool isSystemDarkMode =
    //     settings.get('isSystemDarkMode', defaultValue: true);
    // emit(state.copyWith(isSystemDarkMode: isSystemDarkMode));
    // setSystemThemeMode(platformBrightness);
  }

  Future setSystemThemeMode(Brightness platformBrightness) async {
    if (isSystemDarkMode) {
      // final platformBrightness =
      //     View.of(context).platformDispatcher.platformBrightness;
      // final isDarkMode = platformBrightness == Brightness.dark;
      // debugPrint(
      //     "setSystemThemeMode isDarkMode $isDarkMode platformBrightness ${platformBrightness.name}");
      // final Box settings = await Hive.openBox('settings');
      // emit(state.copyWith(isSystemDarkMode: true));
      // emit(state.copyWith(isDarkMode: isDarkMode));
      // await settings.put('isSystemDarkMode', true);
      // await settings.put('isDarkMode', isDarkMode);
      // debugPrint('setSystemThemeMode isSystemDarkMode $isSystemDarkMode');
    }
  }

  Future setSystemThemeMenualMode(Brightness platformBrightness) async {
    // final Box settings = await Hive.openBox('settings');
    // bool isSystemDarkMode =
    //     settings.get('isSystemDarkMode', defaultValue: false);
    // settings.put('isSystemDarkMode', true);
    // emit(state.copyWith(isSystemDarkMode: true));
    // setSystemThemeMode(platformBrightness);
  }

  void initializeCubit() {
    initializeHive();
    // getProfile();
  }

  Future<void> initializeHive() async {}

  void clear() {
    currentPage = 0;
    isDarkMode = false;
  }

  set isOpenDrawer(bool isOpenDrawer) {
    emit(state.copyWith(isOpenDrawer: isOpenDrawer));
  }

  UserReport? get userReport => state.userReport;

  set userReport(UserReport? userReport) {
    emit(state.copyWith(userReport: userReport));
  }

  // active modules get an setters
  // List<String> get activeCards => state.activeCards;
  // List<HomeItem> get activeItems =>
  //     HomeCard.items(state.activeCards).where((item) => item.isActive).toList();
  // set activeCards(List<String> activeCards) {
  //   emit(state.copyWith(activeCards: activeCards));
  // }

  BasicInfo? get basicInfo => state.basicInfo;
  set basicInfo(BasicInfo? basicInfo) {
    emit(state.copyWith(basicInfo: basicInfo));
  }

  // List<HomeItem> get activeHomeItems =>
  //     HomeCard.items(state.basicInfo?.permissions?.modules)
  //         .where((item) => item.isActive)
  //         .toList();

  // get module & fetures permissions
  bool get hasAddEmployeePermission =>
      state.basicInfo?.permissions?.features?.contains("add_employee") ?? false;
  // get module & fetures permissions End

  // final PageController _profileUpdateController = PageController();
  // PageController get profileUpdateController => _profileUpdateController;

  // int get profileUpdateCurrentPage => state.profileUpdateCurrentPage;
  // set profileUpdateCurrentPage(int currentPage) {
  //   emit(state.copyWith(profileUpdateCurrentPage: currentPage));
  // }

  bool get goIrl => state.goIrl;
  set goIrl(bool goIrl) {
    emit(state.copyWith(goIrl: goIrl));
  }

  Irl? get irl => state.irl;
  set irl(Irl? irl) {
    emit(state.copyWith(irl: irl));
  }

  Irl? get irlPreLoad => state.irlPreLoad;
  set irlPreLoad(Irl? irlPreLoad) {
    emit(state.copyWith(irlPreLoad: irlPreLoad));
  }
}
