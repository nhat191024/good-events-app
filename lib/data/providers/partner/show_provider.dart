import 'package:sukientotapp/core/services/api_service.dart';
import 'package:sukientotapp/domain/api_url.dart';

class ShowProvider {
  final ApiService _apiService;

  ShowProvider(this._apiService);

  Future<Map<String, dynamic>> getBills({
    required String status,
    String? search,
    String dateFilter = 'all',
    String sort = 'date_asc',
    int page = 1,
    int perPage = 5,
  }) async {
    final queryParams = <String, dynamic>{
      'date_filter': dateFilter,
      'sort': sort,
      'page': page,
      'per_page': perPage,
    };

    if (search != null && search.isNotEmpty) {
      queryParams['search'] = search;
    }

    final endpoint =
        status == 'history'
            ? AppUrl.partnerBillsHistory
            : AppUrl.partnerBills(status);

    final response = await _apiService.dio.get(
      endpoint,
      queryParameters: queryParams,
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load bills for status: $status');
    }
  }
}
