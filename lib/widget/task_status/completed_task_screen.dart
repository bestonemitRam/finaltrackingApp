import 'package:bmitserp/provider/taskprovider.dart';
import 'package:bmitserp/utils/check_internet_connectvity.dart';
import 'package:bmitserp/widget/task_status/pending_task_widegt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  MyTaskProvider _myTaskProvider = MyTaskProvider();
  @override
  void initState() 
  {
   super.initState();
    _myTaskProvider = Provider.of<MyTaskProvider>(context, listen: false);
    _myTaskProvider.getMyTask();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<InternetConnectionStatus>(context) ==
            InternetConnectionStatus.disconnected
        ? InternetNotAvailable()
        : Consumer<MyTaskProvider>(builder: (context, provider, child) {
            if (provider.allDataCompletedlist.isNotEmpty) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 1.h, bottom: 4.h, left: 3.w, right: 3.w),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: provider.allDataCompletedlist.length,
                          itemBuilder: (context, index) {
                            final data = provider.allDataCompletedlist[index];
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                          child: PendingTaskWidget(
                                              data: data, type: true))
                                    ],
                                  ),
                                ));
                          })),
                ),
              );
            } else {
              if (provider.datanotfound == false) {
                return SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                  color: Colors.white,
                )));
              } else {
                return Center(
                  child: Container(
                    child: Text(
                      "Sorry! Don't have a task ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
            }
          });
  }
}
