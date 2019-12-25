import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imadmin/api/apiconstants.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';


class MonsterAdminApi{

  Future<String> performLogin(String username,String password) async {
    var response= await http.post(ApiConstants.BASE_URL+"login/",body: json.encode({
        "username":username,
        "password":password
    }));

    if(response.statusCode==200){
        saveUser(username,password);
        return response.body;
    }else{
      return ApiConstants.ERROR_STRING;
    }
    
  }

  void saveUser(String userName,String password) async{
    var prefs=SharedPreferencesPlugin();
    prefs.setValue("", ApiConstants.USER_NAME_PREF, userName);
    prefs.setValue("", ApiConstants.PASS_PREF, password);
  }

  Future<String> getUserName() async{

    String result="";
    var prefs=SharedPreferencesPlugin();
     var items  = await  prefs.getAll();
     items.forEach((k,v)=>{
        if(k.toString()==ApiConstants.USER_NAME_PREF){
          result= v.toString()
        }
     });

     return result;

  }

  Future<String> getPassword() async {
   String result="";
    var prefs=SharedPreferencesPlugin();
     var items  = await  prefs.getAll();
     items.forEach((k,v)=>{
        if(k.toString()==ApiConstants.PASS_PREF){
          result= v.toString()
        }
     });

     return result;
  }
}