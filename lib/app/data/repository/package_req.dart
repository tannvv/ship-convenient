import 'package:convenient_way/app/data/models/suggest_package_model.dart';

abstract class PackageReq {
  Future<List<SuggestPackage>> getSuggestPackage(String shipperId);
}
