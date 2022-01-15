abstract class RepoEvent {}

class RepoLoadEvent extends RepoEvent {
  final dynamic id;

  RepoLoadEvent(this.id);
}

