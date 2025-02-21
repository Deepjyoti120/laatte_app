class IntroProfile {
  int currentPage;
  String gender;

  IntroProfile({
    this.currentPage = 0,
    this.gender = "Male",
  });
  IntroProfile copyWith({int? currentPage, String? gender}) {
    return IntroProfile(
      currentPage: currentPage ?? this.currentPage,
      gender: gender ?? this.gender,
    );
  }
}
