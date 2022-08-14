import 'dart:async';

import 'package:filmdb_project/providers/movies_provider.dart';
import 'package:filmdb_project/utils/widget_util.dart';
import 'package:filmdb_project/widgets/movies_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final bool? isMovies;
  const SearchScreen({Key? key, this.isMovies = true}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MoviesNotifier>().resetSearch();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<MoviesNotifier>().resetSearch();
      context.read<MoviesNotifier>().getSearchedMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = context.select((MoviesNotifier n) => n.searchedMovies);
    final loading = context.select((MoviesNotifier n) => n.loadSearch);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        automaticallyImplyLeading: true,
        title: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          height: 40,
          child: Center(
            child: TextField(
              controller: controller,
              onChanged: _onSearchChanged,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search Movies...',
                  border: InputBorder.none),
            ),
          ),
        ),
      ),
      body: Center(
        child: loading!
            ? customLoading()
            : SingleChildScrollView(
                child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    physics: const ScrollPhysics(),
                    itemCount: movies!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            childAspectRatio: 80 / 125),
                    itemBuilder: (context, i) {
                      return MoviesCard(
                        data: movies[i],
                      );
                    }),
              ),
      ),
    );
  }
}
