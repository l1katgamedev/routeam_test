abstract class RepoEvent {}

class RepoLoadEvent extends RepoEvent {
  final dynamic id;
  final dynamic pageNum;

  RepoLoadEvent(this.id, this.pageNum);
}

