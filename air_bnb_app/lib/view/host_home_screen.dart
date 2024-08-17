import 'package:air_bnb_app/view/account_screen.dart';
import 'package:air_bnb_app/view/host/host_booking.dart';
import 'package:air_bnb_app/view/host/posting_screen.dart';
import 'package:air_bnb_app/view/inbox_screen.dart';
import 'package:flutter/material.dart';

class HostHomeScreen extends StatefulWidget {
  const HostHomeScreen({super.key});

  @override
  State<HostHomeScreen> createState() => _HostHomeScreenState();
}

class _HostHomeScreenState extends State<HostHomeScreen> {
  int selectedIndex = 0;

  final List<String> screenTitles = [
    'Bookings',
    'My Posting',
    'Inbox',
    'Profile',
  ];

  final List<Widget> screens = const [
    BookingPage(),
    MyPosting(),
    InboxScreen(),
    AccountScreen(),
  ];

  BottomNavigationBarItem customNavigationBarItem({
    required int index,
    required IconData iconData,
    required String title,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.black,
      ),
      activeIcon: Icon(
        iconData,
        color: Colors.deepPurple,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.amber,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(screenTitles[selectedIndex],
          style: TextStyle(
            color: Colors.white,
          ),
        ),

        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {
          setState(() {
            selectedIndex = i;
          });
        },
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          customNavigationBarItem(
            index: 0,
            iconData: Icons.calendar_today,
            title: screenTitles[0],
          ),
          customNavigationBarItem(
            index: 1,
            iconData: Icons.home,
            title: screenTitles[1],
          ),
          customNavigationBarItem(
            index: 2,
            iconData: Icons.message,
            title: screenTitles[2],
          ),
          // customNavigationBarItem(
          //   index: 3,
          //   iconData: Icons.message,
          //   title: screenTitles[3],
          // ),
          customNavigationBarItem(
            index: 3,
            iconData: Icons.person_outlined,
            title: screenTitles[3],
          ),
        ],
      ),
    );
  }
}
