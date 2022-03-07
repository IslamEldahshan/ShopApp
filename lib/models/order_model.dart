class OrderModel {
  bool? status;
  DataModel? data;

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  DataModel.fromJson(json['data']) : null;
  }
}

class DataModel {
  List<Data>? data;
  dynamic total;

  DataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class Data {
  int? id;
  dynamic total;
  String? date;
  String? status;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    date = json['date'];
    status = json['status'];
  }
}












// class OrderModel{
//   bool? status;
//   Data? data;
//
//   OrderModel.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     data = json['data'];
//   }
// }
//
// class OrderDataModel{
//   List data = [];
//   int? total;
//
//   OrderDataModel.fromJason(Map<String, dynamic> json){
//     total = json['total'];
//     json['data'].forEach((v){
//       data.add(Data.fromJson(v));
//     });
//   }
// }
//
// class Data{
//   String? status;
//   int? id;
//   dynamic total;
//   String? date;
//
//   Data.fromJson(Map<String, dynamic> json){
//     status = json['status'];
//     id = json['id'];
//     total = json['total'];
//     date = json['date'];
//   }
// }