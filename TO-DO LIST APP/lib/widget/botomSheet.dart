import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Controllar/todo_controller.dart';

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({super.key, required this.controller});

  final Todocontroller controller;

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  String? title, description, image;
  DateTime? date;
  File? todoImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          25, 25, 25, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              "Add Task",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  builder: (context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.camera);
                            print(image?.name);
                            print(image?.path);
                            if (image != null) {
                              setState(() {
                                todoImage = File(image!.path);
                              });
                            }
                            Navigator.pop(context);
                          },
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                          leading: Icon(Icons.camera),
                          title: Text("Pick from Camera"),
                        ),
                        ListTile(
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            print(image?.name);
                            print(image?.path);
                            if (image != null) {
                              setState(() {
                                todoImage = File(image!.path);
                              });
                            }
                            Navigator.pop(context);
                          },
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          iconColor: Theme.of(context).colorScheme.onPrimary,
                          leading: Icon(Icons.photo),
                          title: Text("Pick from Gallery"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  });
            },
            child: CircleAvatar(
              child: Icon(Icons.add_a_photo),
              radius: 35,
              foregroundImage: todoImage == null ? null : FileImage(todoImage!),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: TextField(
                textInputAction: TextInputAction.next,
                onChanged: ((value) {
                  title = value;
                }),
                autofocus: true,
                cursorColor: const Color(0xff979797),
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    fillColor: const Color(0xff363636),
                    filled: true,
                    hintText: "Add Title",
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff979797)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff979797)),
                    )),
              )),
          Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                onChanged: ((value) {
                  description = value;
                }),
                autofocus: true,
                cursorColor: const Color(0xff979797),
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.secondary,
                    filled: true,
                    hintText: "Add Description",
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff979797)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xff979797)),
                    )),
              )),
          Padding(
            padding: const EdgeInsets.only(bottom: 17),
            child: Row(children: [
              IconButton(
                  onPressed: () async {
                    date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      builder: (context, child) {
                        return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.dark(
                                primary: Color(0xff363636),
                                onPrimary: Colors.white,
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor: Color(0xff363636),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xff363636),
                                  foregroundColor: Colors.white,
                                  textStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  // primary: Colors.white,
                                ),
                              ),
                            ),
                            child: child!);
                      },
                    );
                    // ignore: use_build_context_synchronously
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 12, minute: 00),
                      builder: (context, child) {
                        return Theme(
                            data: Theme.of(context).copyWith(
                                timePickerTheme: const TimePickerThemeData(
                                  backgroundColor: Colors.black45,
                                  hourMinuteColor: Colors.black,
                                  hourMinuteTextColor: Colors.white,
                                  dialBackgroundColor: Colors.black38,
                                  dialHandColor: Colors.grey,
                                  entryModeIconColor:
                                      Color.fromARGB(255, 54, 23, 23),
                                  dialTextColor: Colors.white,
                                ),
                                textTheme: const TextTheme(
                                  overline: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                            child: child!);
                      },
                    );
                    if (time != null) {
                      setState(() {
                        date = DateTime(date!.year, date!.month, date!.day,
                            time.hour, time.minute);
                      });
                    }
                    print(
                      date,
                    );
                    print(time);
                  },
                  icon: ImageIcon(
                    const AssetImage("assets/timer.png"),
                    color: Colors.white.withOpacity(0.87),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    const AssetImage("assets/tag.png"),
                    color: Colors.white.withOpacity(0.87),
                  )),
              IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    AssetImage("assets/red-flag.png"),
                    color: Colors.white.withOpacity(0.87),
                  )),
              Spacer(),
              IconButton(
                  onPressed: () {
                    print(title);
                    print(description);
                    print(date);
                    print(image);

                    // true ,true , false
                    if (title != null && description != null && date != null) {
                      setState(() {
                        widget.controller.addtodo(
                            title!, description!, date!, context,
                            image: todoImage);
                      });
                    } else {
                      print("hogya");
                    }
                  },
                  icon: const ImageIcon(
                    AssetImage("assets/send.png"),
                    color: Colors.blue,
                  )),
            ]),
          )
        ],
      ),
    );
  }
}
