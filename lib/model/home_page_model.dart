
class HomeScreenModel 
{
  bool? status;
  String? message;
  HomeData? data;

  HomeScreenModel({this.status, this.message, this.data});

  HomeScreenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['result'] != null ? new HomeData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['result'] = this.data!.toJson();
    }
    return data;
  }
}

class HomeData
 {
  int? presentCount;
  int? holidayCount;
  OfficeTime? officeTime;
  EmployeeAttendanceData? punchData;
  int? taskCount;
  int? leaveCount;

  HomeData(
      {this.presentCount,
      this.holidayCount,
      this.officeTime,
      this.punchData,
      this.taskCount,
      this.leaveCount});

  HomeData.fromJson(Map<String, dynamic> json) {
    presentCount = json['presentCount'];
    holidayCount = json['holidayCount'];
    officeTime = json['officeTime'] != null
        ? new OfficeTime.fromJson(json['officeTime'])
        : null;
    punchData = json['punch_data'] != null
        ? new EmployeeAttendanceData.fromJson(json['punch_data'])
        : null;
    taskCount = json['taskCount'];
    leaveCount = json['leaveCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['presentCount'] = this.presentCount;
    data['holidayCount'] = this.holidayCount;
    if (this.officeTime != null) {
      data['officeTime'] = this.officeTime!.toJson();
    }
    if (this.punchData != null) {
      data['punch_data'] = this.punchData!.toJson();
    }
    data['taskCount'] = this.taskCount;
    data['leaveCount'] = this.leaveCount;
    return data;
  }
}

class OfficeTime {
  String? startTime;
  String? endTime;

  OfficeTime({this.startTime, this.endTime});

  OfficeTime.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    return data;
  }
}

class EmployeeAttendanceData {
  String? punchInTime;
  String? punchOutTime;
  String? totalWorkingHours;

  EmployeeAttendanceData({this.punchInTime, this.punchOutTime, this.totalWorkingHours});

  EmployeeAttendanceData.fromJson(Map<String, dynamic> json) {
    punchInTime = json['punch_in_time'];
    punchOutTime = json['punch_out_time'];
    totalWorkingHours = json['total_working_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['punch_in_time'] = this.punchInTime;
    data['punch_out_time'] = this.punchOutTime;
    data['total_working_hours'] = this.totalWorkingHours;
    return data;
  }
}

