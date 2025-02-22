part of 'intro_profile_cubit.dart';

sealed class IntroProfileState extends Equatable {
  final int currentPage;
  final GenderTypes gender;
  final DateTime? dateOfBirth;

  const IntroProfileState(
      {this.currentPage = 0, this.gender = GenderTypes.male, this.dateOfBirth});

  @override
  List<Object?> get props => [currentPage, gender, dateOfBirth];
}

final class IntroProfileInitial extends IntroProfileState {
  const IntroProfileInitial(
      {super.currentPage, super.gender, super.dateOfBirth});

  IntroProfileInitial copyWith(
      {int? currentPage, GenderTypes? gender, DateTime? dateOfBirth}) {
    return IntroProfileInitial(
      currentPage: currentPage ?? this.currentPage,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }
}
