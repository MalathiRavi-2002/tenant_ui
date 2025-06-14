import 'package:result_dart/result_dart.dart';
import '../api_base.dart';
import '../admin_api/admin_api.dart';
export './models.dart';

class Api extends ApiBase {
  Api({required String basePath}) : super(basePath: '$basePath/rest/manage');

  AsyncResult<AdminLoginResponse> adminLogin(String userId, String password) {
    return post('/super_user_login', {
      'root_user': userId,
      'root_pass': password,
    }).map((e) => AdminLoginResponse.fromJson(e as Map<String, dynamic>));
  }

  AsyncResult<List<String>> organizationList() {
    return get('/list_organization', {}).map((res) {
      final list = res as List<dynamic>;
      return list.map((el) => el).toList().cast<String>();
      // return list.map((item) => OrganizationResponseModel.fromJson(item)).toList();
    });
  }

  AsyncResult<OrganizationCreateResponse> createOrganization(OrganizationCreateRequest req) {
    return post(
      '/organization_init',
      req.toJson(),
    ).map((e) => OrganizationCreateResponse.fromJson(e as Map<String, dynamic>));
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
