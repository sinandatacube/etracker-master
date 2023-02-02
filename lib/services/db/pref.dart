

import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  
  setCreditional({required String id, required String psw})async{
    var pref = await SharedPreferences.getInstance();
    await pref.setString('id', id);
    await pref.setString('psw', psw);

  }


  getCreditional()async{
    var pref = await SharedPreferences.getInstance();
      var id = pref.getString('id');
      var psw = pref.getString('psw');

      return {"id":id,"psw":psw};
  }


  clearCreditional()async{
    var pref = await SharedPreferences.getInstance();
    await  pref.remove('id');
    await  pref.remove('psw');
    return 1;
  }


  isCreditional()async{
    var pref = await SharedPreferences.getInstance();

   var id = await  pref.containsKey("id");
  var psw =  await  pref.containsKey("psw");

    if (id && psw) {
      return true;
    }else{
      return false;
    }

  }


}