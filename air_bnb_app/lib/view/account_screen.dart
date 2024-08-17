import 'package:air_bnb_app/model/app_constant.dart';
import 'package:air_bnb_app/view/guest_home_screen.dart';
import 'package:air_bnb_app/view/host_home_screen.dart';
import 'package:air_bnb_app/view_model/user_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String hostingTittle = 'Become a host';

  void modifyMostingMode() async {
    if (AppConstant.currentUser.isMost) {
      if (AppConstant.currentUser.isCurrentlyMosting == true) {
        AppConstant.currentUser.isCurrentlyMosting = false;
        Get.to(() => GuestHomeScreen());
      } else {
        AppConstant.currentUser.isCurrentlyMosting = true;
        Get.to(() => HostHomeScreen());
      }
    } else {
      await UserViewModel().becomeMost(FirebaseAuth.instance.currentUser!.uid);
      AppConstant.currentUser.isCurrentlyMosting = true;
      Get.to(() => HostHomeScreen());
    }

    // Update the button text based on the current state
    setState(() {
      hostingTittle = AppConstant.currentUser.isCurrentlyMosting == true
          ? 'Show my Guest Dashboard'
          : 'Show my Host Dashboard';
    });
  }

  @override
  void initState() {
    super.initState();
    // Update the initial hostingTittle based on the user's hosting status
    hostingTittle = AppConstant.currentUser.isMost && AppConstant.currentUser.isCurrentlyMosting == true
        ? 'Show my Guest Dashboard'
        : 'Show my Host Dashboard';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 50, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Center(
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: MediaQuery.of(context).size.width / 4.5,
                        child: CircleAvatar(
                          backgroundImage: AppConstant.currentUser.displayImage,
                          radius: MediaQuery.of(context).size.width / 4.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppConstant.currentUser.getFullNameOfUser(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          AppConstant.currentUser.email,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pinkAccent,
                        Colors.amber,
                      ],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(1, 0),
                      stops: const [0, 1],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.1,
                    onPressed: modifyMostingMode,
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Icon(Icons.person_2),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pinkAccent,
                        Colors.amber,
                      ],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(1, 0),
                      stops: const [0, 1],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.1,
                    onPressed: modifyMostingMode,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: Text(
                        hostingTittle,
                        style: const TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: const Icon(Icons.hotel_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pinkAccent,
                        Colors.amber,
                      ],
                      begin: FractionalOffset(0, 0),
                      end: FractionalOffset(1, 0),
                      stops: const [0, 1],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: MaterialButton(
                    height: MediaQuery.of(context).size.height / 9.1,
                    onPressed: () {
                      // Implement log-out functionality here
                    },
                    child: const ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      leading: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Icon(Icons.login_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
