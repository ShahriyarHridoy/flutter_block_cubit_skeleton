import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/drawer.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/widget/records_all_widget.dart';
import 'package:flutter_block_cubit_skeleton/features/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardScreenState createState() => _DashboardScreenState();
}

String getCurrencyIcon = "";

getCurencyIcon() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // setState(() {

  // });
  getCurrencyIcon = sharedPreferences.getString("currencyIcon") == null
      ? ""
      : sharedPreferences.getString("currencyIcon")!;
  debugPrint(
      "sharedPreferences.getString(name) :::${sharedPreferences.getString("currencyIcon")}");
  debugPrint("nameEn shared preference: $getCurrencyIcon");
}

List<Widget> pages = [
  RecordsAllWidgetPage(),
  RecordsAllWidgetPage(),
  RecordsAllWidgetPage(),
  RecordsAllWidgetPage(),
  RecordsAllWidgetPage(),
];
int selectedIndex = 0;

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getCurencyIcon();

    // getCurrencyIcon == null ?? "";
    super.initState();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Theme(
        data: appTheme,
        child: Scaffold(
          drawer: const UserDetailDrawer(),
          appBar: AppBar(
            toolbarHeight: 80,
            title: const Text('Flutter Block  Cubit Skeleton'),
          ),
          body: pages[selectedIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Color(0xff341f97),
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                // primaryColor: Colors.red,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(bodySmall: const TextStyle(fontSize: 20))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BottomNavigationBar(
                  showUnselectedLabels: true,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  currentIndex: selectedIndex,
                  onTap: _onNavItemTapped,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.list),
                      label: 'Records',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.analytics),
                      label: 'Analysis',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.pie_chart),
                      label: 'Details',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: 'Accounts',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.category),
                      label: 'Categories',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
