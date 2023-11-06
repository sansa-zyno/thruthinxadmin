import 'package:flutter/material.dart';
//import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:truthinxadmin/UI/Dashboard/AdminDrawer.dart';
import 'package:truthinxadmin/UI/Dashboard/Client/Clients.dart';
import 'package:truthinxadmin/UI/Dashboard/Model/Models.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int currentIndex = 0;
  var pages = [
    Clients(),
    Models(),
  ];

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          key: _drawerKey,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.menu_open_rounded),
                onPressed: () {
                  _drawerKey.currentState!.openDrawer();
                }),
            backgroundColor: Colors.grey[850],
            title: Text("Dashboard"),
          ),
          drawer: Theme(
            data: ThemeData.dark(),
            child: AdminDrawer(),
          ),
          body: pages[currentIndex],
          /* bottomNavigationBar: BubbleBottomBar(
          opacity: .2,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value!;
            });
          },
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 8, //new
          hasInk: true, //new, gives a cute ink effect
          inkColor:
              Colors.black12, //optional, uses theme color if not specified
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Image.asset(
                "assets/clients.png",
                height: 32,
              ),
              activeIcon: Image.asset(
                "assets/clients.png",
                height: 32,
              ),
              title: Text("Clients"),
            ),
            BubbleBottomBarItem(
              backgroundColor: Colors.teal,
              icon: Image.asset(
                "assets/gems.png",
                height: 28,
              ),
              activeIcon: Image.asset(
                "assets/gems.png",
                height: 28,
              ),
              title: Text("Models"),
            ),
          ],
        ),*/
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.shifting,
              elevation: 8,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Colors.red,
                  icon: Image.asset(
                    "assets/clients.png",
                    height: 32,
                  ),
                  activeIcon: Image.asset(
                    "assets/clients.png",
                    height: 32,
                  ),
                  label: 'Clients',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.teal,
                  icon: Image.asset(
                    "assets/gems.png",
                    height: 28,
                  ),
                  activeIcon: Image.asset(
                    "assets/gems.png",
                    height: 28,
                  ),
                  label: 'Models',
                ),
              ],
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: currentIndex,
              selectedItemColor: Color(0xff017218),
              unselectedItemColor: Colors.black87,
              unselectedFontSize: 14,
              selectedFontSize: 14,
              onTap: (int tappedIndex) {
                setState(() {
                  currentIndex = tappedIndex;
                });
              })),
    );
  }
}
