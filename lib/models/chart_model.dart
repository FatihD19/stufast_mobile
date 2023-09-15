import 'package:stufast_mobile/models/bundling_model.dart';
import 'package:stufast_mobile/models/course_model.dart';
import 'package:stufast_mobile/models/webinar_model.dart';

class ChartModel {
  String? cartId;
  CourseModel? course;
  BundlingModel? bundling;
  WebinarModel? webinar;
  String? subTotal;

  ChartModel({
    this.cartId,
    this.course,
    this.bundling,
    this.webinar,
    this.subTotal,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) => ChartModel(
        cartId: json["cart_id"],
        course: json["course"] == null
            ? null
            : CourseModel.fromJson(json["course"]),
        bundling: json["bundling"] == null
            ? null
            : BundlingModel.fromJson(json["bundling"]),
        webinar: json["webinar"] == null
            ? null
            : WebinarModel.fromJson(json["webinar"]),
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "course": course?.toJson(),
        "bundling": bundling?.toJson(),
        "webinar": webinar?.toJson(),
        "sub_total": subTotal,
      };
}
