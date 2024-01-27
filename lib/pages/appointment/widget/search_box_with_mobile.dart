
import 'package:flutter/material.dart';
import 'package:web_2/model/patient_with_mob.dart';

class SearchBoxWithMobile extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const SearchBoxWithMobile(
      {super.key, required this.patient_list, required this.onTap});
  // ignore: non_constant_identifier_names
  final List<patient_with_mob> patient_list;
  final Function(int index) onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        height: 180,
        width: 370,
        decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400, width: 0.5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  Container(
                      // height: 20,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                        color: Colors.grey,
                        
                        border: Border.all(color: Colors.black, width: 0.3),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Text(
                          "HCN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Expanded(
                    child: Container(
                        // height: 20,
                        //  width: double.infinity,
                        decoration: BoxDecoration(
                           
                          color: Colors.grey,
                          border: Border.all(color: Colors.black, width: 0.3),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            "Name",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: patient_list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap:()=> onTap(index),
                        child: Row(
                          children: [
                            Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 0.1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child:
                                      Text(patient_list[index].hCN!.toString()),
                                )),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.black, width: 0.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(patient_list[index]
                                        .pATNAME!
                                        .toString()),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}