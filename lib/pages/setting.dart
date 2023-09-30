// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:our_money/database/database.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _PengaturanState();
}

class _PengaturanState extends State<Setting> {
  final formKey = GlobalKey<FormState>();

  TextEditingController passwordInput = TextEditingController();
  TextEditingController confirmPasswordInput = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var db = DataBase();

  updatePassword() async {
    var res = await db.getPassword();

    if (passwordInput.text.toString() == res.toString()) {
      await db.updatePassword(confirmPasswordInput.text.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password berhasil diubah!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password tidak sama!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  updatePassword();
                }
              },
              child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 232, 144, 248),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 232, 144, 248),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Flexible(
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 144, 248),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Current Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password saat ini wajib diisi!';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: passwordInput,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'New Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password baru wajib diisi!';
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: confirmPasswordInput,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Image.asset(
                        'lib/assets/me.jpg',
                        width:
                            120, // Sesuaikan dengan ukuran yang Anda inginkan
                        height: 170,
                        fit: BoxFit
                            .cover, // Sesuaikan dengan cara Anda ingin gambar ditampilkan
                      ),
                    ),
                    const Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 232, 144, 248),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Nama\u{00A0} : Firdha Arga Putriani \n'
                      'Nim\u{00A0} : 2141764171 \n'
                      'Tanggal : 29 September 2023',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
