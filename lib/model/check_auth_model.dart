// class CheckAuthModel {
//   bool? status;
//   dynamic message;
//   ResultData? result;

//   CheckAuthModel({this.status, this.message, this.result});

//   CheckAuthModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     result =
//         json['result'] != null ? new ResultData.fromJson(json['result']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.result != null) {
//       data['result'] = this.result!.toJson();
//     }
//     return data;
//   }
// }

// class ResultData {
//   UserDatas? userData;
//   dynamic userToken;
//   int? active_status;

//   ResultData({this.userData, this.userToken});

//   ResultData.fromJson(Map<String, dynamic> json) {
//     userData = json['userData'] != null
//         ? new UserDatas.fromJson(json['userData'])
//         : null;
//     userToken = json['user_token'];
//     active_status = json['active_status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.userData != null) {
//       data['userData'] = this.userData!.toJson();
//     }
//     data['user_token'] = this.userToken;
//     data['active_status'] = this.active_status;
//     return data;
//   }
// }

// class UserDatas {
//   int? id;
//   dynamic fullName;
//   dynamic mail;
//   dynamic contact;
//   dynamic gender;
//   dynamic dob;
//   dynamic userToken;
//   dynamic? avatar;


//   UserDatas(
//       {this.id,
//       this.fullName,
//       this.mail,
//       this.contact,
//       this.gender,
//       this.dob,
//       this.userToken,
//       this.avatar
//       });

//   UserDatas.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fullName = json['full_name'];
//     mail = json['mail'];
//     contact = json['contact'];
//     gender = json['gender'];
//     dob = json['dob'];
//     userToken = json['user_token'];
//     avatar = json['avatar'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['full_name'] = this.fullName;
//     data['mail'] = this.mail;
//     data['contact'] = this.contact;
//     data['gender'] = this.gender;
//     data['dob'] = this.dob;
//     data['user_token'] = this.userToken;
//      data['avatar'] = this.avatar;
//     return data;
//   }
// }

class CheckAuthModel {
  bool? status;
  dynamic message;
  ResultData? result;

  CheckAuthModel({this.status, this.message, this.result});

  CheckAuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new ResultData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ResultData {
  PunchData? punchData;
  UserDatas? userData;
  dynamic userToken;
  int? activeStatus;
  dynamic baseUrl;

  ResultData(
      {this.punchData,
      this.userData,
      this.userToken,
      this.activeStatus,
      this.baseUrl});

  ResultData.fromJson(Map<String, dynamic> json) {
    punchData = json['punchData'] != null
        ? new PunchData.fromJson(json['punchData'])
        : null;
    userData = json['userData'] != null
        ? new UserDatas.fromJson(json['userData'])
        : null;
    userToken = json['user_token'];
    activeStatus = json['active_status'];
    baseUrl = json['base_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.punchData != null) {
      data['punchData'] = this.punchData!.toJson();
    }
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    data['user_token'] = this.userToken;
    data['active_status'] = this.activeStatus;
    data['base_url'] = this.baseUrl;
    return data;
  }
}

class PunchData 
{
  dynamic punchInTime;
  dynamic? punchOutTime;
  dynamic totalWorkingHours;

  PunchData({this.punchInTime, this.punchOutTime, this.totalWorkingHours});

  PunchData.fromJson(Map<String, dynamic> json) {
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

class UserDatas {
  int? id;
  dynamic fullName;
  dynamic? avatar;
  dynamic mail;
  dynamic contact;
  dynamic gender;
  dynamic dob;
  dynamic userToken;

  UserDatas(
      {this.id,
      this.fullName,
      this.avatar,
      this.mail,
      this.contact,
      this.gender,
      this.dob,
      this.userToken});

  UserDatas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    avatar = json['avatar'];
    mail = json['mail'];
    contact = json['contact'];
    gender = json['gender'];
    dob = json['dob'];
    userToken = json['user_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['avatar'] = this.avatar;
    data['mail'] = this.mail;
    data['contact'] = this.contact;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['user_token'] = this.userToken;
    return data;
  }
}

