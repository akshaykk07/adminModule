
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class AddQuestionScreen extends StatefulWidget {
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  TextEditingController option4Controller = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController topicController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              TextFormField(
                  controller: questionController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Question')),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                          controller: option1Controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Option 1'))),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                      child: TextFormField(
                          controller: option2Controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Option 2'))),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                          controller: option3Controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Option 3'))),
                  SizedBox(
                    width: 10.h,
                  ),
                  Expanded(
                      child: TextFormField(
                          controller: option4Controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Option 4'))),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                          controller: answerController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Correct Answer'))),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                          controller: topicController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Topic'))),
                ],
              ),
              SizedBox(height: 100.h),
              MyButton(
                  btnname: "Upload Question",
                  btncolor: customBalck,
                  click: () async {
                    await addQuestionToFirebase();
                    Navigator.pop(context);
                  },
                  bordercolor: customBalck,
                  txtcolor: white)
              // ElevatedButton(
              //   onPressed: () async {
              //     await addQuestionToFirebase();
              //     Navigator.pop(context);
              //   },
              //   child: const Text('Add Question'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addQuestionToFirebase() async {
    await FirebaseFirestore.instance.collection('questions').add({
      'question': questionController.text,
      'options': [
        option1Controller.text.trim(),
        option2Controller.text.trim(),
        option3Controller.text.trim(),
        option4Controller.text.trim()
      ],
      'answer': answerController.text.trim(),
      'topc': topicController.text.trim()
    });
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
  AppText(
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
