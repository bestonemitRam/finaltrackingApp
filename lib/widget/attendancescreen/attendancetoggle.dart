import 'package:bmitserp/model/month.dart';
import 'package:bmitserp/provider/attendancereportprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class AttendanceToggle extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AttendanceToggleState();
}

class AttendanceToggleState extends State<AttendanceToggle> {
  var initial = true;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AttendanceReportProvider>(context, listen: true);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Attendance History',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Consumer(
            builder: (context, value, child) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  items: (provider.month)
                      .map((item) => DropdownMenuItem<Month>(
                            value: item,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: provider.month[provider.selectedMonth],
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      provider.selectedMonth = (value as Month).index;
                      provider.getAttendanceReport();
                    });
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    iconEnabledColor: Colors.black,
                    iconDisabledColor: Colors.grey,
                  ),
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    width: 160,
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10)),
                      color: HexColor("#FFFFFF"),
                    ),
                    elevation: 2,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 200,
                    elevation: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      color: HexColor("#FFFFFF"),
                    ),
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
