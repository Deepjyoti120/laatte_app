part of 'intro_profile_cubit.dart';

sealed class IntroProfileState extends Equatable {
  final int currentPage;
  final GenderTypes gender;

  const IntroProfileState(
      {this.currentPage = 0, this.gender = GenderTypes.male});

  @override
  List<Object> get props => [currentPage, gender ?? ''];
}

final class IntroProfileInitial extends IntroProfileState {
  const IntroProfileInitial({super.currentPage, super.gender});

  IntroProfileInitial copyWith({int? currentPage, GenderTypes? gender}) {
    return IntroProfileInitial(
      currentPage: currentPage ?? this.currentPage,
      gender: gender ?? this.gender,
    );
  }
}
