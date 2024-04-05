import 'package:flutter/material.dart';
import 'package:todo/Screen/Todo_list.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF5F5F5),
      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child:Text("Login",
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFFFFFFDE),
                    fontStyle: FontStyle.italic,

                  ),),
                ),
              ],
            ),
            SizedBox(
               height: 30,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text("Username",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 253),
                    fontStyle: FontStyle.italic,
                      ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(244, 45, 255, 244),
                  filled: true,
                border: OutlineInputBorder(),
                
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff979797),
                ),
                ),
                hintText: "LoginNow",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(0, 0, 0, 1),  
          )
                ),
     ),
            ),
     SizedBox(
      height: 20,
     ),
           const Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Padding(
                     padding: EdgeInsets.only(left: 15 ),
                     child: Text("Password",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 250, 250, 250),
                        fontStyle: FontStyle.italic,
                          ),
                      ),
                   ),
                 ],
               ),
             ],
           ),
            const SizedBox(
              height: 6,
            ),
             const Padding(
               padding: EdgeInsets.symmetric(horizontal: 20),
               child: TextField(
                decoration: InputDecoration(
                   fillColor: Color.fromARGB(244, 45, 255, 244),
                  filled: true,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff979797),
                ),
                ),
                hintText: "Password",
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 0, 0, 0),  

                )
                ),
                
            ),
         ),
           SizedBox(
            height: 40,
           ),
           InkWell(
            onTap: () => 
            Navigator.push(context, MaterialPageRoute(builder: ((context) => Todolist ()))),
             child: Container(
                height: 50,
                width: 200,
                child:Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "Login",
                     textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,

                    ),
                   
                  ),
                ),
               
                decoration: BoxDecoration(
                   color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                )
              ),
           )
          ],
        
        ),
        
      ),

    );
  }
  
 

}