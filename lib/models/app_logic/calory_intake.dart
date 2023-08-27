import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:translator/translator.dart';

Future<String> getFoodInfo(String foodName) async {
  const String apiSecret = '7f947eb5f6bb474c894e5d27fbff0ad2';
  const String apiKey = 'cc90f610102044efa320f0ef4634555d';
  const String baseUrl = 'https://platform.fatsecret.com/rest/server.api';
  const String method = 'foods.search';
  const String format = 'json';

  const String oauthVersion = '1.0';
  const String oauthSignatureMethod = 'HMAC-SHA1';

  final String oauthNonce = DateTime.now().millisecondsSinceEpoch.toString();
  final String oauthTimestamp =
      (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

  final Map<String, String> queryParams = {
    'method': method,
    'format': format,
  };

  final Map<String, String> oauthParams = {
    'oauth_consumer_key': apiKey,
    'oauth_nonce': oauthNonce,
    'oauth_signature_method': oauthSignatureMethod,
    'oauth_timestamp': oauthTimestamp,
    'oauth_version': oauthVersion
  };

  // Translate the food name to English
  final String englishFoodName = await convertTolang(foodName, 'ar', 'en');

  final Map<String, String> searchParams = {
    ...queryParams,
    'search_expression': englishFoodName,
  };

  final Map<String, String> params = {...searchParams, ...oauthParams};

  final List<String> sortedKeys = params.keys.toList()..sort();

  final String sortedParams = sortedKeys
      .map((key) => '$key=${Uri.encodeQueryComponent(params[key]!)}')
      .join('&');

  final String baseString =
      'POST&${Uri.encodeQueryComponent(baseUrl)}&${Uri.encodeQueryComponent(sortedParams)}';

  const String signingKey = '$apiSecret&';

  final String oauthSignature = base64.encode(
    Hmac(sha1, utf8.encode(signingKey)).convert(utf8.encode(baseString)).bytes,
  );

  final String authorizationHeader = 'OAuth '
      'oauth_consumer_key="$apiKey", '
      'oauth_nonce="$oauthNonce", '
      'oauth_signature="$oauthSignature", '
      'oauth_signature_method="$oauthSignatureMethod", '
      'oauth_timestamp="$oauthTimestamp", '
      'oauth_version="$oauthVersion"';

  final Map<String, String> requestParams = {
    'oauth_consumer_key': apiKey,
    'oauth_nonce': oauthNonce,
    'oauth_signature_method': oauthSignatureMethod,
    'oauth_timestamp': oauthTimestamp,
    'oauth_version': oauthVersion,
    'oauth_signature': oauthSignature,
    ...searchParams,
  };

  final http.Response response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Authorization': authorizationHeader},
    body: requestParams,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);

    print('Response body: $responseData');

    if (responseData.containsKey('foods')) {
      final Map<String, dynamic> foods = responseData['foods'];
      final List<dynamic> foodList = foods['food'];

      if (foodList.isNotEmpty) {
        final Map<String, dynamic> food = foodList[0];

        final String foodNameFromResponse = food['food_name'];
        final String foodDescription = food['food_description'];

        // Translate the food name and description to Arabic
        final String translatedFoodName =
            await convertTolang(foodNameFromResponse, 'en', 'ar');
        final String translatedFoodDescription =
            await convertTolang(foodDescription, 'en', 'ar');

        return 'اسم الطعام: $translatedFoodName\nوصف الطعام: $translatedFoodDescription';
      }
    }
  }

  return 'لم يتم العثور على معلومات للطعام $foodName';
}

Future<String> convertTolang(
    String text, String sourceLang, String targetLang) async {
  final translator = GoogleTranslator();

  Translation translation =
      await translator.translate(text, from: sourceLang, to: targetLang);
  return translation.text;
}

// Future<int> getApproximateCalories(String foodName) async {
//   const String apiSecret = '7f947eb5f6bb474c894e5d27fbff0ad2';
//   const String apiKey = 'cc90f610102044efa320f0ef4634555d';
//   const String baseUrl = 'https://platform.fatsecret.com/rest/server.api';
//   const String method = 'foods.search';
//   const String format = 'json';

//   const String oauthVersion = '1.0';
//   const String oauthSignatureMethod = 'HMAC-SHA1';

//   final String oauthNonce = DateTime.now().millisecondsSinceEpoch.toString();
//   final String oauthTimestamp =
//       (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

//   final Map<String, String> queryParams = {
//     'method': method,
//     'format': format,
//   };

//   final Map<String, String> oauthParams = {
//     'oauth_consumer_key': apiKey,
//     'oauth_nonce': oauthNonce,
//     'oauth_signature_method': oauthSignatureMethod,
//     'oauth_timestamp': oauthTimestamp,
//     'oauth_version': oauthVersion
//   };

//   final Map<String, String> searchParams = {
//     ...queryParams,
//     'search_expression': foodName
//   };

//   final Map<String, String> params = {...searchParams, ...oauthParams};

//   final List<String> sortedKeys = params.keys.toList()..sort();

//   final String sortedParams = sortedKeys
//       .map((key) => '$key=${Uri.encodeQueryComponent(params[key]!)}')
//       .join('&');

//   final String baseString =
//       'POST&${Uri.encodeQueryComponent(baseUrl)}&${Uri.encodeQueryComponent(sortedParams)}';

//   final String signingKey = '$apiSecret&';

//   final String oauthSignature = base64.encode(
//     Hmac(sha1, utf8.encode(signingKey)).convert(utf8.encode(baseString)).bytes,
//   );

//   final String authorizationHeader = 'OAuth '
//       'oauth_consumer_key="$apiKey", '
//       'oauth_nonce="$oauthNonce", '
//       'oauth_signature="$oauthSignature", '
//       'oauth_signature_method="$oauthSignatureMethod", '
//       'oauth_timestamp="$oauthTimestamp", '
//       'oauth_version="$oauthVersion"';

//   final Map<String, String> requestParams = {
//     'oauth_consumer_key': apiKey,
//     'oauth_nonce': oauthNonce,
//     'oauth_signature_method': oauthSignatureMethod,
//     'oauth_timestamp': oauthTimestamp,
//     'oauth_version': oauthVersion,
//     'oauth_signature': oauthSignature,
//     ...searchParams,
//   };
//   final http.Response response = await http.post(
//     Uri.parse(baseUrl),
//     headers: {'Authorization': authorizationHeader},
//     body: requestParams,
//   );

//   if (response.statusCode == 200) {
//     final Map<String, dynamic> responseData = json.decode(response.body);

//     print('Response body: $responseData');

//     if (responseData.containsKey('foods')) {
//       final List<dynamic> foods = responseData['foods']['food'];

//       if (foods.isNotEmpty) {
//         int calories = 0;

//         for (final food in foods) {
//           final String foodNameFromResponse = food['food_name'];

//           if (foodNameFromResponse.toLowerCase() == foodName.toLowerCase()) {
//             final String caloriesText = food['food_description'];
//             final RegExp regex =
//                 RegExp(r'Calories:\s*(\d+)', caseSensitive: false);
//             final Match? match = regex.firstMatch(caloriesText);

//             if (match != null) {
//               calories = int.parse(match.group(1)!);
//               break;
//             }
//           }
//         }

//         print('Extracted calories: $calories');
//         return calories;
//       }
//     }
//   }

//   return 0;
// }

// Future<int> sumApproximateCalories(List<String> foodNames) async {
//   int totalCalories = 0;

//   for (int i = 0; i < foodNames.length; i++) {
//     final foodName = foodNames[i];
//     final calories = await getApproximateCalories(foodName);
//     totalCalories += calories;
//   }

//   return totalCalories;
// }
