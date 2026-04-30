class HomeServiceItem {
  final String name;
  final String icon; // SVG asset path
  final String? iconPng; // Fallback PNG asset path
  final String? routeName; // Optional named route for navigation

  const HomeServiceItem({
    required this.name,
    required this.icon,
    this.iconPng,
    this.routeName,
  });
}
