// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_block_cubit_skeleton/features/change_password/presentation/widget/change_password_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailDrawer extends StatefulWidget {
  const UserDetailDrawer({super.key});

  @override
  _UserDetailDrawerState createState() => _UserDetailDrawerState();
}

class _UserDetailDrawerState extends State<UserDetailDrawer> {
  bool showUserDetails = false;

  Widget _buildDrawerList() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: const Text("Settings"),
          leading: const Icon(Icons.settings),
          onTap: () {
            Navigator.pushNamed(context, RouteName.settings);
          },
        ),
        ListTile(
          title: const Text("Records"),
          leading: const Icon(Icons.list),
          onTap: () {
            setState(() {
              selectedIndex = 0;
              pages[selectedIndex];
            });
            Navigator.pushNamed(context, RouteName.dashboard);
          },
        ),
        ListTile(
          title: const Text("Analysis"),
          leading: const Icon(Icons.analytics),
          onTap: () {
            setState(() {
              selectedIndex = 1;
              pages[selectedIndex];
            });
            Navigator.pushNamed(context, RouteName.dashboard);
          },
        ),
        ListTile(
          title: const Text("Details"),
          leading: const Icon(Icons.pie_chart),
          onTap: () {
            setState(() {
              selectedIndex = 2;
              pages[selectedIndex];
            });
            Navigator.pushNamed(context, RouteName.dashboard);
          },
        ),
        ListTile(
          title: const Text("Accounts"),
          leading: const Icon(Icons.account_balance_wallet),
          onTap: () {
            setState(() {
              selectedIndex = 3;
              pages[selectedIndex];
            });
            Navigator.pushNamed(context, RouteName.dashboard);
          },
        ),
        ListTile(
          title: const Text("Categories"),
          leading: const Icon(Icons.category),
          onTap: () {
            setState(() {
              selectedIndex = 4;
              pages[selectedIndex];
            });
            Navigator.pushNamed(context, RouteName.dashboard);
          },
        ),
        ExpansionTile(
          leading: const Icon(
            Icons.feed_outlined,
            color: Colors.grey,
          ),
          trailing: Icon(
            color: Colors.grey,
            true ? Icons.abc : Icons.arrow_drop_down,
          ),
          title: const Text(
            'Demo',
          ),
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteName.initialRoute);
              },
              child: const ListTile(
                title: Text(
                  'Demo list 1',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //Navigator.pushNamed(context, RouteName.initialRoute);
              },
              child: const ListTile(
                  title: Text(
                'Demo list 2',
              )),
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, RouteName.examResultRoute);
              },
              child: ListTile(
                  title: Text(
                'Demo list 3',
              )),
            ),
          ],
        ),
      ],
    );
  }

  // bool _customTileExpandedExam = false;
  // bool _customTileExpanded = false;

  Widget _buildUserDetail() {
    return ListView(
      children: [
        ListTile(
          title: const Text("Profile"),
          leading: const Icon(Icons.person_outline_outlined),
          onTap: () {
            Navigator.pushNamed(context, RouteName.profile);
          },
        ),
        ListTile(
          onTap: () {
            // Navigator.pushNamed(context, RouteName.changePassword);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ChangePasswordWidget()));
          },
          leading: const Icon(Icons.change_circle),
          title: const Text(
            'Change Password',
            // style: TextStyle(color: Colors.black),
          ),
        ),
        ListTile(
          title: const Text("Logout"),
          leading: const Icon(Icons.login_outlined),
          onTap: () {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.question,
              // body: const Center(
              //   child: Text(
              //     'Do you want to logout?',
              //     style: TextStyle(fontStyle: FontStyle.italic),
              //   ),
              // ),
              title: 'Are you sure?',
              desc: 'Do you want to logout?',
              btnOkOnPress: () async {
                // SharedPreferences sharedPreferences =
                //     await SharedPreferences.getInstance();
                // setState(() {
                //   sharedPreferences.remove("roleType");
                //   sharedPreferences.remove("loginId");
                //   sharedPreferences.remove("nameEn");
                //   sharedPreferences.remove("email");
                //   sharedPreferences.remove("mobileNo");
                //   sharedPreferences.remove("instituteOid");
                // });
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.clear();

                Navigator.pushNamed(context, RouteName.signin);
                // simulateInitialDataLoading();

                // Navigator.pushNamed(context, RouteName.signInRoute);
              },
              btnCancelOnPress: () {},
            ).show();

            // Navigator.pushNamed(context, RouteName.subjectRoute);
          },
        ),
        // ListTile(
        //   title: const Text("Demo guardian"),
        //   leading: const Icon(Icons.notifications_active),
        //   onTap: () {
        //     Navigator.pushNamed(context, RouteName.dashboardGuardianRoute);
        //   },
        // ),
      ],
    );
  }

  String? userPhotoUrl;

  String? name;
  String? email;

  getNameEn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString("name");
      debugPrint(
          "sharedPreferences.getString(name) :::${sharedPreferences.getString("name")}");
      debugPrint("nameEn shared preference: $name");
    });
  }

  getEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email = sharedPreferences.getString("email");
      debugPrint(
          "sharedPreferences.getString(email) :::${sharedPreferences.getString("email")}");
      debugPrint("mobileNo shared preference: $email");
    });
  }

  getuserPhotoUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userPhotoUrl = sharedPreferences.getString("userPhotoUrl");
      debugPrint(
          "sharedPreferences.getString(userPhotoUrl) :::${sharedPreferences.getString("userPhotoUrl")}");
      debugPrint("userPhotoUrl shared preference: $userPhotoUrl");
    });
  }

  @override
  void initState() {
    getNameEn();
    getEmail();
    // getuserPhotoUrl();
    // profilePhoto = "${signInData.userPhotoUrl}";
    // print("Image:::::>> ${signInData.userPhotoUrl}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: userPhotoUrl == null
                    ? const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/pp.jpg"))
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("$userPhotoUrl")),
                color: Colors.white,
                borderRadius: BorderRadius.circular(50)),
          ),
          decoration: const BoxDecoration(
            color: Color(0xff341f97),
          ),
          accountName: Text(
            "$name",
            style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text(
            "$email",
            style:
                GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          onDetailsPressed: () {
            setState(() {
              showUserDetails = !showUserDetails;
            });
          },
        ),
        Expanded(
            child: showUserDetails ? _buildUserDetail() : _buildDrawerList())
      ]),
    );
  }

  Future<Timer> simulateInitialDataLoading() async {
    return Timer(
      const Duration(seconds: 3),
      () => LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.black, size: 20),
    );
  }
}
