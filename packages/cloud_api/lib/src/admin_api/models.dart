import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class AdminLoginResponse {
  final Claims claims;
  final String token;

  AdminLoginResponse({required this.token, required this.claims});

  factory AdminLoginResponse.fromJson(Map<String, dynamic> json) => _$AdminLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AdminLoginResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class Claims {
  final String username;
  final int isu;
  final int exp;

  Claims({required this.username, required this.isu, required this.exp});

  factory Claims.fromJson(Map<String, dynamic> json) => _$ClaimsFromJson(json);
  Map<String, dynamic> toJson() => _$ClaimsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class OrganizationResponse {
  final List<OrganizationResponseModel> data;

  OrganizationResponse({required this.data});

  factory OrganizationResponse.fromJson(Map<String, dynamic> json) => _$OrganizationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrganizationResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class OrganizationResponseModel {
  final String id;
  final String name;
  final String fullName;
  final String? country;
  final String? bookBegin;
  final String? gstNo;
  final int? fpCode;
  final String? status;
  final String? planType;
  final int branch;
  final int posCounter;
  final int voucher;
  final String? expiry;
  final int? serialNo;
  final String? serialKey;
  final String? diskSerial;
  final String ownedBy;
  final String? createdAt;
  final String? updatedAt;

  OrganizationResponseModel({
    required this.id,
    required this.name,
    required this.fullName,
    this.country,
    this.bookBegin,
    this.gstNo,
    this.fpCode,
    this.status,
    this.planType,
    required this.branch,
    required this.posCounter,
    required this.voucher,
    this.expiry,
    this.serialNo,
    this.serialKey,
    this.diskSerial,
    required this.ownedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory OrganizationResponseModel.fromJson(Map<String, dynamic> json) => _$OrganizationResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrganizationResponseModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class OrganizationCreateRequest {
  final String name;
  final String fullName;
  final String country;
  final String bookBegin;
  final int fpCode;

  OrganizationCreateRequest({
    required this.name,
    required this.fullName,
    required this.country,
    required this.bookBegin,
    required this.fpCode,
  });

  factory OrganizationCreateRequest.fromJson(Map<String, dynamic> json) => _$OrganizationCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationCreateRequestToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
@JsonSerializable()
class OrganizationCreateResponse {
  final String message;

  OrganizationCreateResponse({required this.message});

  factory OrganizationCreateResponse.fromJson(Map<String, dynamic> json) => _$OrganizationCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationCreateResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterRequest {
  String id;
  int serialNo;
  String serialKey;

  RegisterRequest({required this.id, required this.serialNo, required this.serialKey});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class RegisterResponse {
  final String message;

  RegisterResponse({required this.message});
  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class ValidateResponse {
  final String message;

  ValidateResponse({required this.message});

  factory ValidateResponse.fromJson(Map<String, dynamic> json) => _$ValidateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ValidateResponseToJson(this);
}
