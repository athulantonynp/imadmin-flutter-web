import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:imadmin/api/apiconstants.dart';

class MonsterAdminApi{

  Future<String> performLogin(String username,String password) async {
    var response= await http.post(ApiConstants.BASE_URL+"login/",body: json.encode({
        "username":username,
        "password":password
    }));

    if(response.statusCode==200){
        return response.body;
    }else{
      return ApiConstants.ERROR_STRING;
    }
    
  }

}