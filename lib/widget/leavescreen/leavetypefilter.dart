import 'package:bmitserp/model/leave.dart';
import 'package:bmitserp/provider/leaveprovider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';


class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Filter> {
  Leave? selectedValue;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveProvider>(context);
    void onToggleChanged() async {
      final detailResponse = await provider.getLeaveTypeDetail();

      if (!mounted) return;
      // if (detailResponse.statusCode == 200) {
      //   if (detailResponse.data!.leaveList!.isEmpty) {
      //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //         behavior: SnackBarBehavior.floating,
      //         padding: EdgeInsets.all(20),
      //         content: Text('No data found')));
      //   }
      // }
      // else {
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       behavior: SnackBarBehavior.floating,
      //       padding: const EdgeInsets.all(20),
      //       content: Text(detailResponse.message!)));
      // }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Filter',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        // DropdownButtonHideUnderline(
        //   child: DropdownButton2(
        //     isExpanded: true,
        //     hint: Row(
        //       children: const [
        //         Icon(
        //           Icons.list,
        //           size: 16,
        //           color: Colors.black,
        //         ),
        //         SizedBox(
        //           width: 4,
        //         ),
        //         Expanded(
        //           child: Text(
        //             'Select Leave Type',
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //       ],
        //     ),
        //     items: provider.selectleaveList
        //         .where((element) => element.status)
        //         .map((item) => DropdownMenuItem<Leave>(
        //               value: item,
        //               child: Text(
        //                 item.name,
        //                 style: const TextStyle(
        //                   fontSize: 14,
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.black,
        //                 ),
        //                 overflow: TextOverflow.ellipsis,
        //               ),
        //             ))
        //         .toList(),
        //     value: selectedValue,
        //     onChanged: (value) {
        //       selectedValue = value as Leave?;
        //       if (selectedValue != null) {
        //         print("fjgklhfgkjh ${value!}");
        //         provider.setType(selectedValue!.id);
        //         onToggleChanged();
        //       }
        //     },
        //     icon: const Icon(
        //       Icons.arrow_forward_ios_outlined,
        //     ),
        //     iconSize: 14,
        //     iconEnabledColor: Colors.black,
        //     iconDisabledColor: Colors.grey,
        //     buttonHeight: 50,
        //     buttonWidth: 160,
        //     buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        //     buttonDecoration: BoxDecoration(
        //       borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(10),
        //           topRight: Radius.circular(0),
        //           bottomLeft: Radius.circular(0),
        //           bottomRight: Radius.circular(10)),
        //       color: HexColor("#FFFFFF"),
        //     ),
        //     buttonElevation: 0,
        //     itemHeight: 40,
        //     itemPadding: const EdgeInsets.only(left: 14, right: 14),
        //     dropdownMaxHeight: 200,
        //     dropdownPadding: null,
        //     dropdownDecoration: BoxDecoration(
        //       borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(0),
        //           topRight: Radius.circular(10),
        //           bottomLeft: Radius.circular(10),
        //           bottomRight: Radius.circular(10)),
        //       color: HexColor("#FFFFFF"),
        //     ),
        //     dropdownElevation: 8,
        //     scrollbarRadius: const Radius.circular(40),
        //     scrollbarThickness: 6,
        //     scrollbarAlwaysShow: true,
        //     offset: const Offset(0, 0),
        //   ),
        // ),

        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Select Leave Type',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: provider.selectleaveList
                .where((element) => element.status)
                .map((item) => DropdownMenuItem<Leave>(
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
            value: selectedValue,
            onChanged: (value) {
              selectedValue = value as Leave?;
              if (selectedValue != null) {
                provider.setType(selectedValue!.id);
                onToggleChanged();
                setState(() {});
              }
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
        )
      ],
    );
  }
}
