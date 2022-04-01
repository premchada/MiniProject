import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMenu extends StatefulWidget {
  const AddMenu({Key? key}) : super(key: key);

  @override
  State<AddMenu> createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {
  final _addFormKey = GlobalKey<FormState>();
  CollectionReference menuu = FirebaseFirestore.instance.collection('menu');
  final TextEditingController _namefood = TextEditingController();
  final TextEditingController _cooking = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff89dad0),
        title: Text('เพิ่มเมนู'),
      ),
      body: Form(
        key: _addFormKey,
        child: ListView(
          children: [
            inputname(),
            inputcook(),
            addButton(),
          ],
        ),
      ),
    );
  }

  Container inputname() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 8),
      child: TextFormField(
        controller: _namefood,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter Menu Name';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFa9a29f), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFa9a29f), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          prefixIcon: Icon(
            Icons.emoji_objects,
            color: Color(0xFF8f837f),
          ),
          label: Text(
            'ชื่อเมนู',
            style: TextStyle(color: Color(0xFFa9a29f)),
          ),
        ),
      ),
    );
  }

  Container inputcook() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
      child: TextFormField(
        controller: _cooking,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please Enter cooking';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFa9a29f), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFFa9a29f), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          prefixIcon: Icon(
            Icons.restaurant,
            color: Color(0xFF8f837f),
          ),
          label: Text(
            'วิธีทำ',
            style: TextStyle(color: Color(0xFFa9a29f)),
          ),
        ),
      ),
    );
  }

  Widget addButton() {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        color: Color(0xff89dad0),
        //border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Icon(icon, size: 24),
          TextButton(
              onPressed: () {
                addMenu();
              },
              child: Text(
                'เพิ่มเมนู',
                style: TextStyle(color: Colors.brown[800]),
              )),
        ],
      ),
    );
    // return Container(
    //   width: 150,
    //   height: 40,
    //   margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
    //   child: ElevatedButton(
    //     style: ButtonStyle(
    //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //         RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(32),
    //         ),
    //       ),
    //     ),
    //     onPressed: addMenu,
    //     child: const Text('เพิ่มเมนู'),
    //   ),
    // );
  }

  Future<void> addMenu() async {
    return menuu
        .add({
          'name': _namefood.text,
          'cooking': _cooking.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to add menu: $error"));
  }
}
