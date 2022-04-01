import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projectbakery/pages/login_page.dart';
import 'package:projectbakery/services/autth_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Account',
              style: TextStyle(color: Color(0xFF06112D), fontSize: 22),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            // centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: showList(),
          )),
    );
  }

  Widget showList() {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('uid_id', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        List<Widget> myList;

        if (snapshot.hasData) {
          // Convert snapshot.data to jsonString
          var products = snapshot.data;

          // Define Widgets to myList
          myList = [
            Column(
              children: products!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                return Column(
                  children: [
                   
                    const SizedBox(height: 12.0),
                    Text('${data['name']}'),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.25),
                          borderRadius: BorderRadius.circular(12.0)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.mail_outline_rounded,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${user.email}',
                            style: TextStyle(
                                color: Color(0xFF06112D),
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Column(
                      children: [
                       
                        const SizedBox(height: 8.0),
                        FinanceListTile(
                          text: "ออกจากระบบ",
                          leadingIcon: const Icon(Icons.logout_rounded),
                          onTap: () {
                            showDialog<Dialog>(
                                context: context,
                                builder: (context) => AlertDialogFb1(
                                        title: "ออกจากระบบ?",
                                        description:
                                            "คุณต้องการออกจากระบบ?",
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('ยกเลิก')),
                                          TextButton(
                                              onPressed: () {
                                                googleSignOut().then((value) {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage(),
                                                    ),
                                                  );
                                                });
                                              },
                                              child: const Text('ออกจากระบบ')),
                                        ]));
                          },
                          color: const Color(0xFFFF6157),
                        ),
                      ],
                    )
                  ],
                );
              }).toList(),
            ),
          ];
        } else if (snapshot.hasError) {
          myList = [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('ข้อผิดพลาด: ${snapshot.error}'),
            ),
          ];
        } else {
          myList = [
            const SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('อยู่ระหว่างประมวลผล'),
            )
          ];
        }

        return Center(
          child: Column(
            children: myList,
          ),
        );
      },
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({required this.imageUrl, this.radius = 50.0, Key? key})
      : super(key: key);
  final String imageUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
            imageUrl,
          ),
        ),
      ],
    );
  }
}

class FinanceListTile extends StatelessWidget {
  final String text;
  final Widget leadingIcon;
  final Widget? trailingIcon;
  final Function() onTap;
  final Color color;
  const FinanceListTile(
      {required this.text,
      required this.leadingIcon,
      this.trailingIcon,
      required this.onTap,
      this.color = const Color(0xFF4338CA),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          leading: leadingIcon,
          title: Text(
            text,
            textScaleFactor: 1,
          ),
          trailing: trailingIcon,
          selected: false,
          onTap: onTap,
        ),
      ),
      // textColor: color,
      iconColor: color,
    );
  }
}

class AlertDialogFb1 extends StatelessWidget {
  final String title;
  final String description;

  final List<TextButton> actions;

  const AlertDialogFb1(
      {required this.title,
      required this.description,
      required this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(title),
      content: Text(description),
      actions: actions,
    );
  }
}
