import 'package:equatable/equatable.dart';

enum PrivacyPolicyStatus { initial, loading, success, error }

class PrivacyPolicyState extends Equatable {
  final PrivacyPolicyStatus status;
  final String data;
  final String? errorMessage;

  const PrivacyPolicyState({
    this.status = PrivacyPolicyStatus.initial,
    this.data = "",
    this.errorMessage,
  });

  bool get isLoading => status == PrivacyPolicyStatus.loading;
  bool get isSuccess => status == PrivacyPolicyStatus.success;
  bool get isError => status == PrivacyPolicyStatus.error;

  PrivacyPolicyState copyWith({
    PrivacyPolicyStatus? status,
    String? data,
    String? errorMessage,
  }) {
    return PrivacyPolicyState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
