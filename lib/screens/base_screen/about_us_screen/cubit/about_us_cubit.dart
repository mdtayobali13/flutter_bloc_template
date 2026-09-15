import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/screens/base_screen/about_us_screen/cubit/about_us_state.dart';
import 'package:flutter_bloc_template/services/repository/base_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to fetch and manage About Us content
class AboutUsCubit extends Cubit<AboutUsState> {
  final BaseRepository _repo = BaseRepository.instance;

  AboutUsCubit() : super(const AboutUsState(status: AboutUsStatus.loading)) {
    loadAboutUs();
  }

  Future<void> loadAboutUs() async {
    try {
      emit(state.copyWith(status: AboutUsStatus.loading));
      final response = await _repo.aboutUs();
      emit(state.copyWith(status: AboutUsStatus.success, data: response));
    } catch (e) {
      errorLog("AboutUsCubit.loadAboutUs", e);
      emit(state.copyWith(status: AboutUsStatus.error, errorMessage: e.toString()));
    }
  }
}
