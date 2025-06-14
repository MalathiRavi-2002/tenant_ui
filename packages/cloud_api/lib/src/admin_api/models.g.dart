// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminLoginResponse _$AdminLoginResponseFromJson(Map<String, dynamic> json) =>
    AdminLoginResponse(
      token: json['token'] as String,
      claims: Claims.fromJson(json['claims'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdminLoginResponseToJson(AdminLoginResponse instance) =>
    <String, dynamic>{'claims': instance.claims, 'token': instance.token};

Claims _$ClaimsFromJson(Map<String, dynamic> json) => Claims(
  username: json['username'] as String,
  isu: (json['isu'] as num).toInt(),
  exp: (json['exp'] as num).toInt(),
);

Map<String, dynamic> _$ClaimsToJson(Claims instance) => <String, dynamic>{
  'username': instance.username,
  'isu': instance.isu,
  'exp': instance.exp,
};

OrganizationResponse _$OrganizationResponseFromJson(
  Map<String, dynamic> json,
) => OrganizationResponse(
  data:
      (json['data'] as List<dynamic>)
          .map(
            (e) =>
                OrganizationResponseModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$OrganizationResponseToJson(
  OrganizationResponse instance,
) => <String, dynamic>{'data': instance.data};

OrganizationResponseModel _$OrganizationResponseModelFromJson(
  Map<String, dynamic> json,
) => OrganizationResponseModel(
  id: json['id'] as String,
  name: json['name'] as String,
  fullName: json['full_name'] as String,
  country: json['country'] as String?,
  bookBegin: json['book_begin'] as String?,
  gstNo: json['gst_no'] as String?,
  fpCode: (json['fp_code'] as num?)?.toInt(),
  status: json['status'] as String?,
  planType: json['plan_type'] as String?,
  branch: (json['branch'] as num).toInt(),
  posCounter: (json['pos_counter'] as num).toInt(),
  voucher: (json['voucher'] as num).toInt(),
  expiry: json['expiry'] as String?,
  serialNo: (json['serial_no'] as num?)?.toInt(),
  serialKey: json['serial_key'] as String?,
  diskSerial: json['disk_serial'] as String?,
  ownedBy: json['owned_by'] as String,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$OrganizationResponseModelToJson(
  OrganizationResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'full_name': instance.fullName,
  'country': instance.country,
  'book_begin': instance.bookBegin,
  'gst_no': instance.gstNo,
  'fp_code': instance.fpCode,
  'status': instance.status,
  'plan_type': instance.planType,
  'branch': instance.branch,
  'pos_counter': instance.posCounter,
  'voucher': instance.voucher,
  'expiry': instance.expiry,
  'serial_no': instance.serialNo,
  'serial_key': instance.serialKey,
  'disk_serial': instance.diskSerial,
  'owned_by': instance.ownedBy,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

OrganizationCreateRequest _$OrganizationCreateRequestFromJson(
  Map<String, dynamic> json,
) => OrganizationCreateRequest(
  name: json['name'] as String,
  fullName: json['full_name'] as String,
  country: json['country'] as String,
  bookBegin: json['book_begin'] as String,
  fpCode: (json['fp_code'] as num).toInt(),
  gstNo: json['gst_no'] as String?,
);

Map<String, dynamic> _$OrganizationCreateRequestToJson(
  OrganizationCreateRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'full_name': instance.fullName,
  'country': instance.country,
  'book_begin': instance.bookBegin,
  'gst_no': instance.gstNo,
  'fp_code': instance.fpCode,
};

OrganizationCreateResponse _$OrganizationCreateResponseFromJson(
  Map<String, dynamic> json,
) => OrganizationCreateResponse(message: json['message'] as String);

Map<String, dynamic> _$OrganizationCreateResponseToJson(
  OrganizationCreateResponse instance,
) => <String, dynamic>{'message': instance.message};

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      id: json['id'] as String,
      serialNo: (json['serial_no'] as num).toInt(),
      serialKey: json['serial_key'] as String,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serial_no': instance.serialNo,
      'serial_key': instance.serialKey,
    };

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(message: json['message'] as String);

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{'message': instance.message};

ValidateResponse _$ValidateResponseFromJson(Map<String, dynamic> json) =>
    ValidateResponse(message: json['message'] as String);

Map<String, dynamic> _$ValidateResponseToJson(ValidateResponse instance) =>
    <String, dynamic>{'message': instance.message};
