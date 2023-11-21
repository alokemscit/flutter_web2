// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'component/widget/custom_button.dart';

class MyDataTable extends StatefulWidget {
  const MyDataTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  List<Map<String, dynamic>> data1 = [
    {
      "SERIAL": "1",
      "APPTIME": "09 : 30 AM",
      "HCN": "H123-019687",
      "TICKETNO": "P123-160286",
      "PATNAME": "Md. Rafu Sarder",
      "AGE": "52 Year(s) 4 Month(s) 11 Day(s)",
      "GENDER": "Male",
      "BILLINGTIME": "09 : 17 AM",
      "TKT_STATUS": "S",
      "AGEY": "52",
      "AGEIND": "O",
      "VISIT_TYPE": "R",
      "VISITOR_TYPE": "Report Visit"
    },
    {
      "SERIAL": "3",
      "APPTIME": "10 : 15 AM",
      "HCN": "H117-018834",
      "TICKETNO": "P123-160318",
      "PATNAME": "Md. Abul Hossain",
      "AGE": "63 Year(s) 3 Month(s) 21 Day(s)",
      "GENDER": "Male",
      "BILLINGTIME": "10 : 00 AM",
      "TKT_STATUS": "S",
      "AGEY": "63",
      "AGEIND": "O",
      "VISIT_TYPE": "C",
      "VISITOR_TYPE": "New Visit"
    },
    {
      "SERIAL": "4",
      "APPTIME": "10 : 30 AM",
      "HCN": "H121-046747",
      "TICKETNO": "P123-160339",
      "PATNAME": "Md. Kabir Ahamed",
      "AGE": "55 Year(s) 6 Month(s) 5 Day(s)",
      "GENDER": "Male",
      "BILLINGTIME": "10 : 16 AM",
      "TKT_STATUS": "S",
      "AGEY": "55",
      "AGEIND": "O",
      "VISIT_TYPE": "C",
      "VISITOR_TYPE": "New Visit"
    },
    {
      "SERIAL": "6",
      "APPTIME": "02 : 00 PM",
      "HCN": "H122-027166",
      "TICKETNO": "P123-160597",
      "PATNAME": "Rahima Akter",
      "AGE": "31 Year(s) 8 Month(s) 25 Day(s)",
      "GENDER": "Female",
      "BILLINGTIME": "01 : 24 PM",
      "TKT_STATUS": "V",
      "AGEY": "31",
      "AGEIND": "M",
      "VISIT_TYPE": "C",
      "VISITOR_TYPE": "New Visit"
    },
    {
      "SERIAL": "9",
      "APPTIME": "02 : 00 PM",
      "HCN": "H116-019416",
      "TICKETNO": "P123-160623",
      "PATNAME": "Hosneara Roje",
      "AGE": "54 Year(s) 9 Month(s) 18 Day(s)",
      "GENDER": "Female",
      "BILLINGTIME": "01 : 54 PM",
      "TKT_STATUS": "N",
      "AGEY": "54",
      "AGEIND": "O",
      "VISIT_TYPE": "R",
      "VISITOR_TYPE": "Report Visit"
    },
    {
      "SERIAL": "10",
      "APPTIME": "02 : 15 PM",
      "HCN": "H118-001324",
      "TICKETNO": "P123-160632",
      "PATNAME": "S M Delowar Hossain",
      "AGE": "56 Year(s) 8 Month(s) 24 Day(s)",
      "GENDER": "Male",
      "BILLINGTIME": "02 : 04 PM",
      "TKT_STATUS": "N",
      "AGEY": "56",
      "AGEIND": "O",
      "VISIT_TYPE": "C",
      "VISITOR_TYPE": "New Visit"
    }
  ];

  // Sample data
  List<Map<String, dynamic>> data = [
    {'id': 1, 'name': 'John', 'action': 'Button 1'},
    {'id': 2, 'name': 'Jane', 'action': 'Button 2'},
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table with Button Column'),
      ),
      body: Column(
        children: [
          Table(
            columnWidths: const {
              0: FixedColumnWidth(120),
              1: FlexColumnWidth(30),
              2: FlexColumnWidth(30),
              3: FlexColumnWidth(80),
              4: FlexColumnWidth(80),
              5: FlexColumnWidth(30),
              6: FlexColumnWidth(30),
              7: FlexColumnWidth(20),
              8: FlexColumnWidth(50),
              9: FlexColumnWidth(40),
              10: FlexColumnWidth(30),
            },
            children: [
              TableRow(children: [
                Container(
                  color: Color.fromARGB(255, 236, 234, 234),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Appontment Time'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('HCN'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Prescription no'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Patient Name'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Age'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Gender'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Billing Time'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Status'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Visit Type'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Action'),
                ),
              ]),
          
            ],
            border: TableBorder.all(
                width: 0.3, color: Color.fromARGB(255, 89, 92, 92)),
          ),

          Table(
            columnWidths: const {
              0: FixedColumnWidth(120),
              1: FlexColumnWidth(30),
              2: FlexColumnWidth(30),
              3: FlexColumnWidth(80),
              4: FlexColumnWidth(80),
              5: FlexColumnWidth(30),
              6: FlexColumnWidth(30),
              7: FlexColumnWidth(20),
              8: FlexColumnWidth(50),
              9: FlexColumnWidth(40),
              10: FlexColumnWidth(30),
            },
            children: data1.map((user) {
              return TableRow(children: [
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['APPTIME'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['HCN'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['TICKETNO'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['PATNAME'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['AGE'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['GENDER'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['BILLINGTIME'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['TKT_STATUS'],
                ),
                CustomContainer(
                  status: user['TKT_STATUS']=='N'?'N':user['VISITOR_TYPE'],
                  text: user['VISITOR_TYPE'],
                ),
                CustomButton(
                  
                  text: "Start Consultation",
                  onPressed: () {
                    
                    print('Button Clicked for ID ${user['TICKETNO']}');
                  },
                ),
              ]);
            }).toList(),
            border: TableBorder.all(width: 1, color: Colors.black),
          ),

         
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String text;
   final String status;
  const CustomContainer({
    Key? key,
    required this.text,
     this.status='S',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        
        decoration: BoxDecoration(
          color: status=='S'?Colors.purpleAccent:(status=='New Visit'?Color.fromARGB(255, 48, 121, 50):Color.fromARGB(255, 255, 216, 89))
        ),
        padding: EdgeInsets.all(8),
        child: Text(text,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
