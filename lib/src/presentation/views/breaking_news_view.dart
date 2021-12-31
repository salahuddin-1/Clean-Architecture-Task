import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/entities/article.dart';
import '../blocs/remote_articles/remote_articles_bloc.dart';

class BreakingNewsView extends HookWidget {
  const BreakingNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {});
      return scrollController.dispose;
    }, [scrollController]);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(scrollController),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "Daily News",
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Builder(
          builder: (context) => GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Ionicons.bookmark,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(ScrollController scrollController) {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: Text('Loading ...'));
        }

        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Ionicons.refresh));
        }

        if (state is RemoteArticlesDone) {
          return _buildArticle(
            scrollController,
            state.articles!,
            state.noMoreData!,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildArticle(
    ScrollController scrollController,
    List<Article> articles,
    bool noMoreData,
  ) {
    return ListView(
      controller: scrollController,
      children: [
        ...List<Widget>.from(
          articles.map(
            (e) => Builder(
              builder: (context) => Text(e.toString()),
            ),
          ),
        ),
      ],
    );
  }
}
