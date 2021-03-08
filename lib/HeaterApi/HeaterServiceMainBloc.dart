import 'dart:async';
import 'package:parker_mobile_framework/HeaterApi/HeaterServiceMainBlocRepo.dart';
import 'package:parker_mobile_framework/Network/ApiResponse.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';

class HeaterServiceMainBloc {

  HeaterServiceMainBloc() {
    _baseServiceController = StreamController<ApiResponse<HeaterModel>>();
    _heaterServiceRepository = HeaterServiceMainBlocRepo();
    baseService();
  }
  StreamController _baseServiceController;

  HeaterServiceMainBlocRepo _heaterServiceRepository;
  

  StreamSink<ApiResponse<HeaterModel>> get baseserviceSink =>
      _baseServiceController.sink;

  Stream<ApiResponse<HeaterModel>> get baseserviceStream =>
      _baseServiceController.stream;


  baseService() async {
    baseserviceSink.add(ApiResponse.loading('Please wait while fetching detail...'));
    try {
      HeaterModel baseServicedata =
          await _heaterServiceRepository.fetchBaseServiceData();
      baseserviceSink.add(ApiResponse.completed(baseServicedata));
    } catch (e) {
      baseserviceSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  Future<dynamic> dispose() async {
    return _baseServiceController?.close();
  }
}
