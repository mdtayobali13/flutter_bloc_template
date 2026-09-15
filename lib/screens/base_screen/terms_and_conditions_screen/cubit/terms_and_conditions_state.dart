import 'package:equatable/equatable.dart';

enum TermsAndConditionsStatus { initial, loading, success, error }

class TermsAndConditionsState extends Equatable {
  final TermsAndConditionsStatus status;
  final String data;
  final String? errorMessage;

  const TermsAndConditionsState({
    this.status = TermsAndConditionsStatus.initial,
    this.data = "",
    this.errorMessage,
  });

  bool get isLoading => status == TermsAndConditionsStatus.loading;
  bool get isSuccess => status == TermsAndConditionsStatus.success;
  bool get isError => status == TermsAndConditionsStatus.error;

  TermsAndConditionsState copyWith({
    TermsAndConditionsStatus? status,
    String? data,
    String? errorMessage,
  }) {
    return TermsAndConditionsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
