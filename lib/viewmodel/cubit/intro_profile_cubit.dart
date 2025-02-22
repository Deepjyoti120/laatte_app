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
}
