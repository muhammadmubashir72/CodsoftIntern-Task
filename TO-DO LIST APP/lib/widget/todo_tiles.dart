import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../Models/todo_modals.dart';

// ignore: must_be_immutable
class Todotiles extends StatefulWidget {
  Todotiles({
    required this.todo,
   this.deleteTodo,
  });
  Todo todo;
  final Function? deleteTodo;
  @override
  State<Todotiles> createState() => _TodotilesState();
}
class _TodotilesState extends State<Todotiles> {
    
    
  @override
  Widget build(BuildContext context) {     
    return  Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                children: [
                    Checkbox(
                   activeColor: Color.fromARGB(232, 12, 28, 247),
                  value:widget.todo.isCompleted,
                  onChanged:(bool? value){
                    print(value);
                    setState(() {
                      widget.todo.isCompleted = value!;
                    });
                  } 
                  ),
                 const SizedBox(
                  height:12
                 ),     
                    Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: Expanded(
                       child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            '${widget.todo.title}',
                          style:Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(
                                        height: 2,
                          ),
                          Text(
                             DateFormat('MMM dd yyyy HH:mm')
                          .format(widget.todo.todoDay),
                          style: Theme.of(context).textTheme.bodySmall,
                          ),
                          ],
                       ),
                     ),
                 ),
               
                 Spacer(),
                if(widget.todo.image != null)
                 Image.file(
                  widget.todo.image!,
                  width: 30,
                 ),
                
               
                 Spacer(),
                 Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(padding: EdgeInsets.all(1)),   
                         IconButton( 
                          onPressed:(){
                            widget.deleteTodo!();
                          },
                           icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                           )
                           ),
                        ],
                      ), 
                ] 
              ));        
  }
}