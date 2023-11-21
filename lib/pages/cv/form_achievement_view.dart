import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/cv_model.dart';
import '../../providers/cv_provider.dart';
import '../../theme.dart';
import '../../widget/primary_button.dart';
import '../../widget/username_textfield.dart';

class AchievementForm extends StatefulWidget {
  const AchievementForm({super.key});

  @override
  State<AchievementForm> createState() => _AchievementFormState();
}

class _AchievementFormState extends State<AchievementForm> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  clearController() {
    eventNameController.clear();
    positionController.clear();
    yearController.clear();
  }

  @override
  Widget build(BuildContext context) {
    CvProvider cvProvider = Provider.of<CvProvider>(context);

    handleSubmitAchievement() async {
      if (await cvProvider.updateCvAchievement()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil update CV'),
            backgroundColor: Colors.green,
          ),
        );
        cvProvider.disposeAll();
        clearController();
        cvProvider.clearSelectedAchievementIndex();
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
          UsernameTextField(
            controller: eventNameController,
            hintText: 'Nama Event',
            type: 'Nama Event',
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
                  text: 'Tambah Data Prestasi',
                  onPressed: () {
                    final ach = Achievement(
                      eventName: eventNameController.text,
                      position: positionController.text,
                      year: yearController.text,
                    );
                    if (cvProvider.selectedAchIndex == -1) {
                      cvProvider.addAchievement(ach);
                      handleSubmitAchievement();
                    } else {
                      cvProvider.editAchievement(
                          cvProvider.selectedAchIndex, ach);
                      handleSubmitAchievement();
                    }
                  })),
        ],
      );
    }

    Widget listAchievement() {
      return cvProvider.achs.isEmpty
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
              itemCount: cvProvider.achs.length,
              itemBuilder: (context, index) {
                final ach = cvProvider.achs[index];
                return GestureDetector(
                  onTap: cvProvider.selectedAchIndex == index
                      ? () {
                          cvProvider.clearSelectedAchievementIndex();
                          clearController();
                        }
                      : () {
                          cvProvider.setSelectedAchievementIndex(index);
                          eventNameController.text = ach.eventName!;
                          positionController.text = ach.position!;
                          yearController.text = ach.year!;
                        },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          width: 2,
                          color: cvProvider.selectedAchIndex == index
                              ? Colors.green
                              : Colors.white,
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: ListTile(
                          leading:
                              Icon(Icons.playlist_add_check_circle_rounded),
                          title: Text('${ach.eventName}',
                              style:
                                  primaryTextStyle.copyWith(fontWeight: bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${ach.position}',
                                  style: secondaryTextStyle.copyWith(
                                      fontWeight: semiBold)),
                              Text('Tahun : ${ach.year}',
                                  style: thirdTextStyle),
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                cvProvider.deleteAchievement(index);
                                handleSubmitAchievement();
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))),
                    ),
                  ),
                );
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
                  Text('Prestasi',
                      style: thirdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),
            listAchievement(),
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
