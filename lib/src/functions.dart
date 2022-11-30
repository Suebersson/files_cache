import 'dart:io' show File, HttpClientRequest, HttpClientResponse;
import 'dart:convert' show base64;
import 'dart:typed_data' show Uint8List;
import 'package:dart_dev_utils/dart_dev_utils.dart' show dartDevUtils;
import 'constants.dart';
import 'consolidate_bytesdata.dart' show consolidateByteData;

class FilesFunctions {
  static final FilesFunctions _instance = FilesFunctions._();
  static FilesFunctions get i => _instance;
  FilesFunctions._();

  late File file;

  /// obter a base64 atráves da byteData [Uint8Lis]
  String getBase64FromByteData({required Uint8List uint8List}) {
    return base64.encode(uint8List);
  }

  /// obter a base64 de um arquivo armazenado na mémoria
  Future<String> getBase64FromFile({required String filePath}) async {
    assert(filePath.isNotEmpty, 'Insira o endereço do arquivo');
    return getBase64FromByteData(
        uint8List: await getByteDataFromFile(filePath: filePath));
  }

  /// obter o valor [Uint8List] (ByteData) através da base64
  Uint8List getByteDataFromBase64({required String base64Data}) {
    assert(base64Data.isNotEmpty, 'Insira o valor da base64');
    return base64.decode(base64Data);
  }

  /// obter o arquivo salvo na mémoria
  Future<File> getFile({required String filePath}) async {
    assert(filePath.isNotEmpty, 'Insira o endereço do arquivo');
    file = File(filePath);

    if (file.existsSync()) {
      return file;
    } else {
      throw '---- Arquivo não localizado ----';
    }
  }

  /// verificar se o arquivo existe na mémoria
  bool checkFileExist({required String filePath}) {
    assert(filePath.isNotEmpty, 'Insira o endereço do arquivo');
    file = File(filePath);

    if (file.existsSync()) {
      return true;
    } else {
      return false;
    }
  }

  // criar um arquivo
  /// Nesse método não e necessario informar o nome e extensão do arquivo,
  /// apenas o endereço completo do onde será criado
  Future<File> createFile(
      {required String filePath,
      required Uint8List bytesData,
      bool recursive = true}) async {
    assert(filePath.isNotEmpty, 'Insira o endereço do arquivo');
    file = File(filePath);

    if (file.existsSync()) {
      return file;
    } else {
      return await file.create(recursive: recursive).then((file) {
        file.writeAsBytesSync(bytesData);
        return file;
      });
    }
  }

  /// apagar um arquivo
  /// Informa o endereço completo do arquivo a ser deletado
  bool deleteFile({required String filePath, bool recursive = false}) {
    assert(filePath.isNotEmpty, 'Insira o endereço do arquivo');
    file = File(filePath);

    if (file.existsSync()) {
      file.deleteSync(recursive: recursive);
      return true;
    } else {
      return false;
    }
  }

  /// obter o valor [Uint8List] (ByteData) de uma arquivo armazenado na mémoria
  Future<Uint8List> getByteDataFromFile({required String filePath}) async {
    assert(filePath.isNotEmpty, 'Insira o endereço do arquivo');
    file = File(filePath);

    if (file.existsSync()) {
      return file.readAsBytes();
    } else {
      throw '---- Arquivo não localizado ----';
    }
  }

  /// obter o valor [Uint8List] (ByteData) de uma arquivo na internet
  Future<Uint8List> getByteDataFromInternet({required String url}) async {
    assert(url.isNotEmpty, 'Insira o endereço da url');

    HttpClientRequest? _request;
    HttpClientResponse? _response;

    if (dartDevUtils.isNetworkURL(url)) {
      try {
        _request = await FilesConstants.i.httpClient.getUrl(Uri.parse(url));
        _response = await _request.close();

        if (_response.statusCode == 200) {
          return consolidateByteData(_response, autoUncompress: false);
        } else if (_response.statusCode >= 404) {
          await _request.close();
          throw '---- Verifique se a url informada está correta, se ela existe ou se tem problemas no servidor ----';
        } else {
          await _request.close();
          throw '---- Erro na requisição, status: ${_response.statusCode}  ----';
        }
      } catch (e) {
        await _request?.close();
        throw '---- Erro ao tentar acessar a url fornecida, por favor verifique sua conexão ----';
      }
    } else {
      throw '---- Url inválida ----';
    }
  }

  /*Future<bool> fileDownload({required String fileFullPath}){
    throw 'função pendente';
  }*/

}
