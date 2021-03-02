import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/CommonClass/ErrorMessage.dart';
import 'package:parker_mobile_framework/CommonClass/Loading.dart';

import 'package:parker_mobile_framework/HeaterApi/HeaterServiceMainBloc.dart';
import 'package:parker_mobile_framework/Network/ApiResponse.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';

class Heater extends StatefulWidget {
  @override
  _HeaterState createState() => _HeaterState();
}

class _HeaterState extends State<Heater> {
  HeaterServiceMainBloc _bloc;

  @override
  void initState() {
    _bloc = HeaterServiceMainBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: RefreshIndicator(
          onRefresh: () => _bloc.baseService(),
          child: StreamBuilder<ApiResponse<HeaterModel>>(
              stream: _bloc.baseserviceStream,
              builder: (BuildContext context, AsyncSnapshot<ApiResponse<HeaterModel>> snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case ApiStatus.Loading:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case ApiStatus.Completed:
                      break;
                    case ApiStatus.Error:
                      return ErrorMessage(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.baseService(),
                      );
                      break;
                    default:
                      break;
                  }
                }
                return Container();
              })),
    );
  }
}
