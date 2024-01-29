import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddQuestionScreen()),
                );
              },
              child: const Text('Add Question'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const Quizn()),
            //     );
            //   },
            //   child: const Text('Start Quiz'),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Quizn()),
                );
              },
              child: const Text('Startt Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

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

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('questions').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var questions = snapshot.data?.docs;

          return ListView.builder(
            itemCount: questions?.length,
            itemBuilder: (context, index) {
              var question = questions![index].data();
              return ListTile(
                title: Text(question['question']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Options: ${question['options'].join(', ')}'),
                    Text('Correct Answer: ${question['answer']}'),
                  ],
                ),
              );
            },
          );
        },
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

class Quizn extends StatefulWidget {
  const Quizn({super.key});

  @override
  State<Quizn> createState() => _QuiznState();
}


var groupValue;

class _QuiznState extends State<Quizn> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: AppText(
            text: "Quiz",
            weight: FontWeight.w400,
            size: 18,
            textcolor: customBalck),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('questions').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
              {
                return const CircularProgressIndicator();
              }
            final user = snapshot.data?.docs ?? [];
            // final id=user[index].id;
            return ListView.builder(

              itemBuilder: (context,index) {

                return SizedBox(
                  child: Column(
                      children: [

                        const SizedBox(width: double.infinity,),
                         Align(
                            alignment: Alignment.centerLeft,
                            child: Text(user[index]['question'])),
                        SizedBox(height: 50.h,),
                        RadioListTile(value: "1",
                          groupValue: groupValue,
                          onChanged: (value){

                           if(value==user[index]['answer']){
                             print("correct answer");
                           }
                           else{
                             print("Wrong answer");
                           }
                       setState(() {
                         groupValue=value;
                       });
                          },
                          title: Text(user[index]['options'][0]),
                          tileColor: Colors.grey.shade300,),
                        SizedBox(height: 10.h,),
                        RadioListTile(value: "2", groupValue: groupValue, onChanged: (value){print(value);},title: Text(user[index]['options'][1]),tileColor: Colors.grey.shade300,),
                        SizedBox(height: 10.h,),
                        RadioListTile(value: "3", groupValue: groupValue, onChanged: (value){print(value);},title: Text(user[index]['options'][2]),tileColor: Colors.grey.shade300,),
                        SizedBox(height: 10.h,),
                        RadioListTile(value: "4", groupValue: groupValue, onChanged: (value){print(value);},title: Text(user[index]['options'][3]),tileColor: Colors.grey.shade300,)
                        ,SizedBox(height: 40.h,)
                  ]),
                );
              },
              itemCount:user.length ,
            );
          }
        ),
      ),
    );
  }
}
//import 'package:flutter/material.dart';



// class TestPage extends StatefulWidget {
//   @override
//   _TestPageState createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   List<dynamic> selectedValues = List.filled(4, null); // List to hold selected values for each set
//
//   // List of items for the ListView.builder
//   List<List<String>> itemList = [
//     ['Set 1 - Item 1', 'Set 1 - Item 2', 'Set 1 - Item 3'],
//     ['Set 2 - Item 1', 'Set 2 - Item 2', 'Set 2 - Item 3'],
//     ['Set 3 - Item 1', 'Set 3 - Item 2', 'Set 3 - Item 3'],
//     ['Set 4 - Item 1', 'Set 3 - Item 2', 'Set 3 - Item 3'],
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multiple Sets of Radio Buttons'),
//       ),
//       body: ListView.builder(
//         itemCount: itemList.length,
//         itemBuilder: (context, setIndex) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text('Set ${setIndex + 1}'),
//               Column(
//                 children: List.generate(
//                   itemList[setIndex].length,
//                       (index) {
//                     return ListTile(
//                       title: Text(itemList[setIndex][index]),
//                       trailing: Radio<int>(
//                         value: index,
//                         groupValue: selectedValues[setIndex],
//                         onChanged: (value) {
//                           setState(() {
//                             selectedValues[setIndex] = value!;
//                           });
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
