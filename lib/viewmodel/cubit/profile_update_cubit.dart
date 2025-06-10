import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:laatte/common_libs.dart';
import 'package:laatte/utils/enums.dart';
import 'package:laatte/viewmodel/model/file_link_pair.dart';
import 'package:laatte/viewmodel/model/user_reports.dart';
part 'profile_update_state.dart';

class ProfileUpdateCubit extends Cubit<ProfileUpdateInitial> {
  ProfileUpdateCubit() : super(const ProfileUpdateInitial());
  final PageController _controller = PageController();
  PageController get controller => _controller;

  int get currentPage => state.currentPage;
  set currentPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  GenderTypes get gender => state.gender;
  set gender(GenderTypes gender) {
    emit(state.copyWith(gender: gender));
  }

  DateTime? get dateOfBirth => state.dateOfBirth;
  set dateOfBirth(DateTime? dateOfBirth) {
    emit(state.copyWith(dateOfBirth: dateOfBirth));
  }

  final TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  final TextEditingController _occupation = TextEditingController();
  TextEditingController get occupation => _occupation;

  final TextEditingController _education = TextEditingController();
  TextEditingController get education => _education;

  final TextEditingController _bio = TextEditingController();
  TextEditingController get bio => _bio;

  List<FileLinkPair?> get photos => state.photos;

  void addPhoto(FileLinkPair photo) {
    final updatedPhotos = List<FileLinkPair?>.from(state.photos)..add(photo);
    emit(state.copyWith(photos: updatedPhotos));
  }

  // void photoAddIndex(File photo, int index) {
  //   final updatedPhotos = List<File?>.from(state.photos)..[index] = photo;
  //   emit(state.copyWith(photos: updatedPhotos));
  // }
  void removePhoto(FileLinkPair photo) {
    final updatedPhotos = List<FileLinkPair?>.from(state.photos)..remove(photo);
    emit(state.copyWith(photos: updatedPhotos));
  }

  // void setPhotoNull(int index) {
  //   final updatedPhotos = List<File?>.from(state.photos)..[index] = null;
  //   emit(state.copyWith(photos: updatedPhotos));
  // }
  void clearPhotos() {
    emit(state.copyWith(photos: []));
  }

  void clear() {
    currentPage = 0;
    name.clear();
    occupation.clear();
    education.clear();
    bio.clear();
    clearPhotos();
    dateOfBirth = null;
  }

  void setUpdateData(UserReport? userReport) {
    if (userReport == null) return;
    name.text = userReport.name ?? '';
    occupation.text = userReport.occupation ?? '';
    education.text = userReport.education ?? '';
    bio.text = userReport.bio ?? '';
    dateOfBirth = DateTime.parse(userReport.dob!);
  }
}
