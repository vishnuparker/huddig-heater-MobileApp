class HeaterModel {
  HeaterModel(
      {this.connectionState,
      this.connectionStateLastUpdatedTime,
      this.controlStatus,
      this.reason,
      this.desiredHeaterState,
      this.requestTime,
      this.reportedHeaterState,
      this.reportedTime,
      this.detail,
      this.snapshotTime});

  String connectionState;
  String connectionStateLastUpdatedTime;
  String controlStatus;
  String reason;
  int desiredHeaterState;
  String requestTime;
  int reportedHeaterState;
  String reportedTime;
  Detail detail;
  String snapshotTime;

  
  HeaterModel.fromJson(Map<String, dynamic> json) {
    connectionState = json['connectionState'] as String;
    connectionStateLastUpdatedTime = json['connectionStateLastUpdatedTime'] as String;
    controlStatus = json['controlStatus'] as String;
    reason = json['reason'] as String;
    desiredHeaterState = json['desiredHeaterState']as int;
    requestTime = json['requestTime'] as String;
    reportedHeaterState = json['reportedHeaterState']as int;
    reportedTime = json['reportedTime']as String;
    detail =
        json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    snapshotTime = json['snapshotTime'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['connectionState'] = connectionState;
    data['connectionStateLastUpdatedTime'] =
        connectionStateLastUpdatedTime;
    data['controlStatus'] = controlStatus;
    data['reason'] = reason;
    data['desiredHeaterState'] = desiredHeaterState;
    data['requestTime'] = requestTime;
    data['reportedHeaterState'] = reportedHeaterState;
    data['reportedTime'] = reportedTime;
    if (detail != null) {
      data['detail'] = detail.toJson();
    }
    data['snapshotTime'] = snapshotTime;
    return data;
  }
}

class Detail {

  Detail(
      {this.executiveStatus,
      this.actualHeaterState,
      this.ignitionState,
      this.supplyVoltage,
      this.nextWakeUpTime,
      this.heaterOnSeconds,
      this.maxOnSeconds,
      this.sleepCycleInSeconds});


  String executiveStatus;
  int actualHeaterState;
  String ignitionState;
  int supplyVoltage;
  String nextWakeUpTime;
  int heaterOnSeconds;
  int maxOnSeconds;
  int sleepCycleInSeconds;

  

  Detail.fromJson(Map<String, dynamic> json) {
    executiveStatus = json['executiveStatus'] as String;
    actualHeaterState = json['actualHeaterState'] as int;
    ignitionState = json['ignitionState'] as String;
    supplyVoltage = json['supplyVoltage']  as int;
    nextWakeUpTime = json['nextWakeUpTime']  as String;;
    heaterOnSeconds = json['heaterOnSeconds']  as int;;
    maxOnSeconds = json['maxOnSeconds']  as int;;
    sleepCycleInSeconds = json['sleepCycleInSeconds'] as int;;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['executiveStatus'] = executiveStatus;
    data['actualHeaterState'] = actualHeaterState;
    data['ignitionState'] = ignitionState;
    data['supplyVoltage'] = supplyVoltage;
    data['nextWakeUpTime'] = nextWakeUpTime;
    data['heaterOnSeconds'] = heaterOnSeconds;
    data['maxOnSeconds'] = maxOnSeconds;
    data['sleepCycleInSeconds'] = sleepCycleInSeconds;
    return data;
  }
}