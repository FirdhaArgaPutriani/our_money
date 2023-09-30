import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:our_money/database/database.dart';
import 'package:our_money/pages/income.dart';
import 'package:our_money/pages/moneyData.dart';
import 'package:our_money/pages/outcome.dart';
import 'package:our_money/pages/setting.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = DataBase();
  var formatCurrency = NumberFormat.currency(locale: 'id', symbol: 'Rp. ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          },
          child: const Text('Logout'),
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
      ),
      appBar: AppBar(
        title: Text(
          'Our Money',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 232, 144, 248),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Flexible(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: db.getTotalNominalByType('Income'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }

                      var data = snapshot.data;

                      return snapshot.hasData
                          ? Text(
                              "Income   : " + formatCurrency.format(data),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Rp. 0',
                              ),
                            );
                    },
                  ),
                  FutureBuilder(
                    future: db.getTotalNominalByType('Outcome'),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                      }

                      var data = snapshot.data;

                      return snapshot.hasData
                          ? Text(
                              "Outcome :" + formatCurrency.format(data),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Rp. 0',
                              ),
                            );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Income(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 247, 204, 255),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 222, 71, 248),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.attach_money,
                                    size: 70.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Outcome(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 247, 204, 255),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 222, 71, 248),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.money_off,
                                    size: 70.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Outcome',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const MoneyData(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 247, 204, 255),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 222, 71, 248),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.folder_copy_outlined,
                                    size: 70.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Detail',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Setting(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 247, 204, 255),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 222, 71, 248),
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.admin_panel_settings_outlined,
                                    size: 70.0,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Setting',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
