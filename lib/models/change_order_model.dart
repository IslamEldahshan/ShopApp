class ChangeOrderModel{
  bool? status;
  String? message;

  ChangeOrderModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}