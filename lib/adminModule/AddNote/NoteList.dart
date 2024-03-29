import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'addNotes.dart';



const whiteone = Color(0xfff5f6f9);
const customBalck = Color(0xff000000);
const white = Color(0xffFFFFFF);

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Note List"),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const QuesView(id: "2"),
                        //     ));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5.0,
                                offset: const Offset(0.0, 3.0)),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(children: [
                            SizedBox(
                                height: double.infinity,
                                width: 100,
                                child: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRi5Nbzy6m48rRyp3I_ATVOdR1kzLlPH7r7OQ&usqp=CAU",
                                  fit: BoxFit.fill,
                                )),
                            SizedBox(
                              height: 100.h,
                              width: 180.w,
                              child: const Center(
                                child: AppText(
                                    text: "Note name",
                                    weight: FontWeight.w400,
                                    size: 18,
                                    textcolor: customBalck),
                              ),
                            ),
                            Expanded(
                                child: SizedBox(
                                  child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            // setState(() {
                                            //   data[index].reference.delete();
                                            // });
                                          },
                                          icon: const Icon(Icons.delete))),
                                ))
                          ]),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotes(),
              ));
        },
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
