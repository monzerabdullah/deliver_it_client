import 'package:deliver_it_client/constants.dart';
import 'package:deliver_it_client/locator.dart';
import 'package:deliver_it_client/services/authentication_service.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({
    super.key,
  });
  final AuthenticationService _auth = locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/imgs/yahalla.jpg'),
                  radius: 60.0,
                ),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'الإعدادات',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(
              Icons.grading,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'سجل الطلبيات',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            leading: Icon(
              Icons.headset_mic_outlined,
              color: kPrimaryText,
              size: 35,
            ),
            title: Text(
              'المساعدة والدعم',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: kPrimaryText,
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              onTap: () {
                _auth.signOut();
              },
              leading: const Icon(
                Icons.logout,
                color: kPrimaryText,
                size: 35,
                textDirection: TextDirection.rtl,
              ),
              title: const Text(
                'تسجيل خروج',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: kPrimaryText,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
