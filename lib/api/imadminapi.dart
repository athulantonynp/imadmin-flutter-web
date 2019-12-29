import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imadmin/api/apiconstants.dart';
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