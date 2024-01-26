import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);


class ViewProfile extends StatelessWidget {
  const ViewProfile(
      {super.key,
        // required this.id,
        // required this.name,
        // required this.email,
        // required this.phone,
        // required this.location,
        // required this.image
  });
  // final id;
  // final name;
  // final email;
  // final phone;
  // final location;
  // final image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteone,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const AppText(
            text: "My Profile",
            weight: FontWeight.w500,
            size: 20,
            textcolor: customBalck),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 35, right: 35).r,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 100.h,
            ),
            CircleAvatar(
              radius: 50.r,
             // backgroundImage: NetworkImage(image.toString()),
            ),
            SizedBox(
              height: 10.h,
            ),
            AppText(
                text: "Arjun C",
                weight: FontWeight.w500,
                size: 20,
                textcolor: customBalck),
            SizedBox(
              height: 50.h,
            ),
            CustomTextField(
              hint: "Name",
              fillcolor: white,
              controller: TextEditingController(text: "Arjun c"),
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "",
              fillcolor: white,
              controller: TextEditingController(text: "9946253845"),
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "email",
              fillcolor: white,
              controller: TextEditingController(text: 'Class'),
              validator: (value) {},
              readonly: true,
            ),
            CustomTextField(
              hint: "",
              fillcolor: white,
              controller: TextEditingController(text: "Branch"),
              validator: (value) {},
              readonly: true,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, top: 20).r,
              child: MyButton(
                  btnname: "Back", //Custom Button......
                  btncolor: customBalck,
                  txtcolor: white,
                  click: () {
                    Navigator.pop(context);
                  }, bordercolor: customBalck,),
            )
          ]),
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



class CustomTextField extends StatelessWidget {
  const CustomTextField({
    // custom TextField........
    super.key,
    required this.hint,
    this.kebordtype = TextInputType.text,
    required this.controller,
    required this.validator,
    this.obscure = false,
    this.fillcolor = white,
    this.readonly = false,
    this.onChanged,
  });

  final String hint;
  final TextInputType kebordtype;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final bool readonly;
  final Color fillcolor;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 15).r,
      child: TextFormField(
        keyboardType: kebordtype,
        controller: controller,
        validator: validator,
        obscureText: obscure,
        readOnly: readonly,
        onChanged: onChanged,
        decoration: InputDecoration(
            fillColor: fillcolor,
            filled: true,
            hintText: hint,
            contentPadding:
            EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: customBalck),
                borderRadius: BorderRadius.circular(8).r),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: customBalck),
                borderRadius: BorderRadius.circular(8).r),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: customBalck))),
      ),
    );
  }
}