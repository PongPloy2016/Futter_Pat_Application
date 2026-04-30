import 'package:flutter_pat_application/features/home/domain/entities/home_service_item.dart';
import 'package:flutter_pat_application/features/home/domain/entities/home_news_item.dart';

abstract class HomeRepository {
  Future<List<HomeServiceItem>> getHomeServices();
  Future<List<HomeNewsItem>> getHomeNews();
}
