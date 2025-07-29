part of 'app_cubit.dart';

// @immutable
sealed class AppStateState {}

class AppStateInitial extends AppStateState {
  final int currentPage;
  final bool isDarkMode;
  final bool isSystemDarkMode;
  final bool isOpenDrawer;
  final bool goIrl;
  final UserReport? userReport;
  final bool isIrlMode;
  final bool setIrlToNull;
  final List<Irl> irlsPreLoad;
  // final List<String> activeCards;
  final BasicInfo? basicInfo;
  final bool isAllowNotification;

  AppStateInitial({
    this.currentPage = 0,
    this.isDarkMode = false,
    this.isSystemDarkMode = true,
    this.isOpenDrawer = true,
    this.goIrl = false,
    this.userReport,
    // this.activeCards = const [],
    this.basicInfo,
    this.isIrlMode = false,
    this.setIrlToNull = false,
    this.irlsPreLoad = const [],
    this.isAllowNotification = true,
  });

  AppStateInitial copyWith({
    int? currentPage,
    bool? isDarkMode,
    bool? isSystemDarkMode,
    bool? isOpenDrawer,
    UserReport? userReport,
    // List<String>? activeCards,
    BasicInfo? basicInfo,
    bool? goIrl,
    bool? isIrlMode,
    bool? setIrlToNull,
    List<Irl>? irlsPreLoad,
    bool? isAllowNotification,
  }) {
    return AppStateInitial(
      currentPage: currentPage ?? this.currentPage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSystemDarkMode: isSystemDarkMode ?? this.isSystemDarkMode,
      isOpenDrawer: isOpenDrawer ?? this.isOpenDrawer,
      userReport: userReport ?? this.userReport,
      // activeCards: activeCards ?? this.activeCards,
      basicInfo: basicInfo ?? this.basicInfo,
      goIrl: goIrl ?? this.goIrl,
      isIrlMode: isIrlMode ?? this.isIrlMode,
      setIrlToNull: setIrlToNull ?? this.setIrlToNull,
      irlsPreLoad: irlsPreLoad ?? this.irlsPreLoad,
      isAllowNotification: isAllowNotification ?? this.isAllowNotification,
    );
  }
}
