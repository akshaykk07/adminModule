import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class AddQues extends StatefulWidget {
  AddQues({super.key});

  @override
  State<AddQues> createState() => _AddQuesState();
}

class _AddQuesState extends State<AddQues> {
  final TopicControllor = TextEditingController();

  final QustionControllor = TextEditingController();

  final Option1Controllor = TextEditingController();

  final Option2Controllor = TextEditingController();

  final Option3Controllor = TextEditingController();

  final Option4Controllor = TextEditingController();

  final AnswerControllor = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const AppText(
              text: "Add Question",
              weight: FontWeight.w400,
              size: 18,
              textcolor: customBalck)),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 150.h,
              ),
              const Text("Enter Question Name:"),
              TextFormField(
                controller: QustionControllor,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter Question name";
                  }
                },
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Enter option 1:"),
                        TextFormField(
                          controller: Option1Controllor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Option1 ";
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text("Enter option 3:"),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Option3 ";
                            }
                          },
                          controller: Option3Controllor,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10.h,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Enter option 2:"),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Option2 ";
                            }
                          },
                          controller: Option2Controllor,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        const Text("Enter option 4:"),
                        TextFormField(
                          controller: Option4Controllor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Option4 ";
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Enter  Answer option:"),
                        TextFormField(
                          controller: AnswerControllor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Answer option ";
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Enter Topic:"),
                        TextFormField(
                          controller: TopicControllor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Topic ";
                            }
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Align(
                alignment: FractionalOffset.center,
                child: MyButton(
                    btnname: "Add Question",
                    btncolor: customBalck,
                    click: () {},
                    bordercolor: customBalck,
                    txtcolor: white),
                // child: ElevatedButton(
                //     style: const ButtonStyle(
                //         shape:
                //         MaterialStatePropertyAll(RoundedRectangleBorder()),
                //         backgroundColor:
                //         MaterialStatePropertyAll(Colors.green)),
                //     onPressed: () {
                //       if (formkey.currentState!.validate()) {
                //         addQuestion();
                //       }
                //     },
                //     child: const Text(
                //       "Add Question",
                //       style: TextStyle(color: Colors.white),
                //     )),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> addQuestion() async {
    // await FirebaseFirestore.instance.collection('Questions').add({
    //   'Topic': TopicControllor.text.trim(),
    //   'QuestionName': QustionControllor.text.trim(),
    //   'Option1': Option1Controllor.text.trim(),
    //   'Option2': Option2Controllor.text.trim(),
    //   'Option3': Option3Controllor.text.trim(),
    //   'Option4': Option4Controllor.text.trim(),
    //   'AnswerIndex': AnswerControllor.text.trim()
    // });
    TopicControllor.clear();
    QustionControllor.clear();
    Option1Controllor.clear();
    Option2Controllor.clear();
    Option3Controllor.clear();
    Option4Controllor.clear();
    AnswerControllor.clear();
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
