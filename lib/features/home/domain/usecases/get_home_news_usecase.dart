import '../../domain/repositories/home_repository.dart';
import '../../domain/entities/home_news_item.dart';

class GetHomeNewsUseCase {
  final HomeRepository repository;

  GetHomeNewsUseCase(this.repository);

  Future<List<HomeNewsItem>> execute() {
    return repository.getHomeNews();
  }
}
