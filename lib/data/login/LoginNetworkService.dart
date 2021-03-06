import 'dart:async';
import 'dart:convert';
import 'package:bsshopmvp/data/FetchDataException.dart';
import 'package:http/http.dart' as http;
import 'package:bsshopmvp/utils/Constants.dart';
import 'package:bsshopmvp/model/login/LoginResult.dart';

class LoginNetworkRepository implements LoginRepository {

  @override
  Future<LoginResult> login({Map body}) async {
    String url = BASE_URL + "/oauth/token";
    http.Response response = await http.post(url, body: body);
    final statusCode = response.statusCode;
    final Map responseBody = json.decode(response.body);
    final LoginResult loginResult = new LoginResult.fromMap(responseBody);

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error ocurred : [Status Code : $statusCode]");
    }

    return LoginResult.fromMap(responseBody) ;
  }
}