import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/adminModule/Student/viewStudent.dart';

const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class StudentList extends StatelessWidget {
  const StudentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteone,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: whiteone,
        centerTitle: true,
        title: const AppText(
            text: "All Students",
            weight: FontWeight.w500,
            size: 18,
            textcolor: customBalck),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20).r,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10).r,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewProfile(),
                      ));
                },
                tileColor: white,
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://t4.ftcdn.net/jpg/05/52/94/89/360_F_552948967_rfWkVCstu3t9ypSnpt2ZePVnuqoi6D6o.jpg"),
                ),
                title: const AppText(
                    text: "Student Name",
                    weight: FontWeight.w400,
                    size: 15,
                    textcolor: customBalck),
                subtitle: const AppText(
                    text: "Branch Name",
                    weight: FontWeight.w400,
                    size: 10,
                    textcolor: customBalck),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios)),
              ),
            );
          },
          itemCount: 10,
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
