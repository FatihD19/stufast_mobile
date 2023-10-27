class OrderModel {
  DataOrder? dataOrder;
  String? type;
  List<DataOrderCourse>? dataOrderCourse;
  String? token;

  OrderModel({
    this.dataOrder,
    this.type,
    this.dataOrderCourse,
    this.token,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        dataOrder: json["data_order"] == null
            ? null
            : DataOrder.fromJson(json["data_order"]),
        type: json["type"],
        dataOrderCourse: json["data_order_course"] == null
            ? []
            : List<DataOrderCourse>.from(json["data_order_course"]!
                .map((x) => DataOrderCourse.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data_order": dataOrder?.toJson(),
        "type": type,
        "data_order_course": dataOrderCourse == null
            ? []
            : List<dynamic>.from(dataOrderCourse!.map((x) => x.toJson())),
        "token": token,
      };
}

class DataOrder {
  int? orderId;
  String? userId;
  dynamic couponCode;
  dynamic discountPrice;
  int? subTotal;
  int? grossAmount;
  String? transactionStatus;

  DataOrder({
    this.orderId,
    this.userId,
    this.couponCode,
    this.discountPrice,
    this.subTotal,
    this.grossAmount,
    this.transactionStatus,
  });

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        orderId: json["order_id"],
        userId: json["user_id"],
        couponCode: json["coupon_code"],
        discountPrice: json["discount_price"],
        subTotal: json["sub_total"],
        grossAmount: json["gross_amount"],
        transactionStatus: json["transaction_status"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "user_id": userId,
        "coupon_code": couponCode,
        "discount_price": discountPrice,
        "sub_total": subTotal,
        "gross_amount": grossAmount,
        "transaction_status": transactionStatus,
      };
}

class DataOrderCourse {
  int? orderId;
  String? courseId;

  DataOrderCourse({
    this.orderId,
    this.courseId,
  });

  factory DataOrderCourse.fromJson(Map<String, dynamic> json) =>
      DataOrderCourse(
        orderId: json["order_id"],
        courseId: json["course_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "course_id": courseId,
      };
}
