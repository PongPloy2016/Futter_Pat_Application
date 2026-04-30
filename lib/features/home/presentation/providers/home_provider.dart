import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/home_service_item.dart';
import '../../domain/entities/home_news_item.dart';
import '../../domain/usecases/get_home_services_usecase.dart';
import '../../domain/usecases/get_home_news_usecase.dart';

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

class HomeNotifier extends StateNotifier<HomeState> {
  final GetHomeServicesUseCase getHomeServicesUseCase;
  final GetHomeNewsUseCase getHomeNewsUseCase;

  HomeNotifier(this.getHomeServicesUseCase, this.getHomeNewsUseCase)
    : super(HomeState()) {
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    state = state.copyWith(isLoading: true);
    final services = await getHomeServicesUseCase.execute();
    final news = await getHomeNewsUseCase.execute();

    state = state.copyWith(
      services: services,
      newsItems: news,
      isLoading: false,
    );
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(sl<GetHomeServicesUseCase>(), sl<GetHomeNewsUseCase>());
});
