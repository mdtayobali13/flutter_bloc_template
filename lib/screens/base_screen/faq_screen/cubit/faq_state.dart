import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_template/screens/base_screen/faq_screen/models/f_a_q_screen_data_model.dart';

enum FaqStatus { initial, loading, success, error }

class FaqState extends Equatable {
  final FaqStatus status;
  final List<FAQScreenDataModel> data;
  final String? errorMessage;

  const FaqState({
    this.status = FaqStatus.initial,
    this.data = const [],
    this.errorMessage,
  });

  bool get isLoading => status == FaqStatus.loading;
  bool get isSuccess => status == FaqStatus.success;
  bool get isError => status == FaqStatus.error;

  FaqState copyWith({
    FaqStatus? status,
    List<FAQScreenDataModel>? data,
    String? errorMessage,
  }) {
    return FaqState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
