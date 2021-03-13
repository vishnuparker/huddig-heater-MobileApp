import 'dart:async';

import 'package:cron/cron.dart';
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
  HeaterModel availablelistvalue;
  String servicegetcall;
  HeaterStatusPending({Key key, this.servicegetcall, this.availablelistvalue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HeaterPendingDeatils();
  }
}

class HeaterPendingDeatils extends State<HeaterStatusPending> {
  String controlstatus;
  HeaterServiceMainBloc _bloc;
  Cron cron;
  Color heateron = Colors.red;
  Color heateroff = Colors.green;
  Color heatercolor;
  int _counter = 0;
  int _countResult;
  @override
  // ignore: missing_return
  Future<void> initState() {
    super.initState();
    _bloc = HeaterServiceMainBloc();
    widget.availablelistvalue.controlStatus.toString();
    cron = Cron();
    if (widget.availablelistvalue.controlStatus
        .toString()
        .contains('Success')) {
      cron.close();
      print('stop run every 30 sec.');
    } else {
      cron.schedule(Schedule.parse('*/30 * * * * *'), () async {
        print('The values are timer called: 30min timer called');
        _bloc.baseService();
        print('will run every 30 sec.');
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
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
                        _countResult = _counter++;
                        print(_countResult);
                        // if (_countResult == 1){
                        //     return PendingDetails (availablelist: snapshot.data.data,
                        //     servicegetcall: "Pending failed");
                        // }else {
                        return PendingDetails(
                            availablelist: snapshot.data.data,
                            servicegetcall: "retryServiceCall");
                      } else if (snapshot.hasData &&
                          snapshot.data.data.controlStatus
                              .contains('Success')) {
                        _counter = 0;
                        cron.close();
                        return HeaterStatus(availablelist: snapshot.data.data);
                      } else if (snapshot.hasData &&
                          snapshot.data.data.controlStatus.contains('Fail')) {
                        _counter = 0;
                        cron.close();
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
}

// ignore: must_be_immutable
class PendingDetails extends StatefulWidget {
  String servicegetcall;

  HeaterModel availablelist;
  PendingDetails({Key key, this.availablelist, this.servicegetcall})
      : super(key: key);

  String controlstatus;

  @override
  HeaterPendingDeatilsList createState() => HeaterPendingDeatilsList();
}

class HeaterPendingDeatilsList extends State<PendingDetails> {
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
  int actualHeaterState, _selectedValue;
  Color heateron = Colors.red;
  Color heateroff = Colors.green;
  Color heatercolor;
  String heaterstatus, _selectedStatus, servicegetcallValue;

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();

    try {
      servicegetcallValue = widget.servicegetcall.toString();
      updatetime =
          widget.availablelist.connectionStateLastUpdatedTime.toString();
      reportedtime = widget.availablelist.reportedTime.toString();
      requesttime = widget.availablelist.requestTime.toString();
      controlstatus = widget.availablelist.controlStatus.toString();
      desiredHeaterState = widget.availablelist.desiredHeaterState.toString();
      reason = widget.availablelist.reason.toString();
      executiveStatus = widget.availablelist.detail.executiveStatus.toString();
      actualHeaterState = widget.availablelist.detail.actualHeaterState.toInt();

      setState(() {
        connectionstate = convertLocal(updatetime);
        requesttimevalue = convertLocal(requesttime);
        reportedtimevalue = convertLocal(reportedtime);

        if (actualHeaterState.isOdd) {
          heatercolor = heateron;
          _selectedValue = 0;
        } else {
          heatercolor = heateroff;
          _selectedValue = 1;
        }

        if (controlstatus.contains("Fail")) {
          _selectedStatus = "Fail";
        } else if (controlstatus.contains("Pending") &&
            servicegetcallValue.contains("Pendingfirst")) {
          setState(() {
            final cron = Cron();
            // */1 * * * * ever one min */10 * * * * * ever 10 sec
            print('pending detail every one minutes');
            cron.schedule(Schedule.parse('*/60 * * * * *'), () async {
              print('The values are timer called: 1min timer called');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HeaterStatusPending(
                          availablelistvalue: widget.availablelist,
                          servicegetcall: "Pendingresult")));
              await cron.close();
            });
          });
          // } else if (controlstatus.contains("Pending") &&
          //     servicegetcallValue.contains("Pending failed")){
          //       _selectedValue.isOdd ;
          // }
        } else {
          _selectedStatus = "Success";
        }

        _selectedValue.isOdd ? _selectedValue = 1 : _selectedValue = 0;
      });
    } on FetchDataException catch (e) {
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
              Padding(
                padding: EdgeInsets.all(20.0),
                child: RichText(
                  text: TextSpan(
                      text: HeaterString.heaterstatus,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                      children: <TextSpan>[
                        TextSpan(
                            text: controlstatus,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                                fontSize: 20))
                      ]),
                ),
              ),
              ToggleSwitch(
                initialLabelIndex: _selectedValue,
                labels: ['ON', 'OFF'],
                activeBgColor: heatercolor,
                activeFgColor: Colors.black,
                inactiveBgColor: Colors.white,
                inactiveFgColor: Colors.white,
                changeOnTap: false,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: FractionalOffset.center,
                child: Text(
                  HeaterString.connectionLastUpdatedTime +
                      connectionstate +
                      '\n\n' +
                      HeaterString.reportedtime +
                      reportedtimevalue +
                      '\n\n' +
                      HeaterString.requesttime +
                      requesttimevalue +
                      '\n\n' +
                      HeaterString.desiredHeaterState +
                      desiredHeaterState +
                      '\n\n' +
                      HeaterString.reason +
                      reason +
                      '\n \n' +
                      HeaterString.executiveStatus +
                      executiveStatus +
                      '\n \n' +
                      HeaterString.actualHeaterState +
                      actualHeaterState.toString() +
                      '\n\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,
                                fontFamily:'Trajan Pro',),
                ),
              ),
//               Container(
//                 child: FlatButton(
//   onPressed: () => {
// 	//do something
//   },
//   child: new Text('Retry by manual '),
// ),
//               )
            ],
          ))),
        ));
  }
}
