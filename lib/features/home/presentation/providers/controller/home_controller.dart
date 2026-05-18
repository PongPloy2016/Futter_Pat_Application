import 'package:riverpod/riverpod.dart';

import '../../../../../core/di/injection.dart';
import '../../../domain/usecases/get_home_news_usecase.dart';
import '../../../domain/usecases/get_home_services_usecase.dart';
import '../state/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  final GetHomeServicesUseCase getHomeServicesUseCase;
  final GetHomeNewsUseCase getHomeNewsUseCase;

  HomeController(this.getHomeServicesUseCase, this.getHomeNewsUseCase)
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

final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(sl<GetHomeServicesUseCase>(), sl<GetHomeNewsUseCase>());
});
