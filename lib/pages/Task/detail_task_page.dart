// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stufast_mobile/models/task_model.dart';
import 'package:stufast_mobile/pages/Task/file_view.dart';
import 'package:stufast_mobile/providers/task_provider.dart';

import '../../theme.dart';

class DetailTaskPage extends StatefulWidget {
  TaskModel task;
  String courseId;
  DetailTaskPage(this.task, this.courseId, {super.key});

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  File? _selectedFile;
  String? selectedNameFile;
  bool? readyUpload = false;

  @override
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<TaskProvider>(context, listen: false)
        .getTasks(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
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

    handleUploadTask() async {
      if (await taskProvider.uploadTask(
          '${widget.task.videoId}', _selectedFile!)) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            title: 'Berhasil',
            desc: 'Anda telah menyelesaikan tugas',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
          ).show();
        });
        getInit();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengunggah tugas'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Widget task() {
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffF3F3F3),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.task.title}',
                    style: primaryTextStyle.copyWith(fontSize: 16)),
                SizedBox(height: 5),
                Text('${widget.task.task}',
                    style: primaryTextStyle.copyWith(fontWeight: bold)),
                SizedBox(height: 5),
                Text(
                    '"Untuk menyelesaikan tugas ini, submit hasil pekerjaan Anda di bawah ini."',
                    textAlign: TextAlign.justify,
                    style: secondaryTextStyle.copyWith(fontWeight: bold)),
              ],
            ),
          ),
        ),
      );
    }

    Widget viewFile() {
      return widget.task.status == 'Belum dikumpulkan'
          ? SizedBox()
          : Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListTile(
                leading:
                    Icon(Icons.bookmark_border_outlined, color: primaryColor),
                title: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Status : ',
                        style: primaryTextStyle.copyWith(fontWeight: medium)),
                    TextSpan(
                        text: '${widget.task.status}',
                        style: primaryTextStyle.copyWith(fontWeight: bold)),
                  ]),
                ),
                subtitle: Text('${widget.task.date}',
                    style: secondaryTextStyle.copyWith(fontWeight: medium)),
                trailing: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FileView('${widget.task.taskFile}')),
                      );
                    },
                    child: Icon(Icons.remove_red_eye_outlined,
                        color: primaryColor)),
              ));
    }

    Widget uploadTask() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffD2D2D2), width: 2),
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Color(0xffFD9D9D9),
              width: double.infinity,
              height: 55,
              child: Text('Unggah File',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle.copyWith(
                      fontWeight: bold, fontSize: 18)),
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
                              handleUploadTask();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tugas',
          style: primaryTextStyle.copyWith(fontWeight: semiBold),
        ),
        elevation: 0, // Menghilangkan shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              task(),
              viewFile(),
              SizedBox(height: 20),
              uploadTask(),
            ],
          ),
        ),
      ),
    );
  }
}
