import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/cubit/faq_state.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/models/f_a_q_screen_data_model.dart';
import 'package:flutter_bloc_template/services/repository/base_repository.dart';
import 'package:flutter_bloc_template/utils/app_log.dart';

/// Cubit to fetch and toggle FAQ accordion items
class FaqCubit extends Cubit<FaqState> {
  final BaseRepository _repo = BaseRepository.instance;

  FaqCubit() : super(const FaqState(status: FaqStatus.loading)) {
    initialDataLoad();
  }

  void changeItem(int index) {
    try {
      final currentList = state.data;
      if (index < 0 || index >= currentList.length) return;

      final updatedList = List<FAQScreenDataModel>.from(
        currentList.map((e) => e.copyWith(isSelected: false)),
      );
      final currentItem = currentList[index];
      updatedList[index] = currentItem.copyWith(isSelected: !currentItem.isSelected);

      emit(state.copyWith(data: updatedList));
    } catch (e) {
      errorLog("FaqCubit.changeItem", e);
    }
  }

  Future<void> initialDataLoad() async {
    try {
      emit(state.copyWith(status: FaqStatus.loading));
      final response = await _repo.getAllFaq();
      emit(state.copyWith(status: FaqStatus.success, data: response));
    } catch (e) {
      errorLog("FaqCubit.initialDataLoad", e);
      emit(state.copyWith(status: FaqStatus.error, errorMessage: e.toString()));
    }
  }
}
