class InvoiceModel {
  String? fullname;
  String? email;
  String? phoneNumber;
  String? orderId;
  String? snapToken;
  String? userId;
  String? couponCode;
  String? discountPrice;
  String? subTotal;
  String? grossAmount;
  dynamic paymentType;
  dynamic bank;
  dynamic vaNumber;
  dynamic billKey;
  dynamic billerCode;
  dynamic urlSlip;
  String? transactionStatus;
  dynamic transactionId;
  DateTime? transactionTime;
  dynamic expiryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? rawPrice;
  int? tax;
  int? discountAmount;
  int? totalItem;
  List<Item>? item;

  InvoiceModel({
    this.fullname,
    this.email,
    this.phoneNumber,
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
    this.rawPrice,
    this.tax,
    this.discountAmount,
    this.totalItem,
    this.item,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        fullname: json["fullname"],
        email: json["email"],
        phoneNumber: json["phone_number"],
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
        expiryTime: json["expiry_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rawPrice: json["raw_price"],
        tax: json["tax"],
        discountAmount: json["discount_amount"],
        totalItem: json["total_item"],
        item: json["item"] == null
            ? []
            : List<Item>.from(json["item"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "phone_number": phoneNumber,
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
        "expiry_time": expiryTime,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "raw_price": rawPrice,
        "tax": tax,
        "discount_amount": discountAmount,
        "total_item": totalItem,
        "item": item == null
            ? []
            : List<dynamic>.from(item!.map((x) => x.toJson())),
      };
}

class Item {
  String? title;
  String? price;
  String? type;

  Item({
    this.title,
    this.price,
    this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        price: json["price"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "type": type,
      };
}
