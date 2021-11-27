import 'package:get/get.dart';
import 'package:flutter_rss_lecture/src/api/news_api.dart';


class NewsController extends GetxController {
  var news = [].obs;
  var isLoaded = false.obs;
  var isError = false.obs;
  final LentaRssApi _newsProvider = LentaLastNewsProvider();

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  Future<void> loadNews() async{
    try{
      news.value = await _newsProvider.getNews();
      isLoaded.value = true;
    } on RssNewsException {
      isError.value = true;
    }

  }

  Future<void> reloadNews() async{
    isLoaded.value = false;
    onInit();
  }

}