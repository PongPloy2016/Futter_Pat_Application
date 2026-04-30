import '../../domain/entities/home_news_item.dart';

class HomeNewsItemModel extends HomeNewsItem {
  const HomeNewsItemModel({
    required super.title,
  });

  factory HomeNewsItemModel.fromJson(Map<String, dynamic> json) {
    return HomeNewsItemModel(
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}
