import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/screens/base_screen/terms_and_conditions_screen/cubit/terms_and_conditions_state.dart';
import 'package:flutter_bloc_template/services/repository/base_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to fetch and manage Terms and Conditions content
class TermsAndConditionsCubit extends Cubit<TermsAndConditionsState> {
  final BaseRepository _repo = BaseRepository.instance;

  TermsAndConditionsCubit() : super(const TermsAndConditionsState(status: TermsAndConditionsStatus.loading)) {
    loadTermsAndConditions();
  }

  Future<void> loadTermsAndConditions() async {
    try {
      emit(state.copyWith(status: TermsAndConditionsStatus.loading));
      final response = await _repo.termsAndConditions();
      emit(state.copyWith(status: TermsAndConditionsStatus.success, data: response));
    } catch (e) {
      errorLog("TermsAndConditionsCubit.loadTermsAndConditions", e);
      emit(state.copyWith(status: TermsAndConditionsStatus.error, errorMessage: e.toString()));
    }
  }
}
