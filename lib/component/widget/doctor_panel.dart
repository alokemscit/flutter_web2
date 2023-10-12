import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/app_time.dart';
import '../settings/config.dart';

class DoctorPanel extends StatelessWidget {
  final List<AppTime> data;
  const DoctorPanel({
    super.key,
    required this.data,
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
                const SizedBox(
                  width: 2,
                ),
                DoctorPhotPanel(data: data),
                const SizedBox(
                  width: 2,
                ),
                DoctorInfoPanel(data: data)
              ],
            ),
          ),
        ),
        DoctorSlotPanel(data: data)
      ],
    );
  }
}

class DoctorSlotPanel extends StatelessWidget {
  const DoctorSlotPanel({
    super.key,
    required this.data,
  });

  final List<AppTime> data;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                height: 48,
                margin: const EdgeInsets.all(0),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                decoration: BoxDecoration(
                    border:
                        Border.all(color: Colors.black.withOpacity(0.3)),
                    boxShadow: myboxShadow),
                alignment: Alignment.centerLeft,
                child: Align(
                  child: Text(
                    data[index].stime,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              //const SizedBox(width: 6,),
              Expanded(
                  child: getInkWell(data[index].status)
                      ? InkWell(
                          onTap: () => _dialogBuilder(context,data[index]),
                          child: RightCellDoctorPanel(data: data,index: index,),
                        )
                      : RightCellDoctorPanel(data: data,index: index,),
                      ),
            ],
          );
        },
      ),
    );
  }
}

class DoctorInfoPanel extends StatelessWidget {
  const DoctorInfoPanel({
    super.key,
    required this.data,
  });

  final List<AppTime> data;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxWidth: 180, maxHeight: 120),
      child: Stack(
        children:[
          Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.isNotEmpty ? data[0].name : '',
              style: GoogleFonts.caladea(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              data.isNotEmpty ? data[0].designation : '',
              style: GoogleFonts.caladea(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Container(
              height: 0.5,
              margin: const EdgeInsets.only(bottom: 8, top: 4),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 41, 31, 1),
                  borderRadius: BorderRadius.circular(4)),
            )
          ],
        ),

         Positioned(
          top: 2,
          right: 2,
          child: TextButton(onPressed:(){}, child: const Text('Edit for slot block',style: TextStyle(fontSize: 10,color: Color.fromARGB(255, 0, 41, 224)),))
          )

        ]
         
      ),
    );
  }
}

class DoctorPhotPanel extends StatelessWidget {
  const DoctorPhotPanel({
    super.key,
    required this.data,
  });

  final List<AppTime> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 120,
      width: 100,
      // margin: const EdgeInsets.only(left: 4),
      decoration: BoxDecoration(
         // color: Colors.grey.withOpacity(0.051),
          //border: Border.all(color: Colors.grey.withOpacity(0.3),width: 0.3),
          borderRadius:  BorderRadius.circular(8)
          )
          ,
      child: Image.network(
         
       // alignment : Alignment.topLeft,
        data.isNotEmpty
            ? data[0].image
            : 'https://www.asgaralihospital.com/frontend/images/logo/aah-logo.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context, AppTime? data) {
  
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation:0,
          title:  Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 54, 6, 230).withOpacity(0.8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data!.name,style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 2,),
                  Text('Slot Time : ${data.date}',style: const TextStyle(fontSize: 14,color: Colors.white70,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 2,),
                  Text('Slot Time : ${data.stime}',style: const TextStyle(fontSize: 14,color: Colors.white70,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ),
           titlePadding:  EdgeInsets.zero,
           contentPadding:const EdgeInsets.all(8),
          content: Container(
            decoration: BoxDecoration(
               border: Border.all(color: Colors.grey.shade300)
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                     
                  ],
                ),
              ],
            ),
          ),

          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




class RightCellDoctorPanel extends StatelessWidget {
  const RightCellDoctorPanel({
    super.key,
    required this.data, required this.index,
  });

  final List<AppTime> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 48),
      height: 48,
      // constraints: const BoxConstraints(maxHeight: 100),
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          color: GetColor(data[index].status).withOpacity(0.2)
          // boxShadow: myboxShadow
          ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(data[index].comments.replaceAll(r'\n', '\n')),
      ),
    );
  }
}

bool getInkWell(String k) {
  switch (k) {
    case 'L':
      return false;
    case 'B':
      return false;
    case 'S':
      return false;
    default:
      return true;
  }
}

Color GetColor(String tp) {
  switch (tp) {
    case 'N':
      return Colors.white;
    case 'A':
      return Color.fromARGB(255, 7, 235, 7);
    case 'V':
      return Colors.white;
    case 'B':
      return Colors.yellow;
    case 'L':
      return Colors.yellow;
    case 'S':
      return Color.fromARGB(255, 146, 2, 2);
    default:
      return Colors.white;
  }
}
