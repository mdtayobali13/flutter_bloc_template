import 'package:equatable/equatable.dart';

enum AboutUsStatus { initial, loading, success, error }

class AboutUsState extends Equatable {
  final AboutUsStatus status;
  final String data;
  final String? errorMessage;

  const AboutUsState({
    this.status = AboutUsStatus.initial,
    this.data = "",
    this.errorMessage,
  });

  bool get isLoading => status == AboutUsStatus.loading;
  bool get isSuccess => status == AboutUsStatus.success;
  bool get isError => status == AboutUsStatus.error;

  AboutUsState copyWith({
    AboutUsStatus? status,
    String? data,
    String? errorMessage,
  }) {
    return AboutUsState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, data, errorMessage];
}
