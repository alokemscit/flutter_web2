import 'package:flutter/material.dart';

import '../settings/config.dart';


class PreviousHistoryTab extends StatefulWidget {
  const PreviousHistoryTab({
    super.key,
  });

  @override
  State<PreviousHistoryTab> createState() => _PreviousHistoryTabState();
}

class _PreviousHistoryTabState extends State<PreviousHistoryTab> {
  int index = 0;
  // @override
  // void initState() {
  //   super.initState();
  //   index = 0;
  
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: Container(
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
          //color: Colors.red,
          height: 180,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                     //  print("0");
                      setState(() {
                        index = 0;
                       
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        // padding: EdgeInsets.only(left: 2,right: 0,top: 2,bottom: 2),
                        margin: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color:
                              index != 0 ? Colors.grey[200] : Color.fromARGB(255, 247, 245, 245),
                          border:
                              Border.all(color: Colors.black, width: 0.1),
                        ),
                        child:  Text(
                          "OPD Consultancy History",
                          style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold ,color: index==0?Color.fromARGB(174, 25, 0, 250):Colors.black),
                        )),
                  ),


                  InkWell(
                    onTap: () {
                      setState(() {
                        index = 1;
                       // print("1");
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        color: index == 1 ? Colors.grey[200] : Colors.white,
                        border: Border.all(color: Colors.black, width: 0.1),
                      ),
                      child:  Text(
                        "Discharge Summary",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: index==1?Color.fromARGB(174, 25, 0, 250):Colors.black),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                 
                 color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1)),
              ))
            ],
          ),
        ));
  }
}
