## Funções utilitárias de desenvolvimento dart e flutter para arquivos 


```dart
import 'package:files_cache/files_cache.dart';

void main() async{

  var f = Functions.i.checkFileExist(filePath: 'C:/Users/name/AppData/Local/Temp/cachedFilesFlutterApp/Google-flutter-logo.png');
  print('Exist: $f');

  await Functions.i.getByteDataFromInternet(url: 'https://getlogo.net/wp-content/uploads/2020/08/flutter-logo-vector.png').then((uint8List) {
    Functions.i.createFile(filePath: 'C:/Users/name/...png', bytesData: uint8List).then((value) {
      print('---- Arquivo creado com sucesso ----');
    });
  });

  await Functions.i.getByteDataFromFile(filePath: 'C:/Users/name/...png').then((value) {
    print(value);
  });

  // armazenar arquivo em cache
  await FilesCache().getBytesData(
    url: 'https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png',
    fileDurationTime: Duration(days: 3)
  ).then((uint8List) {
    print(uint8List);
  });

}
```
