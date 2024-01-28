import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  List<String> Studentyear = ["First Year", "Second Year", "Third Year"];
  List<String> Studentclass = [
    "Electrician",
    "Fitter",
    "Welder",
    "Turner",
    "Machinist",
    "Mechanic (Motor Vehicle)",
     "COPA",
    "Instrument Mechanic",
    "Electronics Mechanic",
    "Plumber",
    "Carpenter",
    "Draughtsman (Civil/Mechanical)",
    "Surveyor",
    //"  Refrigeration and Air Conditioning Mechanic",
    "Mechanic Diesel Engine",
    "Mechanic Radio and Television",
    // "Stenographer and Secretarial Assistant (English/Hindi)",
    "Cutting and Sewing",
    "Hair and Skin Care",
    "Food Production (General)",
    //"Food and Beverage Service Assistant",
    "Health Sanitary Inspector",
  ];
  List<String> Subject = ["Cad", "Auto Mobile", "Es"];
  String? selectedSyear;
  String? selectedSclass;
  String? selectedSsub;
  String? uploadUrl;
  final Tradecontollor = TextEditingController();

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
      Reference storageReference = FirebaseStorage.instance.ref().child(
          'Notes/${DateTime.now()}.pdf');
      UploadTask uploadTask = storageReference.putFile(selectedFile!);

      await uploadTask.whenComplete(() => print('File Uploaded'));

      // Get the download URL
      String downloadURL = await storageReference.getDownloadURL();
      setState(() {
        uploadUrl = downloadURL;
      });
      await FirebaseFirestore.instance.collection('Notes').add({
        'Trade': selectedSclass,
        'year': selectedSyear,
        'Subject': selectedSsub,
        'Url': uploadUrl
      }).then((value) => Navigator.pop(context));
      // Now you can use the download URL as needed (e.g., store it in the database)
     // print('Download URL: $downloadURL');
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
          padding: const EdgeInsets.only(left: 20, right: 20).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              DropdownMenu(
                hintText: "Select Trade",
                menuStyle: const MenuStyle(
                    backgroundColor: MaterialStatePropertyAll(white)),
                controller: Tradecontollor,
                enableFilter: true,
                enableSearch: true,
                requestFocusOnTap: true,
                dropdownMenuEntries: Studentclass.map(
                        (e) => DropdownMenuEntry(value: e, label: e)).toList(),
                onSelected: (value) {
                  setState(() {
                    selectedSclass = value;
                  });
                },),
              const SizedBox(height: 20),
              DropdownMenu(
                hintText: "Select Year",
                menuStyle: const MenuStyle(
                    backgroundColor: MaterialStatePropertyAll(white)),
                dropdownMenuEntries: Studentyear.map(
                        (e) => DropdownMenuEntry(value: e, label: e)).toList(),
                onSelected: (value) {
                  setState(() {
                    selectedSyear = value;
                  });
                },),
              const SizedBox(height: 20),
              DropdownMenu(
                hintText: "Select Suject",
                menuStyle: const MenuStyle(
                    backgroundColor: MaterialStatePropertyAll(white)),
                dropdownMenuEntries:
                Subject.map((e) => DropdownMenuEntry(value: e, label: e))
                    .toList(),
                onSelected: (value) {
                  setState(() {
                    selectedSsub = value;
                  });
                },),
              const SizedBox(height: 20),
              selectedFile == null
                  ? Row(
                children: [
                  Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0).r,
                        child: const Text('Select pdf file '),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 20).r,
                    child: InkWell(
                      onTap: pickFile,
                      child: Card(
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              const Text("Choose")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Row(
                children: [
                  Expanded(
                    child: Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: Text(
                              'Selected File: ${selectedFile!.path}'),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20).r,
                    child: InkWell(
                      onTap: pickFile,
                      child: Card(
                        color: white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.picture_as_pdf,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              const Text("Choose")
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              MyButton(
                  btnname: "Upload Note",
                  btncolor: customBalck,
                  click: () {
                    uploadFile();
                  },
                  bordercolor: customBalck,
                  txtcolor: white)
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({super.key,
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
            borderRadius: BorderRadius
                .circular(8)
                .r,
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
  const AppText(//Custom Text Widget.....
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
