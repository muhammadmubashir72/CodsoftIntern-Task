import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(1),
            ),
            child: Container(
              height: double.infinity,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/sufi.jpg"),
                    backgroundColor: Theme.of(context).colorScheme.background,
                    radius: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sufyan ali",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onTap: () {
              // Handle home onTap
            },
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onTap: () {
              // Handle profile onTap
            },
            title: Text(
              "Profile",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.feedback,
              color: Colors.white,
            ),
            onTap: () {
              // Handle feedback onTap
            },
            title: Text(
              "Feedback",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.contact_mail,
              color: Colors.white,
            ),
            onTap: () {
              // Handle contact onTap
            },
            title: Text(
              "Contact Us",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.white,
            ),
            onTap: () {
              // Handle history onTap
            },
            title: Text(
              "History",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: Colors.white,
            ),
            onTap: () {
              // Handle help onTap
            },
            title: Text(
              "Help",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onTap: () {
              // Handle logout onTap
            },
            title: Text(
              "Log Out",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
