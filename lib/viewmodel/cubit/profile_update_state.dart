part of 'profile_update_cubit.dart';

sealed class ProfileUpdateState extends Equatable {
  final int currentPage;
  final GenderTypes gender;
  final DateTime? dateOfBirth;
  final List<FileLinkPair?> photos;

  const ProfileUpdateState({
    this.currentPage = 0,
    this.gender = GenderTypes.male,
    this.dateOfBirth,
    this.photos = const [],
  });

  @override
  List<Object?> get props => [currentPage, gender, dateOfBirth, photos];
}

final class ProfileUpdateInitial extends ProfileUpdateState {
  const ProfileUpdateInitial(
      {super.currentPage, super.gender, super.dateOfBirth, super.photos});

  ProfileUpdateInitial copyWith({
    int? currentPage,
    GenderTypes? gender,
    DateTime? dateOfBirth,
    List<FileLinkPair?>? photos,
  }) {
    return ProfileUpdateInitial(
      currentPage: currentPage ?? this.currentPage,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photos: photos ?? this.photos,
    );
  }
}
