import 'package:flutter/material.dart';
import 'package:stufast_mobile/models/hire_model.dart';
import 'package:stufast_mobile/pages/Hire/detail_hire_page.dart';
import 'package:stufast_mobile/theme.dart';

class HireTile extends StatelessWidget {
  HireModel? hire;
  HireTile(this.hire, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HireDetailPage(
                        hire,
                      )));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.network(
                      '${hire?.profilePicture}',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${hire?.fullname}',
                            style: primaryTextStyle.copyWith(
                                fontWeight: bold, fontSize: 15),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${hire?.position}',
                            style: primaryTextStyle.copyWith(fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${hire?.status}',
                            style: secondaryTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: hire?.result == 'pending'
                        ? Color(0xffFFCB42)
                        : hire?.result == 'accept'
                            ? primaryColor
                            : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('${hire?.result}',
                      style: buttonTextStyle.copyWith(fontWeight: bold)),
                )
              ],
            )),
      ),
    );
  }
}
