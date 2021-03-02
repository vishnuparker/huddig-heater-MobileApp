import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/CommonClass/ErrorMessage.dart';
import 'package:parker_mobile_framework/CommonClass/Loading.dart';
import 'package:parker_mobile_framework/HeaterApi/HeaterServiceMainBloc.dart';
import 'package:parker_mobile_framework/HeaterApi/HeaterStatus.dart';
import 'package:parker_mobile_framework/Network/ApiResponse.dart';
import 'package:parker_mobile_framework/Network/AppException.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:parker_mobile_framework/Utility/shared_preferences_util.dart';
import 'package:toggle_switch/toggle_switch.dart';

// ignore: must_be_immutable
class HeaterStatusPending extends StatefulWidget {

   HeaterModel availablelist;
   HeaterStatusPending({Key key, this.availablelist}) : super(key: key);
 
 
  @override
  State<StatefulWidget> createState() {
    return HeaterPendingDeatils();
  }
}

class HeaterPendingDeatils extends State<HeaterStatusPending> {
  String controlstatus;
  HeaterServiceMainBloc _bloc;
  Timer _timer;
 
  @override
  void initState() {
    super.initState();
    _bloc = HeaterServiceMainBloc();
    setState(() {
      _timer = Timer.periodic(
          Duration(seconds: 15), (Timer t) => _bloc.baseService());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  void deactivate() {
    print('deactivate');
    super.deactivate();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () => _bloc.baseService(),
          child: StreamBuilder<ApiResponse<HeaterModel>>(
              stream: _bloc.baseserviceStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case ApiStatus.Loading:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case ApiStatus.Completed:
                      if (snapshot.hasData &&
                          snapshot.data.data.controlStatus
                              .contains('Pending')) {
                        return PendingDetails(
                            availablelist: snapshot.data.data);
                      } else if (snapshot.hasData &&
                          snapshot.data.data.controlStatus
                              .contains('Success')) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          stopTimer();
                        });
                        return HeaterStatus(availablelist: snapshot.data.data);
                      } else if (snapshot.hasData &&
                          snapshot.data.data.controlStatus.contains('Fail')) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          stopTimer();
                        });
                        return HeaterStatus(availablelist: snapshot.data.data);
                      }

                      break;
                    case ApiStatus.Error:
                      return ErrorMessage(
                        errorMessage: snapshot.data.message,
                      );
                      break;
                  }
                }
                return Container();
              })),
    );
  }

  void stopTimer() {
    setState(() {
      _timer?.cancel();
    });
  }
}

// ignore: must_be_immutable
class PendingDetails extends StatefulWidget {

   PendingDetails({Key key, this.availablelist}) : super(key: key);

  HeaterModel availablelist;
 

  @override
  HeaterPendingDeatilsList createState() => HeaterPendingDeatilsList();
}

class HeaterPendingDeatilsList extends State<PendingDetails> {
  String heaterstatus;
  String updatetime,
      connectionstate,
      requesttime,
      reportedtime,
      requesttimevalue,
      reportedtimevalue,
      desiredHeaterState,
      reason,
      executiveStatus,
      controlstatus;
  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    try{
    updatetime = widget.availablelist.connectionStateLastUpdatedTime.toString();
    reportedtime = widget.availablelist.reportedTime.toString();
    requesttime = widget.availablelist.requestTime.toString();
    controlstatus = widget.availablelist.controlStatus.toString();
    desiredHeaterState = widget.availablelist.desiredHeaterState.toString();
    reason = widget.availablelist.reason.toString();
    executiveStatus = widget.availablelist.detail.executiveStatus.toString();
      setState(() {
      connectionstate = convertLocal(updatetime);
      requesttimevalue = convertLocal(requesttime);
      reportedtimevalue = convertLocal(reportedtime);
    });
    } on FetchDataException catch(e) {
    print('error caught: $e');
  }
  
  }

  @override
  void setState(fn) {
    print('PendingDetails setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    print('PendingDetails deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('PendingDetails disposed');
    super.dispose();
  }

  final int _selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: Align(
          alignment: Alignment.center,
          child: Container(
              child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Heater Status:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ToggleSwitch(
                initialLabelIndex: _selectedValue,
                labels: [controlstatus],
                activeBgColor: Colors.yellow,
                activeFgColor: Colors.black,
                inactiveBgColor: Colors.redAccent,
                inactiveFgColor: Colors.white,
                changeOnTap: false,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: FractionalOffset.center,
                child: Text(
                  'connectionLastUpdatedTime  : ' +
                      connectionstate +
                      '\n' +
                      'reportedtime : ' +
                      reportedtimevalue +
                      '\n' +
                      'requesttime  :  ' +
                      requesttimevalue +
                      '\n' +
                      'DesiredHeaterState  : ' +
                      desiredHeaterState +
                      '\n' +
                      'Reason  :  ' +
                      reason +
                      '\n \n' +
                      'ExecutiveStatus : ' +
                      executiveStatus +
                      '\n \n' 
                      ,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )
            ],
          ))),
        ));
  }
}
