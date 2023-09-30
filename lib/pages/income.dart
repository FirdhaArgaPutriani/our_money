import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:our_money/database/database.dart';
import 'package:our_money/model/money.dart';

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  late Money money;
  final formKey = GlobalKey<FormState>();

  TextEditingController dateInput = TextEditingController();
  TextEditingController nominalInput = TextEditingController();
  TextEditingController keteranganInput = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future insertData() async {
    var db = DataBase();
    var money = Money(
      dateInput.text,
      int.parse(nominalInput.text),
      keteranganInput.text,
      'Income',
    );
    await db.saveMoney(money);
    print('Saved');
  }

  void _saveData() {
    if (formKey.currentState!.validate()) {
      insertData();
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    dateInput.dispose();
    nominalInput.dispose();
    keteranganInput.dispose();

    super.dispose();
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
                dateInput.clear();
                nominalInput.clear();
                keteranganInput.clear();
              },
              child: const Text('Cancel'),
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
            ElevatedButton(
              onPressed: _saveData,
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
          ],
        ),
      ),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Income',
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
                      'Title :',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title wajib diisi!';
                        }
                        return null;
                      },
                      controller: keteranganInput,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Nominal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nominal wajib diisi!';
                        }
                        return null;
                      },
                      controller: nominalInput,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      child: Center(
                        child: TextFormField(
                          controller: dateInput,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal wajib diisi!';
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            } else {}
                          },
                        ),
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
