import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/providers/cv_provider.dart';

import '../../theme.dart';
import '../../widget/primary_button.dart';
import '../../widget/username_textfield.dart';

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({super.key});

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController instanceNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  clearController() {
    typeController.clear();
    instanceNameController.clear();
    positionController.clear();
    yearController.clear();
  }

  @override
  Widget build(BuildContext context) {
    CvProvider cvProvider = Provider.of<CvProvider>(context);

    handleSubmitExperience() async {
      if (await cvProvider.updateCvExperience()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil update CV'),
            backgroundColor: Colors.green,
          ),
        );
        cvProvider.disposeAll();
        clearController();
        cvProvider.clearSelectedExperienceIndex();
        cvProvider.getCV();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal update CV'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Widget form() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField2(
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 24,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
            ),
            value: typeController.text.isEmpty ? null : typeController.text,
            hint: Text('Pekerjaan atau Organization', style: primaryTextStyle),
            items: ['job', 'organization']
                .map(
                  (status) => DropdownMenuItem(
                    child: Text(status, style: primaryTextStyle),
                    value: status,
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                typeController.text = value.toString();
              });
            },
          ),
          SizedBox(height: 12),
          UsernameTextField(
            controller: instanceNameController,
            hintText: 'Nama Instansi',
            type: 'Nama Instansi',
          ),
          SizedBox(height: 12),
          UsernameTextField(
            controller: positionController,
            hintText: 'Posisi',
            type: 'Posisi',
          ),
          SizedBox(height: 12),
          UsernameTextField(
            controller: yearController,
            hintText: 'Tahun',
            type: 'Tahun',
          ),
          SizedBox(height: 20),
          Container(
              height: 50,
              width: double.infinity,
              child: PrimaryButton(
                  text: 'Tambah Data Pengalaman',
                  onPressed: () {
                    final exp = Job(
                      type: typeController.text,
                      instanceName: instanceNameController.text,
                      position: positionController.text,
                      year: yearController.text,
                    );
                    if (cvProvider.selectedExpIndex == -1) {
                      cvProvider.addExperience(exp);
                      handleSubmitExperience();
                      // Clear the controllers
                    } else {
                      cvProvider.editExperience(
                          cvProvider.selectedExpIndex, exp);
                      handleSubmitExperience();
                    }
                  })),
        ],
      );
    }

    Widget listExperience(String type) {
      return cvProvider.exps.isEmpty
          ? Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      title: Container(
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                      trailing: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cvProvider.exps.length,
              itemBuilder: (context, index) {
                final exp = cvProvider.exps[index];
                if (exp.type == type) {
                  return GestureDetector(
                    onTap: cvProvider.selectedExpIndex == index
                        ? () {
                            cvProvider.clearSelectedExperienceIndex();
                            clearController();
                          }
                        : () {
                            cvProvider.setSelectedExperienceIndex(index);
                            typeController.text = exp.type!;
                            instanceNameController.text = exp.instanceName!;
                            positionController.text = exp.position!;
                            yearController.text = exp.year!;
                          },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            width: 2,
                            color: cvProvider.selectedExpIndex == index
                                ? Colors.green
                                : Colors.white,
                          )),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        child: ListTile(
                            leading: type == 'job'
                                ? Icon(Icons.work_rounded)
                                : Icon(Icons.supervised_user_circle_rounded),
                            title: Text('${exp.instanceName}',
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${exp.position}',
                                    style: secondaryTextStyle.copyWith(
                                        fontWeight: semiBold)),
                                Text('Tahun Lulus : ${exp.year}',
                                    style: thirdTextStyle),
                              ],
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  cvProvider.deleteExperience(index);
                                  handleSubmitExperience();
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text('Pengalaman Kerja',
                      style: thirdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),
            listExperience('job'),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text('Pengalaman Organisasi',
                      style: thirdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),
            listExperience('organization'),
            SizedBox(height: 24),
            Container(
              child: Column(
                children: [
                  Text('Tambah data Pengalaman',
                      style: thirdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),

            form(),
            // listDataEducation(),
          ],
        ),
      ),
    );
  }
}
