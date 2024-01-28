import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled10/adminModule/AddNote/addNotes.dart';
import 'package:untitled10/adminModule/Banner/addBanners.dart';

const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class BnnerList extends StatefulWidget {
  const BnnerList({super.key});

  @override
  State<BnnerList> createState() => _BnnerListState();
}

class _BnnerListState extends State<BnnerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteone,
      appBar: AppBar(
        backgroundColor: whiteone,
        title: const AppText(
            text: "Bnners",
            weight: FontWeight.w400,
            size: 18,
            textcolor: customBalck),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10).r,
              child: ListTile(
                tileColor: white,
                leading: Container(
                  height: 40,
                  width: 60,
                  color: Colors.green,
                ),
                title: const AppText(
                    text: "Url name",
                    weight: FontWeight.w400,
                    size: 12,
                    textcolor: customBalck),
                trailing: IconButton(
                    onPressed: () {
                      // setState(() {
                      //   data[index].reference.delete();
                      // });
                    },
                    icon: const Icon(Icons.delete)),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddBanners(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
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
