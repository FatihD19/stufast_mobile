class OrderHistoryModel {
  String? orderId;
  String? snapToken;
  String? userId;
  String? couponCode;
  String? discountPrice;
  String? subTotal;
  String? grossAmount;
  String? paymentType;
  String? bank;
  dynamic vaNumber;
  String? billKey;
  String? billerCode;
  String? urlSlip;
  String? transactionStatus;
  String? transactionId;
  DateTime? transactionTime;
  DateTime? expiryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? totalItem;
  List<Item>? item;

  OrderHistoryModel({
    this.orderId,
    this.snapToken,
    this.userId,
    this.couponCode,
    this.discountPrice,
    this.subTotal,
    this.grossAmount,
    this.paymentType,
    this.bank,
    this.vaNumber,
    this.billKey,
    this.billerCode,
    this.urlSlip,
    this.transactionStatus,
    this.transactionId,
    this.transactionTime,
    this.expiryTime,
    this.createdAt,
    this.updatedAt,
    this.totalItem,
    this.item,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
        orderId: json["order_id"],
        snapToken: json["snap_token"],
        userId: json["user_id"],
        couponCode: json["coupon_code"],
        discountPrice: json["discount_price"],
        subTotal: json["sub_total"],
        grossAmount: json["gross_amount"],
        paymentType: json["payment_type"],
        bank: json["bank"],
        vaNumber: json["va_number"],
        billKey: json["bill_key"],
        billerCode: json["biller_code"],
        urlSlip: json["url_slip"],
        transactionStatus: json["transaction_status"],
        transactionId: json["transaction_id"],
        transactionTime: json["transaction_time"] == null
            ? null
            : DateTime.parse(json["transaction_time"]),
        expiryTime: json["expiry_time"] == null
            ? null
            : DateTime.parse(json["expiry_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        totalItem: json["total_item"],
        item: json["item"] == null
            ? []
            : List<Item>.from(json["item"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "snap_token": snapToken,
        "user_id": userId,
        "coupon_code": couponCode,
        "discount_price": discountPrice,
        "sub_total": subTotal,
        "gross_amount": grossAmount,
        "payment_type": paymentType,
        "bank": bank,
        "va_number": vaNumber,
        "bill_key": billKey,
        "biller_code": billerCode,
        "url_slip": urlSlip,
        "transaction_status": transactionStatus,
        "transaction_id": transactionId,
        "transaction_time": transactionTime?.toIso8601String(),
        "expiry_time": expiryTime?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "total_item": totalItem,
        "item": item == null
            ? []
            : List<dynamic>.from(item!.map((x) => x.toJson())),
      };
}

class Item {
  String? title;
  String? thumbnail;
  String? type;

  Item({
    this.title,
    this.thumbnail,
    this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        thumbnail: json["thumbnail"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumbnail": thumbnail,
        "type": type,
      };
}
