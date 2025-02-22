part of 'intro_profile_cubit.dart';

sealed class IntroProfileState extends Equatable {
  final int currentPage;
  // final TextEditingController? name;
  final GenderTypes gender;
  final DateTime? dateOfBirth;

  const IntroProfileState(
      {this.currentPage = 0,
      this.gender = GenderTypes.male,
      this.dateOfBirth,
      // this.name
      });

  @override
  List<Object?> get props => [currentPage, gender, dateOfBirth];
}

final class IntroProfileInitial extends IntroProfileState {
  const IntroProfileInitial(
      {super.currentPage, super.gender, super.dateOfBirth});

  IntroProfileInitial copyWith(
      {int? currentPage,
      GenderTypes? gender,
      DateTime? dateOfBirth,
      TextEditingController? name}) {
    return IntroProfileInitial(
      currentPage: currentPage ?? this.currentPage,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      // name: name ?? this.name,
    );
  }
}
