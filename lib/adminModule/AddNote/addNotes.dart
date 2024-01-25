import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);


class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  File? selectedFile;
  List<String> Studentyear = [
    "First Year",
    "Second Year",
    "Third Year"
  ];
  List<String> Studentclass = [
    "Civil",
    "Auto Mobile",
    "Copa"
  ];
  List<String> Subject = [
    "Cad",
    "Auto Mobile",
    "Es"
  ];
  String? selectedSyear;
  String? selectedSclass;
  String? selectedSsub;
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Add other allowed extensions if needed
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadFile() async {
    if (selectedFile == null) {
      // Handle case where no file is selected
      return;
    }

    try {
      Reference storageReference = FirebaseStorage.instance.ref().child('Notes/${DateTime.now()}.pdf');
      UploadTask uploadTask = storageReference.putFile(selectedFile!);

      await uploadTask.whenComplete(() => print('File Uploaded'));

      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();

      // Now you can use the download URL as needed (e.g., store it in the database)
      print('Download URL: $downloadURL');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedFile == null
                  ? Row(
                    children: [
                      Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: const Text('Choose pdf file '),
                      )),
                      Expanded(
                        child: MyButton(btnname: "Pick Pdf", btncolor: white, click: (){
                          pickFile();
                        }, bordercolor: customBalck, txtcolor: customBalck),
                      ),
                    ],
                  )
                  : Row(
                    children: [
                      Expanded(
                        child: Card(child: Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: Text('Selected File: ${selectedFile!.path}'),
                        )),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20).r,
                          child: MyButton(btnname: "Pick Pdf", btncolor: white, click: (){
                            pickFile();
                          }, bordercolor: customBalck, txtcolor: customBalck),
                        ),
                      ),
                    ],
                  ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6).r,
                  border: Border.all(color: customBalck),
                  color: white,
                ),
                child: DropdownButtonFormField(
                  hint: const Text("Select year"),
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  items: Studentyear
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) {
                    selectedSyear = value as String;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6).r,
                  border: Border.all(color: customBalck),
                  color: white,
                ),
                child: DropdownButtonFormField(
                  hint: const Text("Select Class"),
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  items: Studentclass
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) {
                    selectedSclass = value as String;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6).r,
                  border: Border.all(color: customBalck),
                  color: white,
                ),
                child: DropdownButtonFormField(
                  hint: const Text("Select Subject"),
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  items: Subject
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) {
                    selectedSsub = value as String;
                  },
                ),
              ),

              const SizedBox(height: 50),
              MyButton(btnname: "Upload Note", btncolor: customBalck, click: (){
                uploadFile();
              }, bordercolor: customBalck, txtcolor: white)

            ],
          ),
        ),
      ),
    );
  }
}
class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
        required this.btnname,
        required this.btncolor,
        required this.click,
        required this.bordercolor,
        required this.txtcolor});

  final String btnname;
  final Color btncolor;
  final Color txtcolor;
  final Color bordercolor;
  final void Function() click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: bordercolor),
            borderRadius: BorderRadius.circular(8).r,
            color: btncolor),
        child: Center(
          child: AppText(
              text: btnname,
              weight: FontWeight.w400,
              size: 15,
              textcolor: txtcolor),
        ),
      ),
    );
  }
}

class AppText extends StatelessWidget {
  const AppText(
      //Custom Text Widget.....
          {super.key,
        required this.text,
        required this.weight,
        required this.size,
        required this.textcolor});

  final String text;
  final FontWeight weight;
  final double size;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: size.sp, color: textcolor, fontWeight: weight),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}