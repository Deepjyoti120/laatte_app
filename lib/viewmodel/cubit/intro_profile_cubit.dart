import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../utils/enums.dart';
part 'intro_profile_state.dart';

class IntroProfileCubit extends Cubit<IntroProfileInitial> {
  IntroProfileCubit() : super(const IntroProfileInitial());

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

  List<File?> get photos => state.photos;

  void addPhoto(File photo) {
    final updatedPhotos = List<File?>.from(state.photos)..add(photo);
    emit(state.copyWith(photos: updatedPhotos));
  }

  // void photoAddIndex(File photo, int index) {
  //   final updatedPhotos = List<File?>.from(state.photos)..[index] = photo;
  //   emit(state.copyWith(photos: updatedPhotos));
  // }
  void removePhoto(File photo) {
    final updatedPhotos = List<File?>.from(state.photos)..remove(photo);
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
    photos.clear();
    dateOfBirth = null;
  }
}
