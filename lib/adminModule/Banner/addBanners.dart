import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class AddBanners extends StatefulWidget {
  @override
  _AddBannersState createState() => _AddBannersState();
}

class _AddBannersState extends State<AddBanners> {
  File? _image;
  final picker = ImagePicker();
  String _imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const AppText(
            text: "Add Banners",
            weight: FontWeight.w400,
            size: 18,
            textcolor: customBalck),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10).r,
                          border: Border.all(color: customBalck),
                          color: whiteone),
                      child: const Center(
                          child: AppText(
                              text: "Select Image",
                              weight: FontWeight.w400,
                              size: 15,
                              textcolor: customBalck)))
                  : Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10).r,
                          border: Border.all(color: Colors.black38),
                          color: whiteone),
                      child: Center(
                        child: Image.file(
                          _image!,
                          height: 180,
                        ),
                      ),
                    ),
              SizedBox(
                height: 5.h,
              ),
              const Align(
                  alignment: Alignment.centerRight,
                  child: AppText(
                      text: "(W 360*H 140)",
                      weight: FontWeight.w400,
                      size: 12,
                      textcolor: customBalck)),
              const SizedBox(height: 60),
              MyButton(
                btnname: "Select Image ",
                btncolor: white,
                bordercolor: customBalck,
                txtcolor: customBalck,
                click: () {
                  getImageFromGallery();
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              MyButton(
                btnname: "Upload Image ",
                btncolor: customBalck,
                bordercolor: customBalck,
                txtcolor: Colors.white,
                click: () {
                  uploadImageToFirebase();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageToFirebase() async {
    if (_image == null) return;

    try {
      String fileName = basename(_image!.path);
      Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('Banners/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(_image!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        _imageUrl = downloadUrl;
      });
      await FirebaseFirestore.instance.collection('Banners').add({"BannerUrl":_imageUrl,"CreatedAt":DateTime.now()});
      print("Image uploaded to Firebase: $_imageUrl");
    } on FirebaseException catch (e) {
      print("Error uploading image: $e");
    }
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
