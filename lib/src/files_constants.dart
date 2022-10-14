import 'dart:io' show HttpClient, Directory, Platform;

class FilesConstants {
  static FilesConstants? _instance;

  FilesConstants._();

  static FilesConstants get i {
    _instance ??= FilesConstants._();
    return _instance!;
  }

  final HttpClient httpClient = HttpClient();

  Directory get appDirectory => Directory.systemTemp.parent;

  Directory get temporaryDirectory => Directory.systemTemp;

  Directory get cacheDirectory => Directory(
      '${temporaryDirectory.path}${pathSeparator}cachedFilesFlutterApp');

  String get pathSeparator => Platform.pathSeparator;
  String get localeName => Platform.localeName;
  String get version => Platform.version;
  int get numberOfProcessors => Platform.numberOfProcessors;
  String get getOperatingSystem => Platform.operatingSystem;
  String get getOperatingSystemVersion => Platform.operatingSystemVersion;
  Map<String, String> get getEnvironment => Platform.environment;
  String get getScriptPath => Platform.script.path;
  String get getResolvedExecutable => Platform.resolvedExecutable;

  /*var getEnvironment = Constants.getEnvironment;
  if(getEnvironment.keys.contains('HOMEPATH')){
    print(getEnvironment['HOMEPATH']);
    print(getEnvironment['HOMEDRIVE']);
    print(getEnvironment['COMPUTERNAME']);
    print(getEnvironment['USERNAME']);
    print(getEnvironment['USERPROFILE']);
    print(getEnvironment['COMSPEC']);
    print(getEnvironment['TEMP']);
    print(false);
  }*/

}
