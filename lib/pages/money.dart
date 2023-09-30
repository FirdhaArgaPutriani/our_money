import 'package:flutter/material.dart';
import 'package:our_money/model/money.dart';

class MoneyPage extends StatefulWidget {
  final List<Money> MoneyData;

  const MoneyPage(this.MoneyData, {Key? key}) : super(key: key);

  @override
  State<MoneyPage> createState() => _MoneyPageState();
}

class _MoneyPageState extends State<MoneyPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.MoneyData.length,
      itemBuilder: (BuildContext context, int index) {
        Color iconColor = widget.MoneyData[index].tipe == 'Income'
            ? Colors.green // Warna hijau untuk Income
            : Colors.red;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rp. ${widget.MoneyData[index].nominal.toString()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.MoneyData[index].keterangan,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.MoneyData[index].tanggal,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    widget.MoneyData[index].tipe == 'Income'
                        ? Icons.arrow_circle_up // Icon untuk income
                        : Icons.arrow_circle_down, // Icon untuk outcome
                    size: 70.0,
                    color: iconColor,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
