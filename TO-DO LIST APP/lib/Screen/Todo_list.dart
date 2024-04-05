import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/Controllar/todo_controller.dart';
import 'package:todo/Models/todo_modals.dart';
import 'package:todo/widget/todo_tiles.dart';
import '../widget/botomSheet.dart';

class Todolist extends StatefulWidget {
  const Todolist({
    Key? key,
  }) : super(key: key);

  @override
  State<Todolist> createState() => TodolistState();
}

class TodolistState extends State<Todolist> {
  late Todocontroller controller;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    controller = Todocontroller();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      await controller.getData();
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showAddTodoBottomSheet(context);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Lottie.asset("Animation/2.json", height: 100),
            _buildSearchTextField(),
            const SizedBox(height: 20),
            Expanded(
              child: _buildTodoList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        cursorColor: const Color(0xff979797),
        style: Theme.of(context).textTheme.bodyMedium,
        onChanged: (value) {
          setState(() {
            controller.searchTodo(value);
          });
        },
        decoration: InputDecoration(
          fillColor: const Color(0xFF1D1D1D),
          filled: true,
          prefixIcon: Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset(
              "assets/search.png",
              height: 24,
              width: 24,
            ),
          ),
          hintText: "Search For Your Task",
          hintStyle: Theme.of(context).textTheme.bodyMedium,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff979797)),
          ),
        ),
      ),
    );
  }

  Widget _buildTodoList() {
    if (controller.searchedTodolist != null &&
        controller.searchedTodolist!.isEmpty) {
      return Center(
        child: Text(
          "No Task",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          final Todo item = controller.searchedTodolist != null
              ? controller.searchedTodolist![index]
              : controller.todoList[index];
          return Todotiles(
            todo: item,
            deleteTodo: () {
              setState(() {
                controller.todoList.removeAt(index);
                if (controller.searchedTodolist != null &&
                    controller.searchedTodolist!.contains(item)) {
                  controller.searchedTodolist!.remove(item);
                }
                controller.setData();
              });
            },
          );
        },
        itemCount: controller.searchedTodolist != null
            ? controller.searchedTodolist!.length
            : controller.todoList.length,
      );
    }
  }

  Future<void> showAddTodoBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Bottomsheet(controller: controller);
      },
    );
  }
}

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:todo/Controllar/todo_controller.dart';
// import 'package:todo/Models/todo_modals.dart';
// import 'package:todo/widget/Sidebar.dart';
// import 'package:todo/widget/todo_tiles.dart';
//
// import '../widget/botomSheet.dart';
//
// class Todolist extends StatefulWidget {
//   const Todolist({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<Todolist> createState() => TodolistState();
// }
//
// class TodolistState extends State<Todolist> {
//   Todocontroller controller = Todocontroller();
//   int currentSelectedIndex = 0;
//
//   @override
//   void initState() {
//     controller.getData().then((value) {
//       setState(() {});
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       // drawer: Sidebar(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() async {
//           await showModalBottomSheet(
//               backgroundColor: Theme.of(context).colorScheme.secondary,
//               context: context,
//               isScrollControlled: true,
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.vertical(top: Radius.circular(30))),
//               builder: (context) {
//                 return Bottomsheet(
//                   controller: controller,
//                 );
//               });
//           setState(() {});
//         }),
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//         child: Column(
//           children: [
//             Lottie.asset("Animation/2.json", height: 100),
//             _showtextfield(),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: controller.searchedTodolist?.length == 0
//                   ? Center(
//                       child: Text(
//                         "No Task",
//                         style: Theme.of(context).textTheme.bodyMedium,
//                       ),
//                     )
//                   : ListView.builder(
//                       itemBuilder: ((context, index) {
//                         Todo item = controller.searchedTodolist != null
//                             ? controller.searchedTodolist![index]
//                             : controller.todoList[index];
//                         return Todotiles(
//                           todo: item,
//                         //   deleteTodo: () {
//                         //     setState(() {
//                         //       controller.todoList.removeAt(index);
//                         //       controller.setData();
//                         //     });
//                         //   },
//                         // );
//                             deleteTodo: () {
//                           setState(() {
//                             controller.todoList.removeAt(index);
//                             // Update searchedTodolist if it exists and contains the same item
//                             if (controller.searchedTodolist != null &&
//                                 controller.searchedTodolist!.contains(item)) {
//                               controller.searchedTodolist!.remove(item);
//                             }
//                             controller.setData();
//                           });
//                         }
//                         );
//                       }),
//                       itemCount: controller.searchedTodolist != null
//                           ? controller.searchedTodolist!.length
//                           : controller.todoList.length,
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Container _showtextfield() {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: TextField(
//         cursorColor: const Color(0xff979797),
//         style: Theme.of(context).textTheme.bodyMedium,
//         onChanged: (value) {
//           setState(() {
//             controller.searchTodo(value);
//           });
//         },
//         decoration: InputDecoration(
//             fillColor: const Color(0xFF1D1D1D),
//             filled: true,
//             prefixIcon: Padding(
//               padding: EdgeInsets.all(8),
//               child: Image.asset(
//                 "assets/search.png",
//                 height: 24,
//                 width: 24,
//               ),
//             ),
//             hintText: "Search For Your Task ",
//             hintStyle: Theme.of(context).textTheme.bodyMedium,
//             border: const OutlineInputBorder(),
//             focusedBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xff979797)),
//             )),
//       ),
//     );
//   }
// }
