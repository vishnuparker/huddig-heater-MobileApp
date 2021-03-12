import 'package:flutter/material.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:parker_mobile_framework/HeaterApi/HeaterMainView.dart';

class Login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Login> {
  bool _isObscure = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailAddress = TextEditingController();
  bool validate = false;
  String email;
  String password;
  bool _rememberMeFlag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(HOME.login),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(LoginString.huggigheater,
                      style: const TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 60),
                  formSetup(context)
                ],
              ))),
    );
  }

  Widget formSetup(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _emailAddress,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.email),
              border: const OutlineInputBorder(),
              hintText: LoginString.emailAddress,
              labelText: LoginString.emailAddress,
              suffixIcon: IconButton(
                iconSize: 18.0,
                onPressed: () => _emailAddress.clear(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            maxLength: 36,
            validator: (String val) {
              if (val.isEmpty)
                return LoginString.emailerrormsg;
              //  else if (!val.contains(""))
              //    return "Please enter valid UserId";
              else
                return null;
            },
            onSaved: (String val) => email = val,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.person),
              suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
              border: const OutlineInputBorder(),
              hintText: LoginString.password,
              labelText: LoginString.password,
            ),
            obscureText: _isObscure,
            validator: (String val) {
              if (val.isEmpty)
                return LoginString.passerrormsg;
              else if (val.length <= 8)
                return LoginString.passlength;
              else
                return null;
            },
            onSaved: (String val) => password = val,
          ),
          const Padding(
            padding:  EdgeInsets.only(top: 20.0),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (BuildContext context) =>  HeaterMainView()),
                    // );

                    //  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                    //    content: new Text("Your email: $email and Password: $password"),
                    //  ));
                  }
                },
                color: Colors.yellow,
              )),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: _rememberMeFlag,
                        onChanged: (bool value) => setState(() {
                          _rememberMeFlag = !_rememberMeFlag;
                        }),
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      //          new Container(
                      //   margin: new EdgeInsets.only(left: 25.0),
                      //   child: new  RaisedButton(
                      //   child: Text('forgot Password ?'),
                      //   color: Colors.yellow,
                      //   onPressed: (){},
                      // ),
                      // )
                    ],
                  ),
                  onTap: () => setState(() {
                    _rememberMeFlag = !_rememberMeFlag;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
