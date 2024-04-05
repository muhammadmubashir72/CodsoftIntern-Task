import 'package:flutter/material.dart';
import 'package:todo/Screen/Todo_list.dart';
import 'package:todo/Screen/login.dart';
import 'package:todo/widget/Sidebar.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int SelectedIndex = 0;

  final List<Widget> _tabs = const [
    Todolist(),
    Text("Search"),
    Text("Payment"),
    Text("location"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // drawer: const Sidebar(),
      appBar: _showAppbar(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: SelectedIndex,
        onTap: (int tappedIndex) {
          setState(() {
            SelectedIndex = tappedIndex;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
              tooltip: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Search",
              tooltip: "Search for todo"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.payment,
              ),
              label: "Payment",
              tooltip: "buy your todo"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.location_searching,
              ),
              label: "Location",
              tooltip: "Your location"),
        ],
      ),
      body: _tabs[SelectedIndex],
    );
  }

  AppBar _showAppbar() {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(9.0),
        child: InkWell(
          onTap: () {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: ((context) => Drawer())));
          },
          child: Image.asset(
            "assets/sort.png",
          ),
        ),
      ),
      title: const Center(
        child: Text(
          "Todo",
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: ((context) => Login())));
              },
              child: Image.asset("assets/user.png")),
        )
      ],
    );
  }
}
