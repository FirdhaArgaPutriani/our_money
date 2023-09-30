// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:our_money/database/database.dart';
import 'package:our_money/model/money.dart';
import 'package:our_money/pages/money.dart';

class MoneyData extends StatefulWidget {
  const MoneyData({Key? key}) : super(key: key);

  @override
  State<MoneyData> createState() => _MoneyDataState();
}

class _MoneyDataState extends State<MoneyData> {
  var db = DataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.all(20),
      ),
      appBar: AppBar(
        title: Text(
          'Detail',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 232, 144, 248),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Flexible(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                      future: db.getMoney(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }

                        var data = snapshot.data;

                        return snapshot.hasData
                            ? MoneyPage(data as List<Money>)
                            : const Center(
                                child: Text(
                                  'No Data',
                                ),
                              );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
