import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routeam_test/bloc/repo_event.dart';
import 'package:routeam_test/bloc/repo_state.dart';
import 'package:routeam_test/models/repo.dart';
import 'package:routeam_test/services/repository.dart';

class RepoBloc extends Bloc<RepoEvent, RepoState> {
  final Repos repo;

  RepoBloc(this.repo) : super(RepoInitialState());

  RepoState get initialState => RepoInitialState();

  @override
  Stream<RepoState> mapEventToState(RepoEvent event) async* {
    if (event is RepoLoadEvent) {
      yield RepoLoadingState();
      try {
        final List<Repo> _loadedReposList = await repo.getAllRepos(event.id, event.pageNum);

        yield RepoLoadedState(loadedRepos: _loadedReposList);
      } catch (_) {
        yield RepoErrorState();
      }
    }
  }
}
