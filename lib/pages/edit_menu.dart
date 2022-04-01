import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditMenuPage extends StatefulWidget {
  const EditMenuPage({Key? key, this.id}) : super(key: key);
  final String? id;

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final _editFormKey = GlobalKey<FormState>();
  CollectionReference menuu = FirebaseFirestore.instance.collection('menu');
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cooking = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name.text = '';
    _cooking.text = '';

    //สร้าง function ตอนเริ่มต้น สำหรับดึงข้อมูล
    getdata();
  }

  Future<void> getdata() async {
    FirebaseFirestore.instance
        .collection('menu')
        .doc(widget.id.toString())
        .get()
        .then((DocumentSnapshot value) {
      Map<String, dynamic> data = value.data()! as Map<String, dynamic>;
      setState(() {
        _name.text = data['name'];
        _cooking.text = data['cooking'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขเมนู'),
        backgroundColor: Color(0xff89dad0),
      ),
      body: Form(
        // key: _addFormKey,
        child: ListView(
          children: [
            editname(),
            editcook(),
            editButton(),
          ],
        ),
      ),
    );
  }

  Container editname() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 8),
      child: TextFormField(
        controller: _name,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาป้อนชื่อเมนู';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          prefixIcon: Icon(
            Icons.emoji_objects,
            color: Colors.blue,
          ),
          label: Text(
            'ชื่อเมนู',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Container editcook() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
      child: TextFormField(
        controller: _cooking,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาป้อนวิธีการทำ';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          prefixIcon: Icon(
            Icons.restaurant,
            color: Colors.blue,
          ),
          label: Text(
            'วิธีทำ',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget editButton() {
    return Container(
      width: 150,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        ),
        onPressed: updateBtn,
        child: const Text('แก้ไขข้อมูล'),
      ),
    );
  }

  Future<void> updateBtn() async {
    return menuu
        .doc(widget.id.toString())
        .update({
          'name': _name.text,
          'cooking': _cooking.text,
        })
        .then((value) => Navigator.pop(context))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
