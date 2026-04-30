import '../../domain/entities/home_service_item.dart';

class HomeServiceItemModel extends HomeServiceItem {
  const HomeServiceItemModel({
    required super.name,
    required super.icon,
    super.iconPng,
    super.routeName,
  });

  factory HomeServiceItemModel.fromJson(Map<String, dynamic> json) {
    return HomeServiceItemModel(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      iconPng: json['iconPng'],
      routeName: json['routeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'iconPng': iconPng,
      'routeName': routeName,
    };
  }
}
