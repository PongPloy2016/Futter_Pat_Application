import 'dart:io';

final String basePath = 'lib';

final Map<String, String> dirMappings = {
  // Core
  'app_config.dart': 'core/config/app_config.dart',
  'client': 'core/network',
  'constants': 'core/constants',
  'themes': 'core/theme',
  'utils': 'core/utils',
  // Router
  'app_router.dart': 'router/app_router.dart',
  // Shared
  'widgets': 'shared/widgets',
  // Features: Auth
  'srceens/login': 'features/auth/presentation/screens/login',
  'srceens/loginmain': 'features/auth/presentation/screens/loginmain',
  'models/auth': 'features/auth/data/models',
  'provider/controller/login_controller.dart': 'features/auth/providers/login_controller.dart',
  // Features: Home
  'srceens/mainPage': 'features/home/presentation/screens/mainPage',
  'srceens/bottomnavpage': 'features/home/presentation/layout/bottomnavpage',
  // Features: Equipment
  'srceens/equipmentList': 'features/equipment/presentation/screens/equipmentList',
  'srceens/equipmentDetail': 'features/equipment/presentation/screens/equipmentDetail',
  // Features: Property
  'srceens/propertyListRegistrationDetails': 'features/property/presentation/screens/propertyListRegistrationDetails',
  // Features: Mapping
  'srceens/mapingTagRfid': 'features/mapping/presentation/screens/mapingTagRfid',
  // Features: Notifications
  'srceens/notificationsPage': 'features/notifications/presentation/screens/notificationsPage',
};

// Any other remaining items in basic root folders
final List<String> foldersToCheck = [
  'Interface',
  'models',
  'provider',
  'repository',
  'srceens'
];

void main() async {
  print('Starting Clean Architecture Migration...');

  final libDir = Directory(basePath);
  if (!libDir.existsSync()) {
    print('lib directory not found');
    return;
  }

  // 1. Create target directories ONLY for broad features, skip specific ones that will be renamed
  final targetDirs = [
    'features/shared/data/models',
    'features/shared/data/repositories',
    'features/shared/domain/repositories',
    'features/shared/providers',
    'features/shared/presentation/screens',
    'features/shared/domain/usecases'
  ];

  for (var dir in targetDirs) {
    var d = Directory('$basePath/$dir');
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
  }

  Map<String, String> importReplacements = {};

  // 2. Perform exact mapping moves
  for (var entry in dirMappings.entries) {
    var sourcePath = '$basePath/${entry.key}';
    var destPath = '$basePath/${entry.value}';
    
    var file = File(sourcePath);
    var dir = Directory(sourcePath);
    
    if (file.existsSync()) {
      // It's a file
      var parentDir = Directory(destPath.substring(0, destPath.lastIndexOf('/')));
      if (!parentDir.existsSync()) parentDir.createSync(recursive: true);
      file.renameSync(destPath);
      importReplacements[entry.key] = entry.value;
      print('Moved file: $sourcePath -> $destPath');
    } else if (dir.existsSync()) {
      // It's a directory
      var dDest = Directory(destPath);
      if (!dDest.existsSync()) dDest.createSync(recursive: true);

      // Move contents instead of renaming folder to avoid OS Error 183
      for (var entity in dir.listSync(recursive: true)) {
        if (entity is File) {
          var relativePath = entity.path.substring(dir.path.length + 1).replaceAll(r'\', '/');
          var newPath = '$destPath/$relativePath';
          var newFile = File(newPath);
          if (!newFile.parent.existsSync()) newFile.parent.createSync(recursive: true);
          entity.renameSync(newPath);
        }
      }
      importReplacements[entry.key] = entry.value;
      print('Moved directory contents: $sourcePath -> $destPath');
    } else {
      print('Warning: Source path not found or already moved: $sourcePath');
      // Also register replacement in case it was already moved on a prior run
      importReplacements[entry.key] = entry.value;
    }
  }

  // 3. Move remaining items generically
  // E.g., any models not moved to auth go to core/shared or features/shared/data/models
  _moveContents('models', 'features/shared/data/models', importReplacements);
  _moveContents('repository', 'features/shared/data/repositories', importReplacements);
  _moveContents('provider', 'features/shared/providers', importReplacements);
  _moveContents('Interface', 'features/shared/domain/repositories', importReplacements);
  // Any remaining screens to features/shared
  _moveContents('srceens', 'features/shared/presentation/screens', importReplacements);

  // 4. Clean up empty old directories
  for (var folder in foldersToCheck) {
    var d = Directory('$basePath/$folder');
    if (d.existsSync()) {
      try {
        d.deleteSync(recursive: true);
        print('Deleted empty directory: $basePath/$folder');
      } catch (e) {
        print('Could not delete directory (might not be empty): $basePath/$folder');
      }
    }
  }

  // 5. Update import paths in all .dart files
  print('Updating import references...');
  var dartFiles = libDir.listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  dartFiles.add(File('main.dart')); // if it's at root, wait, main.dart is inside lib/ so picked up by listSync

  for (var file in dartFiles) {
    var content = file.readAsStringSync();
    var newContent = content;
    bool changed = false;

    // Fix imports replacing exact matches
    // e.g. import 'package:flutter_pat_application/themes/...
    importReplacements.forEach((oldPath, newPath) {
      // package import format
      var oldPkgImport = 'package:flutter_pat_application/$oldPath';
      var newPkgImport = 'package:flutter_pat_application/$newPath';
      if (newContent.contains(oldPkgImport)) {
        newContent = newContent.replaceAll(oldPkgImport, newPkgImport);
        changed = true;
      }
      
      // Also handle relative imports if any..
      // E.g. import '../../srceens/login/...' - this is much harder, so we replace simple strings
      var oldSimpImport = "'$oldPath";
      var newSimpImport = "'$newPath";
      if (newContent.contains(oldSimpImport)) {
         // this might be unsafe, but relative imports starting with 'themes/...' from main.dart
         // e.g. import 'srceens/login/...' -> import 'features/auth/presentation/screens/login/...'
         newContent = newContent.replaceAll(oldSimpImport, newSimpImport);
         changed = true;
      }
    });

    if (changed) {
      file.writeAsStringSync(newContent);
      print('Updated imports in: ${file.path}');
    }
  }

  print('Migration completed.');
}

void _moveContents(String oldDir, String newDir, Map<String, String> importReplacements) {
  var dir = Directory('$basePath/$oldDir');
  if (!dir.existsSync()) return;

  var destDir = Directory('$basePath/$newDir');
  if (!destDir.existsSync()) destDir.createSync(recursive: true);

  for (var entity in dir.listSync()) {
    var basename = entity.path.split(Platform.pathSeparator).last;
    var newPath = '$basePath/$newDir/$basename';
    if (entity is File) {
      entity.renameSync(newPath);
      importReplacements['$oldDir/$basename'] = '$newDir/$basename';
      print('Moved leftover file: ${entity.path} -> $newPath');
    } else if (entity is Directory) {
      entity.renameSync(newPath);
      importReplacements['$oldDir/$basename'] = '$newDir/$basename';
      print('Moved leftover dir: ${entity.path} -> $newPath');
    }
  }
}
