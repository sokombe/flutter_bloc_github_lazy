import 'dart:convert';

import 'package:bloc_app1/models/gitHubModel.dart';
import 'package:http/http.dart' as http;

class GitUsersRepository {
  static Future<ListUSers> searchUsers(String keyword, int page, int pageSize) async {
    String url =
        "https://api.github.com/search/users?q=$keyword&page=$page&per_page=$pageSize";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> ListUsersMap = jsonDecode(response.body);
        ListUSers listUsers = ListUSers.fromJson(ListUsersMap);
        return listUsers;
      } else {
        return throw ('Error=>${response.statusCode}');
      }
    } catch (e) {
      return throw (e.toString());
    }
  }
}
