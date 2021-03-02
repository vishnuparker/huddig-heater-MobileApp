import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:parker_mobile_framework/Utility/MyConstants.dart';
import 'package:parker_mobile_framework/login/NavigationDrawer.dart';


class Aboutfragment extends StatefulWidget {
  @override
  AboutFragmentState createState() => AboutFragmentState();
}

TabController _tabController;


class AboutFragmentState extends State<Aboutfragment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              title: Text(
                BOTTOMNAV.title,
              ),
            ),
            body: DefaultTabController(
                length: 3,
                child: Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: const Size.fromHeight(50.0),
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.yellow,
                            labelColor: Colors.red,
                            unselectedLabelColor: Colors.grey,

                            tabs: [
                              const Tab(
                                text: 'ContactUs',
                                icon: Icon(Icons.contact_mail),
                              ),
                             const Tab(
                                text: 'Location',
                                icon: Icon(Icons.location_on),
                              ),
                              const Tab(
                                text: 'Photo',
                                icon: Icon(Icons.photo_album),
                              ),
                            ], // list of tabs
                          ),
                        ),
                        //TabBarView(children: [ImageList(),])
                        Expanded(
                          child: TabBarView(children: [
                            Container(
                              
                            ),
                            Container(
                             
                              ),
                            
                            Container(
                              color: Colors.white,
                              child: const Center(child: Text('Photo details')),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ))));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: const Text('NO'),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) => NavigationDrawer()),
                    ModalRoute.withName('/NavigationDrawer')),
                child: const Text('YES'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
