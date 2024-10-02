import 'package:gallery_app/api/api_client.dart';
import 'package:gallery_app/api/constants/api.dart';
import 'package:gallery_app/feautes/gallery/models/hit.dart';

class PixabayService {
  final ApiClient apiClient = ApiClient();

  Future<List<Hit>> getHits({
    int page = 1,
    int perPage = 20,
    String? searchQuery,
  }) async {
    final queryParameters = {
      'page': page,
      'per_page': perPage,
      'key': Api.pixabayApiKey,
      if (searchQuery != null) 'q': searchQuery,
    };

    final response = await apiClient.get(
      '${Api.proxyUrl}${Api.baseUrl}/',
      data: queryParameters,
    );

    List<dynamic> results = response.data['hits'];
    return results.map((hit) => Hit.fromJson(hit)).toList();
  }
}
