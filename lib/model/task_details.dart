class TaskDetails 
{
  bool? status;
  String? message;
  Result? result;

  TaskDetails({this.status, this.message, this.result});

  TaskDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
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

class Result {
  int? id;
  String? taskName;
  String? startingDate;
  String? endingDate;
  String? taskDescription;
  int? isTargetProductDetails;
  List<TargetProductDetails>? targetProductDetails;

  Result(
      {this.id,
      this.taskName,
      this.startingDate,
      this.endingDate,
      this.taskDescription,
      this.isTargetProductDetails,
      this.targetProductDetails});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['task_name'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    taskDescription = json['task_description'];
    isTargetProductDetails = json['is_target_product_details'];
    if (json['target_product_details'] != null) {
      targetProductDetails = <TargetProductDetails>[];
      json['target_product_details'].forEach((v) {
        targetProductDetails!.add(new TargetProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['task_name'] = this.taskName;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['task_description'] = this.taskDescription;
    data['is_target_product_details'] = this.isTargetProductDetails;
    if (this.targetProductDetails != null) {
      data['target_product_details'] =
          this.targetProductDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TargetProductDetails {
  String? targetQuantity;
  String? productName;
  String? typeName;
  String? uomName;

  TargetProductDetails(
      {this.targetQuantity, this.productName, this.typeName, this.uomName});

  TargetProductDetails.fromJson(Map<String, dynamic> json) {
    targetQuantity = json['target_quantity'];
    productName = json['product_name'];
    typeName = json['type_name'];
    uomName = json['uom_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target_quantity'] = this.targetQuantity;
    data['product_name'] = this.productName;
    data['type_name'] = this.typeName;
    data['uom_name'] = this.uomName;
    return data;
  }
}
