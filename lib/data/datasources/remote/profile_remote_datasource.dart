import '../../apiservice/constat_endpoint.dart';
import '../../models/profile_response.dart';
import '../../apiservice/http_service.dart';
import '../../apiservice/response_parser.dart';

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
    final response = await client.requestWithToken(
      method: 'GET',
      url: Endpoints.getProfile,
    );
    return responseParser.parseResponse<ProfileResponse>(
        response, (json) => ProfileResponse.fromJson(json));
  }
}
