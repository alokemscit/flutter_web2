import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/app_time.dart';
import '../settings/config.dart';

class DoctorPanel extends StatelessWidget {
  final List<AppTime> data;
  const DoctorPanel({
    super.key, required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 300,
          child: Container(
            margin: const EdgeInsets.only(left: 8, top: 8),
            padding: const EdgeInsets.all(4),

            decoration: BoxDecoration(
                boxShadow: myboxShadow, borderRadius: BorderRadius.circular(8)),

            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 100,
                  // margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4)),
                  child: Image.network(
                    'https://www.asgaralihospital.com/storage/doctors/6PdvnL5IVQOr3zKwbsEkzQZRV.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 180, maxHeight: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. Name 4345 43436 43643643643",
                        style: GoogleFonts.caladea(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        "Sr. Consultant ",
                        style: GoogleFonts.caladea(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Container(
                        height: 0.5,
                        margin: EdgeInsets.only(bottom: 8, top: 4),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 41, 31, 1),
                            borderRadius: BorderRadius.circular(4)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 12, top: 6),
          height: MediaQuery.of(context).size.height - 190,
          width: 300,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 250, 249, 249),
              offset: Offset(2, 2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(31, 255, 255, 255),
              offset: Offset(-10, -10),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ]),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          boxShadow: myboxShadow),
                      child: Text(data[index].stime)),
                  //const SizedBox(width: 6,),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        print(data[index].stime);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          // boxShadow: myboxShadow
                        ),
                        child: Text(data[index].comments),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
