import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/Network/AppException.dart';
import 'package:parker_mobile_framework/Pojoclass/HeaterModel.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:parker_mobile_framework/Utility/shared_preferences_util.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HeaterStatus extends StatefulWidget {
  final HeaterModel availablelist;
  const HeaterStatus({Key key, this.availablelist}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HeaterDeatails();
  }
}

class HeaterDeatails extends State<HeaterStatus> {
  String controlstatus, desiredHeaterState, reason;
  String resultConverstion;
  int _selectedValue, actualHeaterState;
  String heaterstatus, _selectedStatus;
  Color heateron = Colors.red;
  Color heateroff = Colors.green;
  Color heatercolor;

  String updatetime,
      connectionstate,
      requesttime,
      reportedtime,
      executiveStatus,
      requesttimevalue,
      reportedtimevalue;
  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    try { 
      updatetime =
          widget.availablelist.connectionStateLastUpdatedTime.toString();
      reportedtime = widget.availablelist.reportedTime.toString();
      requesttime = widget.availablelist.requestTime.toString();
      controlstatus = widget.availablelist.controlStatus.toString();
      desiredHeaterState = widget.availablelist.desiredHeaterState.toString();
      reason = widget.availablelist.reason.toString();
      executiveStatus = widget.availablelist.detail.executiveStatus.toString();
      if (widget.availablelist.detail.actualHeaterState!=null) {
        actualHeaterState =
            widget.availablelist.detail.actualHeaterState.toInt();
      }

      setState(() {
        heaterstatus = PreferenceUtils.getString(LoginString.heaterstatus);
        connectionstate = convertLocal(updatetime);
        requesttimevalue = convertLocal(requesttime);
        reportedtimevalue = convertLocal(reportedtime);

        if (actualHeaterState.isOdd && actualHeaterState != null) {
          heatercolor = heateron;
          _selectedValue = 0;
        } else {
          heatercolor = heateroff;
          _selectedValue = 1;
        }

        if (controlstatus.contains("Fail")) {
          _selectedStatus = "Fail";
        } else {
          _selectedStatus = "Success";
        }
        _selectedValue.isOdd ? _selectedValue = 1 : _selectedValue = 0;
      });
    } on FetchDataException catch (e) {
      print('fetch data exception : $e');
    }
  }

  @override
  void setState(fn) {
    print("setState");
    super.setState(fn);
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedValue);
    // return WillPopScope(
    //     onWillPop: _onBackPressed,
    return Scaffold(
        appBar: null,
        body: Align(
          alignment: Alignment.center,
          child: Container(
              child: SingleChildScrollView(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  HeaterString.heaterstatus + _selectedStatus,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ToggleSwitch(
                initialLabelIndex: _selectedValue,
                labels: ['ON', 'OFF'],
                activeBgColor: heatercolor,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.white,
                inactiveFgColor: Colors.white,
                fontSize: 14,
                changeOnTap: false,
              ),
              Container(
                padding: new EdgeInsets.all(30.0),
                alignment: FractionalOffset.center,
                child: new Text(
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
                      '\n\n' +
                      HeaterString.actualHeaterState +
                      actualHeaterState.toString() +
                      '\n\n',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            ],
          ))),
        ));
  }
}
