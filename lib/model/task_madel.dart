class TaskModel {
  int? status;
  String? message;
  List<TaskModelData>? result;

  TaskModel({this.status, this.message, this.result});

  TaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['result'] != null) {
      result = <TaskModelData>[];
      json['result'].forEach((v) {
        result!.add(new TaskModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskModelData {
  int? id;
  String? taskDate;
  String? taskDeadline;
  String? taskStatus;

  TaskModelData({this.id, this.taskDate, this.taskDeadline, this.taskStatus});

  TaskModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskDate = json['task_date'];
    taskDeadline = json['task_deadline'];
    taskStatus = json['task_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_date'] = this.taskDate;
    data['task_deadline'] = this.taskDeadline;
    data['task_status'] = this.taskStatus;
    return data;
  }
}
