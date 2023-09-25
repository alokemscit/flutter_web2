// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hover_widget/hover_widget.dart';

import 'package:web_2/component/settings/responsive.dart';
import 'package:web_2/component/widget/topbar_button.dart';
import 'package:web_2/component/widget/vitalsign.dart';

import '../settings/config.dart';
import 'previous_history_tab.dart';
import 'tab_container.dart';

// ignore: must_be_immutable
class AppBarWithButton extends StatelessWidget {
  int index = 0;
  AppBarWithButton({
    Key? key,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        Container(
          height: 60,
          color: const Color.fromARGB(255, 85, 12, 255),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  TopbarButton(
                    caption: 'Recall Last\nPrescription',
                    // ignore: void_checks
                    fun: () {
                      print('Clicked!');
                    },
                    icon: Icons.receipt_long,
                    backcolor: Colors.amber,
                  ),
                  TopbarButton(
                    caption: 'Print\nPrescription',
                    // ignore: void_checks
                    fun: () {
                      print('Clicked2!');
                    },
                    icon: Icons.receipt_long,
                  ),
                  TopbarButton(
                    caption: 'Investigation\nReport',
                    // ignore: void_checks
                    fun: () {
                      print('Clicked3!');
                    },
                    icon: Icons.receipt_long,
                  ),
                ],
              ),
              const Text(
                "Prescription",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Responsive.isDesktop(context)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        ButtonFeedback(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // margin: const EdgeInsets.only(bottom: 4),
                              // margin: EdgeInsets.all(0),
                              padding: const EdgeInsets.only(
                                  top: 4, left: 2, right: 2, bottom: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.1, color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     color: Color.fromARGB(255, 1, 122, 82),
                                    //     blurRadius: 10,
                                    //     spreadRadius: 0.5,
                                    //     offset: Offset(0, 0)),
                                    BoxShadow(
                                        color: Color.fromARGB(255, 39, 99, 79),
                                        blurRadius: 15,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, -1))
                                  ]),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: 32,
                                    color: Color.fromARGB(255, 3, 221, 250),
                                  ),
                                  //Spacer(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Recall Last\nPrescription",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 221, 218, 218)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ButtonFeedback(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // margin: const EdgeInsets.only(bottom: 4),
                              // margin: EdgeInsets.all(0),
                              padding: const EdgeInsets.only(
                                  top: 4, left: 2, right: 2, bottom: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.1, color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     color: Color.fromARGB(255, 1, 122, 82),
                                    //     blurRadius: 10,
                                    //     spreadRadius: 0.5,
                                    //     offset: Offset(0, 0)),
                                    BoxShadow(
                                        color: Color.fromARGB(255, 39, 99, 79),
                                        blurRadius: 15,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, -1))
                                  ]),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: 32,
                                    color: Color.fromARGB(255, 3, 221, 250),
                                  ),
                                  //Spacer(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Recall Last\nPrescription",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 221, 218, 218)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ButtonFeedback(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // margin: const EdgeInsets.only(bottom: 4),
                              // margin: EdgeInsets.all(0),
                              padding: const EdgeInsets.only(
                                  top: 4, left: 2, right: 2, bottom: 4),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.1, color: Colors.blueAccent),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: const [
                                    // BoxShadow(
                                    //     color: Color.fromARGB(255, 1, 122, 82),
                                    //     blurRadius: 10,
                                    //     spreadRadius: 0.5,
                                    //     offset: Offset(0, 0)),
                                    BoxShadow(
                                        color: Color.fromARGB(255, 39, 99, 79),
                                        blurRadius: 15,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, -1))
                                  ]),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_long,
                                    size: 32,
                                    color: Color.fromARGB(255, 3, 221, 250),
                                  ),
                                  //Spacer(),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Recall Last\nPrescription",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 221, 218, 218)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ButtonFeedback(
                            child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.menu_sharp,
                            size: 32,
                            color: Colors.white,
                          ),
                        )),
                      ],
                    ),
            ],
          ),
        ),
       
       
       
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(color: Colors.black54, width: 1),
                      boxShadow: const [
                        BoxShadow(
                            color: backgroundColor,
                            blurRadius: 80.0,
                            spreadRadius: 8,
                            offset: Offset(2.0, 2.0)),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SizedBox(
                                width: 50,
                                height: 1,
                                child: Container(color: Colors.black),
                              ),
                            ),
                            const Text("Patient's Details:"),
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.black,
                                    width: double.infinity,
                                    height: 1,
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: const TextField(
                              maxLines: null,
                              expands: true,
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 255, 252, 252),
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                            CapWithTextFields(
                              caption: 'Heaght(CM)',
                              controller: TextEditingController(),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Responsive.isDesktop(context)
                  ? const PreviousHistoryTab()
                  : const SizedBox(),
              Responsive.isDesktop(context)
                  ? MediaQuery.of(context).size.width > 1710
                      ? Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border:
                                  Border.all(color: Colors.black54, width: 1),
                              boxShadow: const [
                                BoxShadow(
                                    color:backgroundColor,
                                    blurRadius: 80.0,
                                    spreadRadius: 8,
                                    offset: Offset(2.0, 2.0)),
                              ],
                            ),
                            height: 180,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 6, top: 28),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                    width: 100,
                                    height: 120,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text("Visit List Search By HCN"),
                                      SizedBox(
                                        height: 35,
                                        width: 150,
                                        child: TextField(
                                          maxLength: 11,
                                          // canRequestFocus : false,
                                          maxLines: 1,
                                          //   textCapitalization : TextCapitalization.none,
                                          // keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          textAlign: TextAlign.start,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              //  labelText: 'Enter text',
                                              counterText: '',
                                              border: OutlineInputBorder()),
                                          //  controller:controller ,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .purple // Background color
                                              ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Consultant\nPanel"),
                                          )),
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("Save & Print"),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      : const SizedBox()
                  : const SizedBox(),
            ],
          ),
        ),
       
         
        const TabContainer(
            
            ),
        
      ],
    );
  }
}
