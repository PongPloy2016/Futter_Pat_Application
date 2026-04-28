import 'dart:io';

final Map<String, String> corrections = {
  'features/shared/presentation/screens/login/': 'features/auth/presentation/screens/login/',
  'features/shared/presentation/screens/loginmain/': 'features/auth/presentation/screens/loginmain/',
  'features/shared/presentation/screens/mainPage/': 'features/home/presentation/screens/mainPage/',
  'features/shared/presentation/screens/bottomnavpage/': 'features/home/presentation/layout/bottomnavpage/',
  'features/shared/presentation/screens/equipmentList/': 'features/equipment/presentation/screens/equipmentList/',
  'features/shared/presentation/screens/equipmentDetail/': 'features/equipment/presentation/screens/equipmentDetail/',
  'features/shared/presentation/screens/propertyListRegistrationDetails/': 'features/property/presentation/screens/propertyListRegistrationDetails/',
  'features/shared/presentation/screens/mapingTagRfid/': 'features/mapping/presentation/screens/mapingTagRfid/',
  'features/shared/presentation/screens/notificationsPage/': 'features/notifications/presentation/screens/notificationsPage/',
  'features/shared/providers/controller/login_controller.dart': 'features/auth/providers/login_controller.dart',
  'features/shared/data/models/auth/': 'features/auth/data/models/'
};

void main() {
  print('Fixing imports...');
  final libDir = Directory('lib');
  var dartFiles = libDir.listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  for (var file in dartFiles) {
    var content = file.readAsStringSync();
    var newContent = content;
    bool changed = false;

    corrections.forEach((badImport, goodImport) {
      if (newContent.contains(badImport)) {
        newContent = newContent.replaceAll(badImport, goodImport);
        changed = true;
      }
    });

    if (changed) {
      file.writeAsStringSync(newContent);
      print('Fixed imports in: ${file.path}');
    }
  }
  print('Import fix complete!');
}
