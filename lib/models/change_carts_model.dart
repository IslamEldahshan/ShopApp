class ChangeCartsModel{
  int? productId;
  ChangeCartsModel.fromJson(Map<String,dynamic> json){
    productId = json['product_id'];
  }
}