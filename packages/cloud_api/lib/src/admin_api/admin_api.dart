import 'package:result_dart/result_dart.dart';
import '../api_base.dart';
import '../admin_api/admin_api.dart';
export './models.dart';

class Api extends ApiBase {
  Api({required String basePath}) : super(basePath: '$basePath/manage');

  AsyncResult<AdminLoginResponse> adminLogin(String userId, String password) {
    return post('/super_user_login', {
      'root_user': userId,
      'root_pass': password,
    }).map((e) => AdminLoginResponse.fromJson(e as Map<String, dynamic>));
  }

  AsyncResult<List<OrganizationResponseModel>> organizationList() {
    return post('/list_organization', {}).map((e) {
      final list = e as List<dynamic>;
      return list.map((item) => OrganizationResponseModel.fromJson(item)).toList();
    });
  }

  AsyncResult<OrganizationCreateResponse> createOrganization(OrganizationCreateRequest req) {
    return post('/organization_init', {
      'name': req.name,
      'full_name': req.fullName,
      'country': req.country,
      'book_begin': req.bookBegin,
      'fp_code': req.fpCode,
    }).map((e) => OrganizationCreateResponse.fromJson(e as Map<String, dynamic>));
  }

  AsyncResult<RegisterResponse> register(RegisterRequest data) {
    return post(
      '/organization_registration',
      data.toJson(),
    ).map((e) => RegisterResponse.fromJson(e as Map<String, dynamic>));
  }

  AsyncResult<ValidateResponse> validateLicence(String id) {
    return post('/verify_license', {'id': id}).map((e) => ValidateResponse.fromJson(e as Map<String, dynamic>));
  }
}
