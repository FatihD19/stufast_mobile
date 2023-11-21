import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stufast_mobile/providers/cv_provider.dart';
import 'package:stufast_mobile/theme.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import 'package:stufast_mobile/widget/username_textfield.dart';

import '../../models/cv_model.dart';

class EducationForm extends StatefulWidget {
  @override
  _EducationFormState createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final TextEditingController statusController = TextEditingController();
  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    clearController() {
      statusController.clear();
      schoolNameController.clear();
      majorController.clear();
      yearController.clear();
    }

    CvProvider cvProvider = Provider.of<CvProvider>(context);

    handleSubmitEducation() async {
      if (await cvProvider.updateCVeducation()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil update CV'),
            backgroundColor: Colors.green,
          ),
        );
        cvProvider.disposeAll();
        clearController();
        cvProvider.clearSelectedEducationIndex();
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
            value: statusController.text.isEmpty ? null : statusController.text,
            hint: Text('Pilih Status Pendidikan', style: primaryTextStyle),
            items: ['formal', 'informal']
                .map(
                  (status) => DropdownMenuItem(
                    child: Text(status, style: primaryTextStyle),
                    value: status,
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                statusController.text = value.toString();
              });
            },
          ),

          // DropdownButtonFormField(
          //   value: statusController.text.isEmpty ? null : statusController.text,
          //   hint: Text('Status'),
          //   items: ['formal', 'informal']
          //       .map(
          //         (status) => DropdownMenuItem(
          //           child: Text(status),
          //           value: status,
          //         ),
          //       )
          //       .toList(),
          //   onChanged: (value) {
          //     setState(() {
          //       statusController.text = value.toString();
          //     });
          //   },
          // ),
          SizedBox(height: 12),
          UsernameTextField(
            controller: schoolNameController,
            hintText: 'Nama Sekolah',
            type: 'Nama Sekolah',
          ),
          SizedBox(height: 12),
          UsernameTextField(
            controller: majorController,
            hintText: 'Jurusan',
            type: 'Jurusan',
          ),
          SizedBox(height: 12),
          UsernameTextField(
            controller: yearController,
            hintText: 'Tahun Lulus',
            type: 'Tahun Lulus',
          ),

          SizedBox(height: 20),

          Container(
            height: 50,
            width: double.infinity,
            child: PrimaryButton(
                text: 'Tambah Data Pendidikan',
                onPressed: () {
                  final education = Education(
                    status: statusController.text,
                    educationName: schoolNameController.text,
                    major: majorController.text,
                    year: yearController.text,
                  );
                  if (cvProvider.selectedEducationIndex == -1) {
                    // If no item is selected, add a new one
                    cvProvider.addEducation(education);
                    handleSubmitEducation();
                  } else {
                    // If an item is selected, edit it
                    cvProvider.editEducation(
                        cvProvider.selectedEducationIndex, education);
                    handleSubmitEducation();
                  }

                  // Clear the controllers
                }),
          ),
        ],
      );
    }

    Widget listEducation(String status) {
      return cvProvider.educations.isEmpty
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
              itemCount: cvProvider.educations.length,
              itemBuilder: (context, index) {
                final education = cvProvider.educations[index];
                if (education.status == status) {
                  return GestureDetector(
                    onTap: cvProvider.selectedEducationIndex == index
                        ? () {
                            cvProvider.clearSelectedEducationIndex();
                            clearController();
                          }
                        : () {
                            cvProvider.setSelectedEducationIndex(index);
                            statusController.text = education.status!;
                            schoolNameController.text =
                                education.educationName!;
                            majorController.text = education.major!;
                            yearController.text = education.year!;
                          },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            width: 2,
                            color: cvProvider.selectedEducationIndex == index
                                ? Colors.green
                                : Colors.white,
                          )),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        child: ListTile(
                            leading: Icon(Icons.school),
                            title: Text('${education.educationName}',
                                style: primaryTextStyle.copyWith(
                                    fontWeight: bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${education.major}',
                                    style: secondaryTextStyle.copyWith(
                                        fontWeight: semiBold)),
                                Text('Tahun Lulus : ${education.year}',
                                    style: thirdTextStyle),
                              ],
                            ),
                            trailing: InkWell(
                                onTap: () {
                                  cvProvider.deleteEducation(index);
                                  handleSubmitEducation();
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
                  Text('Data pendidikan Formal',
                      style: thirdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),
            listEducation('formal'),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text('Data pendidikan Informal',
                      style: thirdTextStyle.copyWith(
                          fontWeight: bold, fontSize: 16)),
                  SizedBox(height: 8),
                ],
              ),
            ),
            listEducation('informal'),
            SizedBox(height: 24),
            Container(
              child: Column(
                children: [
                  Text('Tambah data pendidikan',
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

// class EducationForm extends StatefulWidget {
//   @override
//   _EducationFormState createState() => _EducationFormState();
// }

// class _EducationFormState extends State<EducationForm> {
//   final List<Map<String, String>> educationList = [];
//   final TextEditingController statusController = TextEditingController();
//   final TextEditingController schoolNameController = TextEditingController();
//   final TextEditingController majorController = TextEditingController();
//   final TextEditingController yearController = TextEditingController();

//   int selectedEducationIndex = -1; // Index of the selected education

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           _buildForm(),
//           SizedBox(height: 20),
//           _buildEducationList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildForm() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         DropdownButtonFormField(
//           value: statusController.text.isEmpty ? null : statusController.text,
//           hint: Text('Status'),
//           items: ['Formal', 'Informal']
//               .map((status) => DropdownMenuItem(
//                     child: Text(status),
//                     value: status,
//                   ))
//               .toList(),
//           onChanged: (value) {
//             setState(() {
//               statusController.text = value.toString();
//             });
//           },
//         ),
//         TextFormField(
//           controller: schoolNameController,
//           decoration: InputDecoration(labelText: 'Nama Sekolah'),
//         ),
//         TextFormField(
//           controller: majorController,
//           decoration: InputDecoration(labelText: 'Jurusan'),
//         ),
//         TextFormField(
//           controller: yearController,
//           decoration: InputDecoration(labelText: 'Tahun Lulus'),
//           keyboardType: TextInputType.number,
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             _submitForm();
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }

//   Widget _buildEducationList() {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: educationList.length,
//         itemBuilder: (context, index) {
//           final education = educationList[index];
//           return GestureDetector(
//             onTap: () {
//               _editEducation(index, education);
//             },
//             child: Card(
//               margin: EdgeInsets.symmetric(vertical: 8),
//               color:
//                   selectedEducationIndex == index ? Colors.green : Colors.white,
//               child: ListTile(
//                   title: Text('${education['education_name']}'),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('${education['major']} - ${education['year']}'),
//                       Text('${education['status']}'),
//                     ],
//                   ),
//                   trailing: InkWell(
//                       onTap: () {
//                         setState(() {
//                           educationList.removeAt(index);
//                           print("Data Education List:");
//                           for (var education in educationList) {
//                             print(education);
//                           }
//                         });
//                       },
//                       child: Icon(Icons.delete))),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   void _submitForm() {
//     if (_validateForm()) {
//       setState(() {
//         if (selectedEducationIndex == -1) {
//           // If no item is selected, add a new one
//           educationList.add({
//             'status': statusController.text,
//             'education_name': schoolNameController.text,
//             'major': majorController.text,
//             'year': yearController.text,
//           });
//         } else {
//           // If an item is selected, edit it
//           educationList[selectedEducationIndex] = {
//             'status': statusController.text,
//             'education_name': schoolNameController.text,
//             'major': majorController.text,
//             'year': yearController.text,
//           };

//           // Reset selected index after editing
//           selectedEducationIndex = -1;
//         }
//         print("Data Education List:");
//         for (var education in educationList) {
//           print(education);
//         }
//         // Clear the controllers
//         statusController.clear();
//         schoolNameController.clear();
//         majorController.clear();
//         yearController.clear();
//       });
//     }
//   }

//   bool _validateForm() {
//     if (statusController.text.isEmpty ||
//         schoolNameController.text.isEmpty ||
//         majorController.text.isEmpty ||
//         yearController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Semua field harus diisi'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }
//     return true;
//   }

//   void _editEducation(int index, Map<String, String> education) {
//     // Set the controllers with the selected education data
//     statusController.text = education['status']!;
//     schoolNameController.text = education['education_name']!;
//     majorController.text = education['major']!;
//     yearController.text = education['year']!;

//     // Set the selected index
//     setState(() {
//       print("Data Education List:");
//       for (var education in educationList) {
//         print(education);
//       }
//       selectedEducationIndex = index;
//     });
//   }
// }
