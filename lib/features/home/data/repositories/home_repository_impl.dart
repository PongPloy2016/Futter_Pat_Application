import '../../domain/entities/home_service_item.dart';
import '../../domain/entities/home_news_item.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<HomeServiceItem>> getHomeServices() async {
    return await remoteDataSource.getHomeServices();
  }

  @override
  Future<List<HomeNewsItem>> getHomeNews() async {
    return await remoteDataSource.getHomeNews();
  }
}
