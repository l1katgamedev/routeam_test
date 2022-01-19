import 'dart:developer';

import 'package:routeam_test/models/repo.dart';
import 'package:routeam_test/services/repo_api_service.dart';

class Repos{
  final RepoProvider _reposProvider = RepoProvider();
  Future<List<Repo>> getAllRepos(id, pageNum)  {
    log(_reposProvider.getRepo(id, pageNum).toString());
    return _reposProvider.getRepo(id, pageNum);
  }
}