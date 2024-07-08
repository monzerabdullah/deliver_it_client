import 'package:deliver_it_client/constants.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/imgs/yahalla.jpg'),
                  radius: 60.0,
                ),
              ],
            ),
          ),
          ListTile(
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
          SizedBox(
            height: 10,
          ),
          ListTile(
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
          SizedBox(
            height: 10,
          ),
          ListTile(
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
          SizedBox(
            height: 100,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: kPrimaryText,
                size: 35,
                textDirection: TextDirection.rtl,
              ),
              title: Text(
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
