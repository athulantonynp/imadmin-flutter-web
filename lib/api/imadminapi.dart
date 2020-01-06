import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imadmin/api/apiconstants.dart';
import 'package:imadmin/models/shot.dart';
import 'package:imadmin/models/user.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

class MonsterAdminApi {
  Future<String> performLogin(String username, String password) async {
    var response = await http.post(ApiConstants.BASE_URL + "login/",
        body: json.encode({"username": username, "password": password}));

    if (response.statusCode == 200) {
      saveUser(username, password, response.body);
      return response.body;
    } else {
      return ApiConstants.ERROR_STRING;
    }
  }

  static List shotToJson(List<Shot> list) {
    List jsonList = List();
    list
        .map((Shot item) => {
              if (item.isSelected) {jsonList.add(item.toJson())}
            })
        .toList();
    return jsonList;
  }

  Future<int> saveShotsToServer(List<Shot> shots) async {
    var user = await getUser();

    var response = await http.post(ApiConstants.BASE_URL + "shots/",
        body: json.encode({
          "username": user.userName,
          "password": user.pass,
          "shots": json.encode(shotToJson(shots))
        }));

    return response.statusCode;
  }

  Future<List<Shot>> getShots() async {
    List<Shot> outputList = new List();

    for (int i = 1; i < 10; i++) {
      var response = await getShotsFromServer(i);

      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        if (list.length > 0) {
          outputList
              .addAll(list.map<Shot>((item) => Shot.fromJson(item)).toList());
        } else {
          break;
        }
      } else {
        break;
      }
    }

    outputList.sort((a,b) =>b.published_at.compareTo(a.published_at));

    return outputList;
  }

  Future<List<Shot>> getCurrentShots() async{
     var user = await getUser();
  var response = await http.get(ApiConstants.BASE_URL + "shots/"+"?username="+user.userName+"&password="+user.pass);
    Iterable responseJson=json.decode(response.body);
    return responseJson.map((item)=> Shot.fromJson(item)).toList();
  }

  Future<http.Response> getShotsFromServer(int page) async {
    var requestUrl = "https://api.dribbble.com/v2/user/shots?access_token=" +
        ApiConstants.DRIBBLE_ACCESS_TOKEN +
        "&page=" +
        page.toString() +
        "&per_page=100";
    var response = await http.get(requestUrl);

    return response;
  }

  void saveUser(String userName, String password, String response) async {
    var prefs = SharedPreferencesPlugin();
    var user = User.parse(json.decode(response), password);
    prefs.setValue("", ApiConstants.USER_PREF, json.encode(user));
  }

  Future<User> getUser() async {
    User result;
    var prefs = SharedPreferencesPlugin();
    var items = await prefs.getAll();
    items.forEach((k, v) => {
          if (k.toString() == ApiConstants.USER_PREF)
            {result = User.fromJson(json.decode(v.toString()))}
        });
    return result;
  }
}
