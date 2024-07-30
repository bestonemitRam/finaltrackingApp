class NotificationResponse {
  bool? status;
  dynamic? message;
  List<NotificationData>? result;

  NotificationResponse({this.status, this.message, this.result});

  NotificationResponse.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <NotificationData>[];
      json['result'].forEach((v) {
        result!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData{
  int? id;
  dynamic? notificationTitle;
  dynamic? notificationType;
  int? notificationId;
  int? readStatus;
  dynamic? createdAt;

  NotificationData(
      {this.id,
      this.notificationTitle,
      this.notificationType,
      this.notificationId,
      this.readStatus,
      this.createdAt});

  NotificationData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    notificationTitle = json['notification_title'];
    notificationType = json['notification_type'];
    notificationId = json['notification_id'];
    readStatus = json['read_status'];
    createdAt = json['created_at'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['notification_title'] = this.notificationTitle;
    data['notification_type'] = this.notificationType;
    data['notification_id'] = this.notificationId;
    data['read_status'] = this.readStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
