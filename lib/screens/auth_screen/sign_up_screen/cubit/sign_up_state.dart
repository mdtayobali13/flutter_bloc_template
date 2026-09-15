import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String idCardFrontendPart;
  final String idCardBackendPart;
  final String storeName;
  final String storeBio;
  final String storeAddress;
  final String storePhoto;
  final String kycDocument;
  final bool isLoading;
  final bool isCustomer;

  const SignUpState({
    this.confirmPassword = "",
    this.email = "",
    this.idCardBackendPart = "",
    this.idCardFrontendPart = "",
    this.isCustomer = true,
    this.isLoading = false,
    this.name = "",
    this.password = "",
    this.phoneNumber = "",
    this.storeName = "",
    this.storeBio = "",
    this.storeAddress = "",
    this.storePhoto = "",
    this.kycDocument = "",
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? idCardFrontendPart,
    String? idCardBackendPart,
    String? storeName,
    String? storeBio,
    String? storeAddress,
    String? storePhoto,
    String? kycDocument,
    bool? isLoading,
    bool? isCustomer,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      idCardFrontendPart: idCardFrontendPart ?? this.idCardFrontendPart,
      idCardBackendPart: idCardBackendPart ?? this.idCardBackendPart,
      storeName: storeName ?? this.storeName,
      storeBio: storeBio ?? this.storeBio,
      storeAddress: storeAddress ?? this.storeAddress,
      storePhoto: storePhoto ?? this.storePhoto,
      kycDocument: kycDocument ?? this.kycDocument,
      isLoading: isLoading ?? this.isLoading,
      isCustomer: isCustomer ?? this.isCustomer,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        password,
        confirmPassword,
        idCardFrontendPart,
        idCardBackendPart,
        storeName,
        storeBio,
        storeAddress,
        storePhoto,
        kycDocument,
        isLoading,
        isCustomer,
      ];
}
