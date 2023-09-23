class ChartModel {
  List<ItemChartModel>? item;
  dynamic coupon;
  int? subTotal;
  int? total;
  int? tax;

  ChartModel({
    this.item,
    this.coupon,
    this.subTotal,
    this.total,
    this.tax,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        item: json["item"] == null
            ? []
            : List<ItemChartModel>.from(
                json["item"]!.map((x) => ItemChartModel.fromJson(x))),
        coupon: json["coupon"],
        subTotal: json["sub_total"],
        total: json["total"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "item": item == null
            ? []
            : List<dynamic>.from(item!.map((x) => x.toJson())),
        "coupon": coupon,
        "sub_total": subTotal,
        "total": total,
        "tax": tax,
      };
}

class ItemChartModel {
  String? cartId;
  String? type;
  String? title;
  String? oldPrice;
  String? newPrice;
  String? thumbnail;
  int? totalItem;
  String? webinarTag;
  String? subTotal;

  ItemChartModel({
    this.cartId,
    this.type,
    this.title,
    this.oldPrice,
    this.newPrice,
    this.thumbnail,
    this.totalItem,
    this.webinarTag,
    this.subTotal,
  });

  factory ItemChartModel.fromJson(Map<String, dynamic> json) => ItemChartModel(
        cartId: json["cart_id"],
        type: json["type"],
        title: json["title"],
        oldPrice: json["old_price"],
        newPrice: json["new_price"],
        thumbnail: json["thumbnail"],
        totalItem: json["total_item"],
        webinarTag: json["webinar_tag"],
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "type": type,
        "title": title,
        "old_price": oldPrice,
        "new_price": newPrice,
        "thumbnail": thumbnail,
        "total_item": totalItem,
        "webinar_tag": webinarTag,
        "sub_total": subTotal,
      };
}
