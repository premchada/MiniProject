import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectbakery/pages/edit_menu.dart';
import 'package:projectbakery/utils/dimension.dart';

class CookPage extends StatefulWidget {
  const CookPage({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<CookPage> createState() => _CookPageState();
}

class _CookPageState extends State<CookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('images/daifuku.JPG'),
              )),
            ),
          ),
          Positioned(
            top: 45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditMenuPage(
                              id: widget.id.toString(),
                            ),
                          )).then((value) => setState(() {}));
                    },
                    // Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => EditMenuPage(id: doc.id),
                    //       )).then((value) => setState(() {}));
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 400,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              child: Column(
                children: [
                  showMenu(),
                  //Text('${data['name']}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showMenu() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('menu')
          .doc(widget.id.toString())
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          // Convert snapshot.data to jsonString
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Color(0xffffffff),
            color: Color(0xff89dad0),
          ));
        } else {
          var data = snapshot.data!.data();
          return Column(
            children: [
              Text(data['name']),
              Text(data['cooking'])
            ],
          );

        }
      },
    );
  }
}
