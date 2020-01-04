import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imadmin/api/apiconstants.dart';
import 'package:imadmin/models/shot.dart';
import 'package:imadmin/models/user.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';


class MonsterAdminApi{

  Future<String> performLogin(String username,String password) async {
    var response= await http.post(ApiConstants.BASE_URL+"login/",body: json.encode({
        "username":username,
        "password":password
    }));

    if(response.statusCode==200){
        saveUser(username,password,response.body);
        return response.body;
    }else{
      return ApiConstants.ERROR_STRING;
    }
    
  }

  Future<List<Shot>> getShots() async {
    var requestUrl="https://api.dribbble.com/v2/user/shots?access_token="+ApiConstants.DRIBBLE_ACCESS_TOKEN+"&page=1&per_page=100";
    var response=await http.get(requestUrl);
    if (response.statusCode == 200) {
      Iterable list=json.decode(response.body);
      var output=list.map<Shot>((item)=>Shot.fromJson(item)).toList();
      return output; 
    }else{
      print("response is "+response.statusCode.toString());
    }
  }

  void saveUser(String userName,String password,String response) async{

    var prefs=SharedPreferencesPlugin();
    var user=User.parse(json.decode(response),password);
    prefs.setValue("", ApiConstants.USER_PREF,json.encode(user) );

  }

  Future<User> getUser() async{

    User result;
    var prefs=SharedPreferencesPlugin();
     var items  = await  prefs.getAll();
     items.forEach((k,v)=>{
        if(k.toString()==ApiConstants.USER_PREF){
          result= User.fromJson(json.decode(v.toString()))
        }
     });
     return result;

  }
}