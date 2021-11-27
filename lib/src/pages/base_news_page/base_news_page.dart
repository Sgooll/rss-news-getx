import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/base_news_page/news_getx/news_controller.dart';
import '../../api/news_api.dart';

abstract class BaseNewsPage extends StatelessWidget {
  final LentaRssApi _newsProvider;
  late final NewsController controller;
  BaseNewsPage({Key? key, required LentaRssApi newsProvider}):
        _newsProvider = newsProvider,
        super(key: key) {
    controller = Get.put(NewsController());
  }
  @override
  Widget build(BuildContext context) {
    return GetX<NewsController>(
      builder: (controller) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    if (controller.isLoaded.value == false) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.isLoaded.value == true) {
      return RefreshIndicator(
        child: listBuilder(context, controller),
        onRefresh: () => controller.reloadNews(),
      );
    }
    else {
      return Container();
    }
  }

Widget listBuilder(BuildContext context, controller) {
  return ListView.builder(
      itemCount: controller.news.length,
      itemBuilder: (BuildContext context, int index) {
        final item = controller.news[index];
        return buildListViewItem(item);
      });
}

Widget buildListViewItem(RssItem item);
}
