import 'package:sukientotapp/data/models/location_model.dart';
import 'package:sukientotapp/data/providers/location_provider.dart';
import 'package:sukientotapp/domain/repositories/location_repository.dart';
import 'package:sukientotapp/core/utils/logger.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationProvider _provider;

  LocationRepositoryImpl(this._provider);

  @override
  Future<List<LocationModel>> getProvinces() async {
    try {
      final rawData = await _provider.getProvinces();
      return rawData
          .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e('[LocationRepositoryImpl] [getProvinces] Error: $e');
      rethrow;
    }
  }

  @override
  Future<List<LocationModel>> getWards(int provinceId) async {
    try {
      final rawData = await _provider.getWards(provinceId);
      return rawData
          .map((json) => LocationModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      logger.e(
        '[LocationRepositoryImpl] [getWards] Error fetching wards for province $provinceId: $e',
      );
      rethrow;
    }
  }
}
