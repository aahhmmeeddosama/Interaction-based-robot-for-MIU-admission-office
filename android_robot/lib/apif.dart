import 'package:http/http.dart' as http;

Future<String> apif(url, selectImage) async {
  final request = http.MultipartRequest("POST", Uri.parse(url));
  final headers = {"content-type": "multipart/from-data"};
  request.files.add(http.MultipartFile(
      'image', selectImage!.readAsBytes().asStream(), selectImage!.lengthSync(),
      filename: selectImage!.path.split("/").last));
  request.headers.addAll(headers);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);
  return res.body;
}
/*
void apif(url, selectImage) async {
  final request = http.MultipartRequest("POST", Uri.parse(url));
  final headers = {"content-type": "multipart/from-data"};
  request.files.add(http.MultipartFile(
      'image', selectImage!.readAsBytes().asStream(), selectImage!.lengthSync(),
      filename: selectImage!.path.split("/").last));
  request.headers.addAll(headers);

}*/