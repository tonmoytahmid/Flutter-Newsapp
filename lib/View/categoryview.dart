import 'package:newspaperapp/Models/categorymodel.dart';
import 'package:newspaperapp/Reposetory/categoryrepository.dart';

class Categoryview {
  final repo = Categoryrepository();

  Future<Categorymodel?> categoryview(String name) async {
    final response = await repo.newsCategory(name);

    return response;
  }
}
