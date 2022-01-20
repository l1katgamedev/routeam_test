import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routeam_test/bloc/repos.dart';
import 'package:routeam_test/ui/screens/webview.dart';
import 'package:routeam_test/ui/widgets/card_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget searchTitle = const Text('Github');
  final TextEditingController _filter = TextEditingController(text: '');
  bool _validate = false;
  int? dropdownValue;
  List<int> dropdownValues = [10, 25, 50];
  int? pageNum = 1;

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
                  height: 10,
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
                          if (_filter.text.length >= 3) {
                            RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
                            bloc.add(RepoLoadEvent(
                                _filter.text, pageNum, dropdownValue));
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
                        fillColor: const Color(0xFF1C2128),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF444C56),
                            width: 2,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF539BD5), width: 2.0),
                        ),
                        filled: true,
                        alignLabelWithHint: true,
                        errorText:
                            _validate ? 'Write more than 3 letters' : null,
                        hintText: 'Find a repository...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF545D68),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF545D68), width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: DropdownButton<dynamic>(
                        dropdownColor: const Color(0xFF545D68),
                        underline: Container(),
                        elevation: 20,
                        iconSize: 36.0,
                        hint: const Text(
                          'Choose',
                          style: TextStyle(color: Colors.white),
                        ),
                        value: dropdownValue,
                        items: dropdownValues.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(
                              value.toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            if (_filter.text.length >= 3) {
                              RepoBloc bloc =
                                  BlocProvider.of<RepoBloc>(context);
                              bloc.add(RepoLoadEvent(
                                  _filter.text, pageNum, newValue));
                            }
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                                child: CardWidget(item: item),
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

                    return const Text('');
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pageNum = pageNum! - 1;

                            RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
                            bloc.add(RepoLoadEvent(
                                _filter.text, pageNum, dropdownValue));
                          });
                        },
                        child: Text('nazad'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pageNum = pageNum! + 1;

                            RepoBloc bloc = BlocProvider.of<RepoBloc>(context);
                            bloc.add(RepoLoadEvent(
                                _filter.text, pageNum, dropdownValue));
                          });
                        },
                        child: Text('vpered'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
