import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/cv_model.dart';
import 'package:stufast_mobile/providers/cv_provider.dart';
import 'package:stufast_mobile/theme.dart';
// ignore: depend_on_referenced_packages
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:stufast_mobile/widget/primary_button.dart';
import '../../widget/username_textfield.dart';
import '../Task/file_view.dart';

class DataPersonalView extends StatefulWidget {
  CVmodel cv;
  DataPersonalView(this.cv, {super.key});

  @override
  State<DataPersonalView> createState() => _DataPersonalViewState();
}

class _DataPersonalViewState extends State<DataPersonalView> {
  File? _selectedFile;
  bool? readyUpload = false;
  String? selectedNameFile;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        selectedNameFile = result.files.single.name;
        readyUpload = true;
      });
    } else {
      // User canceled the picker
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('batal upload tugas'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void clearTaskFile() {
    setState(() {
      _selectedFile = null;
      selectedNameFile = null;
      readyUpload = false;
    });
  }

  TextEditingController _aboutMeController = TextEditingController();
  TextEditingController _instagramController = TextEditingController();
  TextEditingController _facebookController = TextEditingController();
  TextEditingController _linkedinController = TextEditingController();

  String? selectedJobType;
  String? selectedWorkMethod;
  @override
  void initState() {
    // TODO: implement initState
    _aboutMeController.text = '${widget.cv.about}';
    _instagramController.text = '${widget.cv.instagram}';
    _facebookController.text = '${widget.cv.facebook}';
    _linkedinController.text = '${widget.cv.linkedin}';
    selectedJobType = widget.cv.status == ""
        ? 'Pegawai Tetap atau Freelance'
        : widget.cv.status;
    selectedWorkMethod =
        widget.cv.method == "" ? 'Remote atau WFO' : widget.cv.method;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CvProvider cv = Provider.of<CvProvider>(context);

    getCv() async {
      await cv.getCV();
      setState(() {
        widget.cv = cv.cv!;
      });
    }

    handleUpdateCv() async {
      if (await cv.updateCV(
          about: _aboutMeController.text,
          instagram: _instagramController.text,
          facebook: _facebookController.text,
          linkedin: _linkedinController.text,
          status: selectedJobType,
          method: selectedWorkMethod)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil mengubah data diri'),
            backgroundColor: Colors.green,
          ),
        );
        getCv();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengubah data diri'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    handleUploadPortofolio() async {
      if (await cv.uploadPortofolio('${widget.cv.id}', _selectedFile!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Berhasil mengunggah portofolio'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengunggah portofolio'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Widget dataDiri() {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text('Data Diri',
                style: thirdTextStyle.copyWith(fontWeight: semiBold)),
            children: [
              CircleAvatar(
                radius: 40,
                child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('${widget.cv.profilePicture}'),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    UsernameTextField(
                      hintText: '${widget.cv.fullname}',
                      type: 'Nama',
                      readOnly: true,
                    ),
                    SizedBox(height: 24),
                    UsernameTextField(
                      hintText: '${widget.cv.phoneNumber}',
                      type: 'Nomor Hp',
                      readOnly: true,
                    ),
                    SizedBox(height: 24),
                    UsernameTextField(
                      hintText: '${widget.cv.address}',
                      type: 'Alamat',
                      readOnly: true,
                    ),
                    SizedBox(height: 24),
                    UsernameTextField(
                      hintText: '${widget.cv.dateBirth}'
                          .replaceAll('00:00:00.000', ''),
                      type: 'Tanggal Lahir',
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white, // Latar belakang putih
                          onPrimary: Color(
                              0xFF164520), // Warna teks saat di atas latar putih
                          side: BorderSide(
                              color: Color(0xFF164520),
                              width:
                                  2), // Border berwarna 248043 dengan lebar 2
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius 10
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit-profile');
                        },
                        child: Text(
                          'Edit Data Diri',
                          style: thirdTextStyle.copyWith(fontWeight: bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 16)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget uploadTask() {
      return Container(
        margin: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffD2D2D2), width: 2),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Color(0xffFD9D9D9),
              width: double.infinity,
              height: 55,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Unggah Portofolio',
                      textAlign: TextAlign.center,
                      style: primaryTextStyle.copyWith(
                          fontWeight: bold, fontSize: 18)),
                  widget.cv.portofolio == ""
                      ? SizedBox()
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FileView('${widget.cv.portofolio}')),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.remove_red_eye, color: primaryColor),
                              SizedBox(width: 5),
                              Text('lihat',
                                  style: thirdTextStyle.copyWith(
                                      fontWeight: bold)),
                            ],
                          ),
                        )
                ],
              ),
            ),
            SizedBox(height: 18),
            GestureDetector(
              onTap: _pickFile,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(13),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD2D2D2), width: 2),
                  ),
                  child: Text(selectedNameFile ?? 'Klik untuk mengunggah file',
                      style: primaryTextStyle.copyWith(fontWeight: semiBold)),
                ),
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffE9E9E9)),
                      onPressed: clearTaskFile,
                      child: Text('Batal',
                          style: primaryTextStyle.copyWith(fontWeight: bold))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: readyUpload == false
                          ? null
                          : () {
                              handleUploadPortofolio();
                            },
                      child: Text('Kirim',
                          style: buttonTextStyle.copyWith(fontWeight: bold))),
                ],
              ),
            ),
            SizedBox(height: 18),
          ],
        ),
      );
    }

    Widget aboutMe() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            "Tentang Saya",
            style: primaryTextStyle.copyWith(fontWeight: semiBold),
          ),
          SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 380,
              maxHeight: 188,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFAFAFA), // Warna latar belakang FAFAFA
                border: Border.all(
                  color: Color(0xFFD2D2D2),
                  width: 1, // Border dengan stroke D2D2D2
                ),
                borderRadius: BorderRadius.circular(8), // Border radius 8
              ),
              child: TextField(
                maxLines: 5,
                controller: _aboutMeController,
                decoration: InputDecoration(
                  hintText: '${widget.cv.about}',
                  hintStyle: secondaryTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  border: InputBorder
                      .none, // Tidak menampilkan border bawaan TextField
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget typeWork() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jenis Pekerjaan',
                style: thirdTextStyle.copyWith(fontWeight: bold, fontSize: 18),
              ),
              SizedBox(height: 8),
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
                hint: Text(
                  "Pilih Jenis Pekerjaan",
                  style: TextStyle(fontSize: 16),
                ),
                value: selectedJobType,
                items: [
                  'Freelance',
                  'Pegawai Tetap',
                  'Pegawai Tetap atau Freelance'
                ].map((item) {
                  return DropdownMenuItem(
                    child: Text(item, style: TextStyle(fontSize: 16)),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  selectedJobType = value!;
                },
              ),
              // Container(
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 140,
              //         decoration: BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Row(
              //           children: [
              //             Radio<String>(
              //               fillColor:
              //                   MaterialStateProperty.all<Color>(Colors.white),
              //               value: 'Freelance',
              //               groupValue: selectedJobType,
              //               onChanged: (value) {
              //                 setState(() {
              //                   selectedJobType = value;
              //                 });
              //               },
              //             ),
              //             Text('Freelance', style: buttonTextStyle),
              //             SizedBox(width: 5)
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       Container(
              //         width: 140,
              //         decoration: BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.circular(8),
              //         ),
              //         child: Row(
              //           children: [
              //             Radio<String>(
              //               fillColor:
              //                   MaterialStateProperty.all<Color>(Colors.white),
              //               value: 'Tetap',
              //               groupValue: selectedJobType,
              //               onChanged: (value) {
              //                 setState(() {
              //                   selectedJobType = value;
              //                 });
              //               },
              //             ),
              //             Text('Tetap', style: buttonTextStyle),
              //             SizedBox(width: 5)
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 16),

              // Metode Kerja
              Text(
                'Metode Kerja',
                style: thirdTextStyle.copyWith(fontWeight: bold, fontSize: 18),
              ),
              SizedBox(height: 8),
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
                hint: Text(
                  "Pilih Metode Kerja",
                  style: TextStyle(fontSize: 16),
                ),
                value: selectedWorkMethod,
                items: ['Remote', 'WFO', 'Remote atau WFO'].map((item) {
                  return DropdownMenuItem(
                    child: Text(item, style: TextStyle(fontSize: 16)),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  selectedWorkMethod = value!;
                },
              ),
            ],
          ),
        ],
      );
    }

    Widget medSos() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18),
          Text('Media Sosial',
              style: thirdTextStyle.copyWith(fontWeight: bold, fontSize: 18)),
          SizedBox(height: 14),
          UsernameTextField(
            controller: _instagramController,
            hintText: '${widget.cv.instagram}',
            type: 'Instagram',
          ),
          SizedBox(height: 24),
          UsernameTextField(
            controller: _facebookController,
            hintText: '${widget.cv.facebook}',
            type: 'Facebook',
          ),
          SizedBox(height: 24),
          UsernameTextField(
            controller: _linkedinController,
            hintText: '${widget.cv.linkedin}',
            type: 'Linkedin',
          ),
          SizedBox(height: 24),
        ],
      );
    }

    Widget submit() {
      return Column(
        children: [
          Container(
              width: double.infinity,
              height: 54,
              child: PrimaryButton(text: 'Simpan', onPressed: handleUpdateCv)),
        ],
      );
    }

    return Container(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            SizedBox(height: 8),
            dataDiri(),
            aboutMe(),
            typeWork(),
            uploadTask(),
            medSos(),
            submit(),
          ],
        ));
  }
}
