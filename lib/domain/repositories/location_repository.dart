import 'package:sukientotapp/data/models/location_model.dart';

abstract class LocationRepository {
  Future<List<LocationModel>> getProvinces();
  Future<List<LocationModel>> getWards(int provinceId);
}
