import '../../../common/constat_endpoint.dart';
import '../../models/profile_response.dart';
import '../http_service.dart';
import '../response_parser.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponse> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final HttpService client;
  final ResponseParser responseParser;

  ProfileRemoteDataSourceImpl(
      {required this.client, required this.responseParser});

  @override
  Future<ProfileResponse> getProfile() async {
    final response = await client.postWithToken(Endpoints.getProfile, null);
    return responseParser.parseResponse<ProfileResponse>(
        response, (json) => ProfileResponse.fromJson(json));
  }
}
