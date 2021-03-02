

import 'package:parker_mobile_framework/Network/ApiBase.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';


class HeaterServiceMainBlocRepo{

final ApiBase _provider = ApiBase ();

 Future<HeaterModel> fetchBaseServiceData() async {
    final response = await _provider.get();
    return HeaterModel.fromJson(response);
  }  
}
 