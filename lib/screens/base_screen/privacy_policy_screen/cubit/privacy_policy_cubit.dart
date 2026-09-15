import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/screens/base_screen/privacy_policy_screen/cubit/privacy_policy_state.dart';
import 'package:flutter_bloc_template/services/repository/base_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to fetch and manage Privacy Policy content
class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final BaseRepository _repo = BaseRepository.instance;

  PrivacyPolicyCubit() : super(const PrivacyPolicyState(status: PrivacyPolicyStatus.loading)) {
    loadPrivacyPolicy();
  }

  Future<void> loadPrivacyPolicy() async {
    try {
      emit(state.copyWith(status: PrivacyPolicyStatus.loading));
      final response = await _repo.privacyPolicy();
      emit(state.copyWith(status: PrivacyPolicyStatus.success, data: response));
    } catch (e) {
      errorLog("PrivacyPolicyCubit.loadPrivacyPolicy", e);
      emit(state.copyWith(status: PrivacyPolicyStatus.error, errorMessage: e.toString()));
    }
  }
}
