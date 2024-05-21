// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'data_list_widget.dart';

class RecordsAllWidgetPage extends StatefulWidget {
  RecordsAllWidgetPage({
    Key? key,
  }) : super(key: key);

  @override
  _RecordsAllWidgetPageState createState() => _RecordsAllWidgetPageState();
}

class _RecordsAllWidgetPageState extends State<RecordsAllWidgetPage> {
  DateTime _selectedStartDate = DateTime.now();
  DateTime _selectedEndDate = DateTime.now();
  String selectedMonthYear = DateFormat.yMMMM().format(DateTime.now());
  final double _totalExpense = 150.0;
  final double _totalIncome = 250.0;
  final bool _isButtonVisible = true;
  String currentMonthName = '';

  late List<String> dropDownItems = [
    currentMonthName,
    'All',
    'Custom',
  ];

  late String? dropdownSelectedValue = currentMonthName;
  bool _isVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentMonthName = DateFormat.yMMMM().format(DateTime.now());
  }

  void _selectStartDate(BuildContext context) async {
    final DateTime? startDatePicked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (startDatePicked != null && startDatePicked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = startDatePicked;
        print(DateFormat('yyyy-MM-dd').format(_selectedStartDate));
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;

        print(DateFormat('yyyy-MM-dd').format(_selectedEndDate));
      });
    }
  }

  void _selectMonthYear(BuildContext context) async {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          // selectedMonthYear = date;
          selectedMonthYear = DateFormat.yMMMM().format(date);
          dropdownSelectedValue = selectedMonthYear;
          dropDownItems[0] = selectedMonthYear;

          print("################");
          print(DateFormat('yyyy-MM-dd').format(date));
          print(DateFormat('yyyy-MM-dd')
              .format(DateTime(date.year, date.month + 1, 0)));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            // padding: const EdgeInsets.symmetric(horizontal: 80),
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              // hint: Text(
              //   'Select Duration',
              //   style: TextStyle(
              //     fontSize: 14,
              //     color: Theme.of(context).hintColor,
              //   ),
              // ),
              items: dropDownItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: dropdownSelectedValue,
              onChanged: (value) {
                setState(() {
                  dropdownSelectedValue = value as String;
                  if (dropdownSelectedValue == "Custom") {
                    _isVisible = true;
                  } else if (dropdownSelectedValue == "All") {
                    _isVisible = false;
                    //transactionList();
                  } else
                  // if (dropdownSelectedValue == "Monthly")
                  {
                    _isVisible = false;
                    // transactionListRequest.startDate = '';
                    // transactionListRequest.endDate = '';
                    //  transactionListRequest.monthly = true;
                    _selectMonthYear(context);
                    // transactionList();
                  }
                });
              },
              buttonStyleData: const ButtonStyleData(
                height: 30,
                padding: EdgeInsets.only(left: 20, right: 10),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
        if (_isVisible == true) ...[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Selected Start Date: ${DateFormat('yyyy-MM-dd').format(_selectedStartDate)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectStartDate(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 5, 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Selected End Date: ${DateFormat('yyyy-MM-dd').format(_selectedEndDate)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectEndDate(context);
                  },
                ),
              ],
            ),
          ),
        ],

        // const DataListScreen(),
        Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: RecordsPage()),
      ],
    );
  }
}
