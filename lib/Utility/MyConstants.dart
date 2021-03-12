library constants;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const String Base_server_URL ='https://apidev.parker.com/dev/vom/iqan/control/api/v1/equipment/id/Q5DT3Z94/heater';
const String Sub_Url = "/equipment/id/";
const String Mastertag = "OLBWR9JG";
const String OrgId_url = "/heater?orgId=";
const String OcpApimSubscriptionKey ="615d3d0e70a34648b41a4da670f9deb2";
const String Subscriptionkey = "subscriptionkey";
const String  OrgId_taylor = "a09ad270-3b21-11e7-893e-f94b4bc7246b";
const String Orgname_Taylor ="Taylor";

const String HOME_TITLE = "Parker ";

class BOTTOMNAV {
  static String title = "Parker";
  static String trackservichome = "Citizen Service";
  static String paynow = "Pay Now";
  static String trackservic = "Track Services";
  static String paynoe = "Pay Now";
  static String help = "Help";
  static String markattend = "Mark my Attendance";
}

class HOME {
  static String title = "Welcome";
  static String loginMessage = "Sign In:";
  static String login = "Credentials";
  static String trackServices = "Track Services";
  static String serviceComplaint = "Service Complaint";
  static String markmyattendance = "Mark My Attendance";
  static String passCode = "Enter PassCode";
  static String trackapplication =
      "You can track your Assert by Tracking ID ";
  static String trackid = "Tracking ID";
  static String mobileno = "Mobile No";
  static String authLogin ="Wifi Connection";
  static String detailspage ="Detail Pages";
}



class NavigationDrawerhint {
  static String faq = "FAQ";
  static String citizen = "Citizen Service";
  static String smogandpollution = "Smog and pollution Complaint";
  static String feedback = "Feedback and Rating";
  static String aboutUs = "About Us";
}

class Trackservice {
  static String mobileNo = "Mobile No";
  static String trackid = "Tracking ID";
  static String tracknumber = "Tracking Number";
  static String track = "Track";
  static String feedback = "Give FeedBack";
  static String trackservice = "Track Service";
  static String alert = "Alert";
  static String cancel = "Cancel";
  static String trackalertmess = "Enter Tracking Id";
  static String trackhint =
      "You can track your application by Tracking ID or Mobile Number";
}

class HeaterString {
  static String heaterstatus = "HeaterStatus : ";
  static String connectionLastUpdatedTime ="ConnectionLastUpdatedTime :";
  static String reportedtime = "Reportedtime :" ;
  static String requesttime = "Requesttime :";
  static String desiredHeaterState = "DesiredHeaterState :";
  static String reason = "Reason :";
  static String executiveStatus = "ExecutiveStatus :";
  static String actualHeaterState = "ActualHeaterState :";
}

class LoginString{
  static String turnonheater ="Heater";
  static String title ="Parker";
  static String contantdetails = "Contant Details";
  static String emailAddress ="Email Address";
  static String password ="Password";
  static String emailId = "emailid";
  static String emailerrormsg ="This feild  cannot be  left blank";
  static String contantus ="Contant Us :";
  static String faxNo = "Fax No :";
  static String address =" Address :";
  static String info = "Info :";
  static String passerrormsg= "Please enter your password";
  static String passlength ="Your password should be more then 9 char long";
  static String termsconditions ="Terms and Conditions";
  static String termshint =" \u00a9 Parker Hannifin . All rights reserved.";
  static String heaterstatus= "Heaterstatus";
  static String success = "Success";
  static String valueTrue = "Success" ;
  static String huggigheater =" Huddig - Heater";
  static String heaterPiNq ="Heater Controller MT:Q5DT3Z94";
  static String heaterPIN0 ="Heater Controller MT:OLBWR9JG";
  static String hintheater ="Please turn ON and OFF \n The Heater to know the  status";
  
}





String validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
}

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
   String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "MobileNumber is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
}

String validateEmail(String value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
}



String validateDesc(String value){
   String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Desc is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Desc must be a-z and A-Z";
    }else if (value.length < 50){
        return "Desc must be 50 line min";
    }
    return null;
}

String validateLocation(String value){
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Location is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Desc must be a-z and A-Z";
    }else if (value.length < 50){
        return "Desc must be 50 line min";
    }
    return null;

}

String convertLocal(String value){
  if (value!= null){
  DateTime moonLanding = DateTime.parse(value);
  final convertLocalvalue = moonLanding.toLocal();
  var newFormat = DateFormat("yy-MM-dd hh:mm:ss aaa");
  String updatedDt = newFormat.format(convertLocalvalue);
  print(updatedDt);
  return updatedDt;
  }
  return null;

}


 var alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: true,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
      side: BorderSide(
        color: Colors.white70,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.yellowAccent,
    ),
  );

