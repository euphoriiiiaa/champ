import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class Kand {
  static const String key = 'A8E74302D4F8E05EAA52A09323335B5B';
  static const String secret = 'A92E80C29297C94AD252C5C7979C8E3B';
  static const String url = 'https://api-key.fusionbrain.ai';
  static const headers = {
    'X-Key': 'Key $key',
    'X-Secret': 'Secret $secret',
    'Content-Type': 'application/json'
  };

// curl --location --request POST 'https://api-key.fusionbrain.ai/key/api/v1/text2image/run' \
// --header 'X-Key: Key A8E74302D4F8E05EAA52A09323335B5B' \
// --header 'X-Secret: Secret A92E80C29297C94AD252C5C7979C8E3B' \
// -F 'params="{
//   \"type\": \"GENERATE\",
//   \"generateParams\": {
//     \"query\": \"море\"
//   }
// }";type=application/json' \
// --form 'model_id="4"'

  static void getImage() async {
    try {
      var modelid = await getModel();
      var params = {
        "type": "GENERATE",
        "numImages": 1,
        "width": 200,
        "height": 200,
        "generateParams": {
          "query": "small cat",
        }
      };

      var jsonData = jsonEncode({
        'model_id': modelid,
        'params': params,
      });
      var postimage = await Dio().post(
        '${url}/key/api/v1/text2image/run',
        data: jsonData,
        options: Options(headers: headers, contentType: 'application/json'),
      );

      log(postimage.data['uuid'].toString());
    } catch (e) {
      log('error2: ' + e.toString());
    }
  }

  static Future<int> getModel() async {
    try {
      var response = await Dio().get(
        '${url}/key/api/v1/models',
        options: Options(
          headers: headers,
        ),
      );

      var data = response.data;

      log(data[0]['id'].toString());
      return data[0]['id'];
    } catch (e) {
      log('error: ' + e.toString());
      return 0;
    }
  }
}
