import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectbakery/pages/add_menu.dart';
import 'package:projectbakery/pages/cooking_page.dart';
import 'package:projectbakery/pages/edit_menu.dart';
import 'package:projectbakery/pages/food_page.dart';
import 'package:projectbakery/pages/login_page.dart';
import 'package:projectbakery/pages/me_page.dart';

import '../services/autth_service.dart';

class HomePage extends StatefulWidget {
  final UserCredential? userdata;
  const HomePage({Key? key, this.userdata}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final pages = [
    const HomePage(),
    const AddMenu(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text('เปิดเตา'),
      //   actions: [
      //     Container(
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(15),
      //         color: Color(0xff89dad0),
      //       ),
      //       child: IconButton(
      //         icon: const Icon(Icons.search),
      //         onPressed: () {
      //           showSearch(
      //             context: context,
      //             delegate: MySearchDelegate(),
      //           );
      //         },
      //       ),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Showing Header
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'เปิดเตา',
                            style: TextStyle(
                                color: Color(0xff89dad0), fontSize: 24),
                          ),
                          Text(
                            'ความหวาน',
                            style: TextStyle(
                              color: Color(0xFF8f837f),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        child: IconButton(
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            googleSignOut().then((value) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            });
                            // showSearch(
                            //   context: context,
                            //   delegate: MySearchDelegate(),
                            // );
                          },
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xff89dad0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                ],
              ),
            ),
            //showing the body
            FoodPageBody(),
            showMenu(),
          ],
        ),
      ),

      // BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),

      //       label: 'หน้าแรก',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.people),
      //       label: 'ฉัน',

      //     ),
      //   ],
      //   currentIndex: _selectedindex,
      //   selectedItemColor: Colors.amber,
      //   onTap: _onItemTapped,
    );
  }

  Widget showMenu() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('menu').snapshots(),
      builder: (context, snapshot) {
        List<Widget> myList;

        if (snapshot.hasData) {
          // Convert snapshot.data to jsonString
          var menu = snapshot.data;

          // Define Widgets to myList
          myList = [
            Column(
              children: menu!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                return Card(
                  
                  child: ListTile(
                    leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset('images/daifuku.JPG')),
                   onTap: () {
                      //Navigate to Edit Product
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CookPage(id: doc.id),
                          )).then((value) => setState(() {}));
                    },
                    // onTap: () {
                    //   //Navigate to Edit Product
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => EditMenuPage(id: doc.id),
                    //       )).then((value) => setState(() {}));
                    // },
                    title: Text('${data['name']}'),
                    subtitle: Text('${data['cooking']}'),
                    trailing: IconButton(
                      onPressed: () {
                        // Create Alert Dialog
                        var alertDialog = AlertDialog(
                          title: const Text('ยืนยันการลบเมนู'),
                          content: Text(
                              'คุณต้องการลบเมนู ${data['name']} ใช่หรือไม่'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('ยกเลิก')),
                            TextButton(
                                onPressed: () {
                                  deleteMenu(doc.id);
                                },
                                child: const Text('ยืนยัน')),
                          ],
                        );
                        // Show Alert Dialog
                        showDialog(
                            context: context,
                            builder: (context) => alertDialog);
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
                  ),
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

  Future<void> deleteMenu(String? id) {
    return FirebaseFirestore.instance
        .collection('menu')
        .doc(id)
        .delete()
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to delete : $error"));
  }

  
}

// class RecipeItemMallika1 extends StatelessWidget {
//   String title;
//   String subtitle;
//   RecipeItemMallika1({required this.title, required this.subtitle, Key? key})
//       : super(key: key);
//   final dishImage =
//       "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/malika%2FRectangle%2013.png?alt=media&token=6a5f056c-417c-48d3-b737-f448e4f13321";
//   final orangeColor = const Color(0xffFF8527);
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
          // leading: ClipRRect(
          //     borderRadius: BorderRadius.circular(5),
          //     child: Image.network(dishImage)),
//           title: Text(title),
//           subtitle: Row(
//             children: [
//               Icon(
//                 Icons.favorite,
//                 size: 15,
//                 color: orangeColor,
//               ),
//               Text(subtitle),
//             ],
//           ),
//           trailing: Column(
//             children: const [
//               Icon(Icons.more_vert_outlined),
//             ],
//           ),
//     );
//   }
// }





