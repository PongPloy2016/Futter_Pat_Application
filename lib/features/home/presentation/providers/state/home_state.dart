import '../../../domain/entities/home_news_item.dart';
import '../../../domain/entities/home_service_item.dart';

class HomeState {
  final List<HomeServiceItem> services;
  final List<HomeNewsItem> newsItems;
  final bool isLoading;

  HomeState({
    this.services = const [],
    this.newsItems = const [],
    this.isLoading = false,
  });

  HomeState copyWith({
    List<HomeServiceItem>? services,
    List<HomeNewsItem>? newsItems,
    bool? isLoading,
  }) {
    return HomeState(
      services: services ?? this.services,
      newsItems: newsItems ?? this.newsItems,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}