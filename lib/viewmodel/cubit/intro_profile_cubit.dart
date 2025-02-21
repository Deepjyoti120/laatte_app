import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'intro_profile_state.dart';

class IntroProfileCubit extends Cubit<IntroProfileState> {
  IntroProfileCubit() : super(IntroProfileInitial());
}
