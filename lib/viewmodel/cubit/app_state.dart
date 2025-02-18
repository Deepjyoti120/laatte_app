part of 'app_cubit.dart';

// @immutable
sealed class AppStateState {}

class AppStateInitial extends AppStateState {
  final int currentPage;
  final bool isDarkMode;
  final bool isSystemDarkMode;
  final bool isOpenDrawer;
  final UserReport? userReport;
  // final List<String> activeCards;
  final BasicInfo? basicInfo;

  AppStateInitial({
    this.currentPage = 0,
    this.isDarkMode = false,
    this.isSystemDarkMode = true,
    this.isOpenDrawer = true,
    this.userReport,
    // this.activeCards = const [],
    this.basicInfo,
  });

  AppStateInitial copyWith({
    int? currentPage,
    bool? isDarkMode,
    bool? isSystemDarkMode,
    bool? isOpenDrawer,
    UserReport? userReport,
    // List<String>? activeCards,
    BasicInfo? basicInfo,
  }) {
    return AppStateInitial(
      currentPage: currentPage ?? this.currentPage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSystemDarkMode: isSystemDarkMode ?? this.isSystemDarkMode,
      isOpenDrawer: isOpenDrawer ?? this.isOpenDrawer,
      userReport: userReport ?? this.userReport,
      // activeCards: activeCards ?? this.activeCards,
      basicInfo: basicInfo ?? this.basicInfo,
    );
  }
}
