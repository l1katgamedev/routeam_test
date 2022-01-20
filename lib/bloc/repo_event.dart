abstract class RepoEvent {}

class RepoLoadEvent extends RepoEvent {
  final dynamic id;
  final dynamic repoCount;
  final dynamic pageNum;


  RepoLoadEvent(this.id, this.repoCount, this.pageNum);
}
