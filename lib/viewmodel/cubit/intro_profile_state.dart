part of 'intro_profile_cubit.dart';

sealed class IntroProfileState extends Equatable {
  final int currentPage;
  final GenderTypes gender;
  final DateTime? dateOfBirth;
  final List<File?> photos;

  const IntroProfileState({
    this.currentPage = 0,
    this.gender = GenderTypes.male,
    this.dateOfBirth,
    this.photos = const [],
  });

  @override
  List<Object?> get props => [currentPage, gender, dateOfBirth, photos];
}

final class IntroProfileInitial extends IntroProfileState {
  const IntroProfileInitial(
      {super.currentPage, super.gender, super.dateOfBirth, super.photos});

  IntroProfileInitial copyWith(
      {int? currentPage,
      GenderTypes? gender,
      DateTime? dateOfBirth,
      List<File?>? photos}) {
    return IntroProfileInitial(
      currentPage: currentPage ?? this.currentPage,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photos: photos ?? this.photos,
    );
  }
}
