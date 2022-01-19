import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:routeam_test/models/repo.dart';
import 'package:routeam_test/util/env.dart';

List<dynamic> filteredNames = [];

class RepoProvider {
  Future<List<Repo>> getRepo(id, pageNum) async {
    var urlString;

    Map<String, dynamic> queryParameters = {
      'q': id,
      'per_page': pageNum,
    };

    urlString = Uri.http(url, '/search/repositories', queryParameters.map((key, value) => MapEntry(key, value.toString())));

    final response = await http.get(urlString);

    if (response.statusCode == 200) {
      final List<dynamic> filteredNames = jsonDecode(response.body)['items'];
      return filteredNames.map((json) => Repo.fromJson(json)).toList();
    } else {
      throw Exception('Error fetching repos');
    }
  }
}
