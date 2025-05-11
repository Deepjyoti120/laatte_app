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
  final Irl? irl;
  final Irl? irlPreLoad;
  // final List<String> activeCards;
  final BasicInfo? basicInfo;

  AppStateInitial({
    this.currentPage = 0,
    this.isDarkMode = false,
    this.isSystemDarkMode = true,
    this.isOpenDrawer = true,
    this.goIrl = false,
    this.userReport,
    // this.activeCards = const [],
    this.basicInfo,
    this.irl,
    this.irlPreLoad,
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
    Irl? irl, 
    Irl? irlPreLoad,
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
      irl: irl ?? this.irl,
      irlPreLoad: irlPreLoad ?? this.irlPreLoad,
    );
  }
}
