import '../../domain/entities/home_service_item.dart';
import '../../domain/repositories/home_repository.dart';

class GetHomeServicesUseCase {
  final HomeRepository repository;

  GetHomeServicesUseCase(this.repository);

  Future<List<HomeServiceItem>> execute() {
    return repository.getHomeServices();
  }
}
