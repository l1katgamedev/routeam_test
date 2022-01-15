
abstract class RepoState {}

class  RepoInitialState extends RepoState{}

class RepoLoadingState extends RepoState {}

class RepoLoadedState extends RepoState {
  List<dynamic> loadedRepos;

  RepoLoadedState({
    required this.loadedRepos
  });
}

class RepoErrorState extends RepoState {}
