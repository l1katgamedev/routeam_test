
class Repo {
  dynamic name;
  dynamic description;
  dynamic language;
  dynamic stargazers;
  dynamic watchers;
  dynamic html;

  Repo(
      {required this.name, required this.description, required this.language, required this.stargazers, required this.watchers, required this.html});

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['full_name'],
      description: json['description'],
      language: json['language'],
      stargazers: json['stargazers_count'],
      watchers: json['watchers_count'],
      html: json['html_url'],
    );
  }
}
