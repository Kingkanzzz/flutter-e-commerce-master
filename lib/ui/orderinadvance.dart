
import 'package:flutter/material.dart';

//สั่งล่วงหน้า
class OrderInAdvance extends StatefulWidget {
  @override
  State<OrderInAdvance> createState() => _OrderInadvanceState();
}

class _OrderInadvanceState extends State<OrderInAdvance> {
  DateTime? _date;
  @override
  Widget build(BuildContext context) {
    _dateString() {
      if (_date == null) {
        return 'วันที่ต้องการสั่งล่วงหน้า';
      } else {
        return '${_date?.day} - ${_date?.month} - ${_date?.year}';
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('สั่งล่วงหน้า')),
      body: Align(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Text(
            _dateString(),
            style: TextStyle(
              fontSize: 36,
            ),
          ),
          ElevatedButton.icon(
              onPressed: () async {
                final result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2010),
                  lastDate: DateTime(2050),
                );
                if (result != null) {
                  setState(() {
                    _date = result;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text('เลือกวันที่ต้องการ')),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 30, 0, 0),
                child: Row(
                  children: [
                    InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderInAdvance(),
                        ));
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      child: Text(
                        "แชท",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => PayMent(),
                    //     ));
                  },
                  child: Container(
                    height: 40,
                    width: 110,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      child: Text(
                        "ชำระเงิน",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                  ],
                ),
              )
        ]),
      ),
    );
    
  }
}