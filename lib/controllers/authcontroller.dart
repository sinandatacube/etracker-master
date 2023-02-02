import 'package:employee_manage/services/db/pref.dart';
import 'package:flutter/cupertino.dart';

class AuthController extends ChangeNotifier {
  
bool  isloading =false;

setLoading(val){
  isloading = val;
  notifyListeners();
}




/// login

 Future<int> checkLogin({required String id, required String psw})async{
   
   if (id == 'admin' && psw == "1122") {
     await Pref().setCreditional(id: id, psw: psw);
     return 1;
   }else{
    return 0;
   }
 }


  isCredtional()async{
   var res = await Pref().isCreditional();
   return res;
  }

  logout()async{
    var res = await Pref().clearCreditional();
    return res;
  }

}