import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routeam_test/bloc/repos.dart';
import 'package:routeam_test/models/repo.dart';
import 'package:routeam_test/ui/screens/webview.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget searchTitle = Text('Github');
  final TextEditingController _filter = TextEditingController(text: '');
  bool _validate = false;
  List<dynamic> dropdownValue = [10, 20, 30, 50];

  @override
  void initState() {
    RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: searchTitle,
            centerTitle: true,
            backgroundColor: const Color(0xFF2D333B),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      cursorColor: Colors.white,
                      controller: _filter,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      onSubmitted: (String value) {
                        setState(() {
                          if (_filter.text.length > 3) {
                            RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
                            bloc.add(RepoLoadEvent(_filter.text));
                          }
                        });
                        setState(() {
                          _filter.text.length < 3
                              ? _validate = true
                              : _validate = false;
                        });
                      },
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        fillColor: Color(0xFF1C2128),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF444C56),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF539BD5), width: 2.0),
                        ),
                        filled: true,
                        alignLabelWithHint: true,
                        errorText:
                            _validate ? 'Write more than 3 letters' : null,
                        hintText: 'Find a repository...',
                        hintStyle: TextStyle(
                          color: Color(0xFF545D68),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<RepoBloc, RepoState>(
                  builder: (context, state) {
                    if (state is RepoLoadedState) {
                      return Expanded(
                        child: ReorderableListView.builder(
                          itemCount: state.loadedRepos.length,
                          onReorder: (oldIndex, newIndex) => setState(() {
                            final index =
                                newIndex > oldIndex ? newIndex - 1 : newIndex;
                            final item = state.loadedRepos.removeAt(oldIndex);
                            state.loadedRepos.insert(index, item);
                          }),
                          itemBuilder: (BuildContext ctx, int index) {
                            var item = state.loadedRepos[index];
                            return Padding(
                              key: ValueKey(item),
                              padding: const EdgeInsets.all(12),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return WebViewPage(
                                      name: item.name,
                                      html: item.html,
                                    );
                                  }));
                                },
                                child: Card(
                                  color: const Color(0xFF2D333B),
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xFF444C56), width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 4),
                                              child: Text(
                                                item.name ?? 'Ther is no name',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF539BD5)),
                                              )),
                                          subtitle: Text(
                                            item.description ??
                                                "There is no description",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star_border_outlined,
                                                color: Color(0xFFFFFAA0),
                                              ),
                                              SizedBox(
                                                width: 0,
                                              ),
                                              Text(
                                                item.stargazers.toString() ??
                                                    '0',
                                                style: TextStyle(
                                                  color: Color(0xFFFFFAA0),
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Icon(
                                                Icons.person_outline_outlined,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                  item.watchers.toString() ??
                                                      '0',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  )),
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Text(
                                                  item.language ??
                                                      'No language',
                                                  style: TextStyle(
                                                    color: Color(0xFF539BD5),
                                                    fontSize: 16,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    if (state is RepoLoadingState) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.red,
                      ));
                    }

                    if (state is RepoErrorState) {
                      return const SizedBox(
                        height: 500,
                        child: Center(
                            child: Text(
                          'Something went wrong',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      );
                    }

                    return Text('');
                  },
                ),
              ],
            ),
          )),
    );
  }
}
