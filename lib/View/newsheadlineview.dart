import 'package:newspaperapp/Models/newsheadline_model.dart';
import 'package:newspaperapp/Reposetory/newsheadline_reposetory.dart';

class Newsheadlineview {
  final repo = Newsheadline_reposetory();

  Future<Newsheadline_model?> newsheadlineview() async {
    final response = await repo.newsheadlinerepo();

    return response;
  }
}