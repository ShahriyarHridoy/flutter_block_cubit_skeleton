import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_block_cubit_skeleton/common/widgets/drawer.dart';
import 'package:flutter_block_cubit_skeleton/core/navigation/route_name.dart';
import 'package:flutter_block_cubit_skeleton/dashboard/screen/dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

saveCurrencyIcon() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString('currencyIcon', currencyIcon);
}

var currencyIcon = "";
var currencyName;
ThemeData? darkTheme;
bool enableDarkMode = false;
//  ThemeData? whiteTheme;
ThemeData appTheme = ThemeData(
    textTheme: GoogleFonts.openSansTextTheme(),
    primarySwatch: MaterialColor(0xff341f97, {
      50: Color.fromARGB(255, 232, 232, 232),
      100: Color(0xffc9a3e3),
      200: Color(0xffad6dce),
      300: Color(0xff9238b8),
      400: Color(0xff7722a3),
      500: Color(0xff5c0c8d),
      600: Color(0xff480974),
      700: Color(0xff33055a),
      800: Color(0xff1f003f),
      900: Color(0xff0a0025),
    }),
    brightness: Brightness.light);

class _SettingsPageState extends State<SettingsPage> {
  @override
  @override
  void initState() {
    super.initState();
    getCurencyIcon();
    // Initialize the app theme
    appTheme = ThemeData(
        primarySwatch: Colors.deepPurple, brightness: Brightness.light);
  }

  bool _enableNotifications = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD';

  void _toggleNotifications(bool value) {
    setState(() {
      _enableNotifications = value;
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      enableDarkMode = value;
      appTheme = enableDarkMode
          ? ThemeData(
              primarySwatch: MaterialColor(0xff341f97, {
                50: Color(0xffe4d9f1),
                100: Color(0xffc9a3e3),
                200: Color(0xffad6dce),
                300: Color(0xff9238b8),
                400: Color(0xff7722a3),
                500: Color(0xff5c0c8d),
                600: Color(0xff480974),
                700: Color(0xff33055a),
                800: Color(0xff1f003f),
                900: Color(0xff0a0025),
              }),
              brightness: Brightness.dark,
            )
          : ThemeData(
              primarySwatch: MaterialColor(0xff341f97, {
                50: Color(0xffe4d9f1),
                100: Color(0xffc9a3e3),
                200: Color(0xffad6dce),
                300: Color(0xff9238b8),
                400: Color(0xff7722a3),
                500: Color(0xff5c0c8d),
                600: Color(0xff480974),
                700: Color(0xff33055a),
                800: Color(0xff1f003f),
                900: Color(0xff0a0025),
              }),
              brightness: Brightness.light,
            );
    });
  }

  void _changeLanguage(String? language) {
    setState(() {
      _selectedLanguage = language ?? _selectedLanguage;
    });
  }

  void _changeCurrency(String? currency) {
    setState(() {
      _selectedCurrency = currency ?? _selectedCurrency;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (enableDarkMode) {
      appTheme = ThemeData(
          primarySwatch: MaterialColor(0xff341f97, {
            50: Color(0xffe4d9f1),
            100: Color(0xffc9a3e3),
            200: Color(0xffad6dce),
            300: Color(0xff9238b8),
            400: Color(0xff7722a3),
            500: Color(0xff5c0c8d),
            600: Color(0xff480974),
            700: Color(0xff33055a),
            800: Color(0xff1f003f),
            900: Color(0xff0a0025),
          }),
          brightness: Brightness.dark);
    } else {
      appTheme = ThemeData(
          primarySwatch: MaterialColor(0xff341f97, {
            50: Color(0xffe4d9f1),
            100: Color(0xffc9a3e3),
            200: Color(0xffad6dce),
            300: Color(0xff9238b8),
            400: Color(0xff7722a3),
            500: Color(0xff5c0c8d),
            600: Color(0xff480974),
            700: Color(0xff33055a),
            800: Color(0xff1f003f),
            900: Color(0xff0a0025),
          }),
          brightness: Brightness.light);
    }
    return Theme(
      data: appTheme,
      child: Scaffold(
        drawer: const UserDetailDrawer(),
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            _buildSectionHeader('General'),
            _buildListTile(
              Icons.notifications,
              'Notification Settings',
              Switch(
                value: _enableNotifications,
                onChanged: _toggleNotifications,
                activeColor: Color(0xff10ac84),
                activeTrackColor: Color(0xff10ac84).withOpacity(0.5),
              ),
            ),
            _buildListTile(
              Icons.palette,
              'Dark Mode',
              Switch(
                value: enableDarkMode,
                onChanged: _toggleDarkMode,
                activeColor: Colors.deepPurple,
                activeTrackColor: Colors.deepPurple.withOpacity(0.5),
              ),
            ),
            Divider(color: Colors.grey[300]),
            _buildSectionHeader('Language'),
            _buildDropdownListTile(
              Icons.language,
              'Language',
              _selectedLanguage,
              _changeLanguage,
              ['English', 'Spanish', 'French', 'German'],
              Color(0xff341f97),
            ),
            Divider(color: Colors.grey[300]),
            _buildSectionHeader('Currency'),
            // _buildDropdownListTile(
            //   Icons.attach_money,
            //   'Change Currency',
            //   _selectedCurrency,
            //   _changeCurrency,
            //   ['USD', 'EUR', 'GBP', 'JPY'],
            //   Colors.orange,
            // ),
            ListTile(
              leading: Text(
                currencyIcon ?? "",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              title: InkWell(
                  onTap: () {
                    showCurrencyPicker(
                        context: context,
                        theme: CurrencyPickerThemeData(
                          flagSize: 25,
                          titleTextStyle: const TextStyle(fontSize: 17),
                          subtitleTextStyle: TextStyle(
                              fontSize: 15, color: Theme.of(context).hintColor),
                          bottomSheetHeight:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        onSelect: (Currency currency) {
                          setState(() {
                            currencyIcon = currency.symbol;

                            saveCurrencyIcon();
                            print("currency.symbol:${currency.symbol}");
                            currencyName = currency.name;
                          });
                        });
                  },
                  child: const Text(
                    'Tap to Change Currency',
                    style: TextStyle(color: Colors.deepPurple),
                  )),
              trailing: Text(
                currencyName ?? "",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ),

            Divider(color: Colors.grey[300]),
            _buildSectionHeader('Account'),
            _buildListTileWithIcon(
              Icons.account_circle,
              'Account Settings',
              RouteName.profile,
              Colors.white,
            ),
            _buildSectionHeader('Clear Data'),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Clear Cache'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Clear Cache'),
                      content: const Text(
                          'Are you sure you want to clear the cache?'),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Clear'),
                          onPressed: () {
                            // Implement cache clearing logic here
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cache cleared.'),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            _buildListTileWithIcon(
              Icons.location_on,
              'App Permissions',
              '',
              Colors.white,
            ),
            Divider(color: Colors.grey[300]),
            _buildSectionHeader('About'),
            _buildListTileWithIcon(
              Icons.info,
              'About',
              '',
              Colors.white,
            ),
            _buildListTileWithIcon(
              Icons.feedback,
              'Feedback',
              '',
              Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            const SizedBox(
              width: 8.0,
            ),
            Text("${country.currencyCode}"),
          ],
        ),
      );

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, Widget trailing) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
    );
  }

  Widget _buildDropdownListTile(
    IconData icon,
    String title,
    String value,
    Function(String?) onChanged,
    List<String> items,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: color),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildListTileWithIcon(
    IconData icon,
    String title,
    String routeName,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        if (routeName.isNotEmpty) {
          Navigator.pushNamed(context, routeName);
        }
      },
      tileColor: color.withOpacity(0.1),
    );
  }
}
