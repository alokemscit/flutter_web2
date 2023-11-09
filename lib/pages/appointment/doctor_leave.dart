import 'package:flutter/material.dart';

import '../../component/widget/custom_search_box.dart';

class DoctorLeave extends StatelessWidget {
  const DoctorLeave({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
   // print(size.width);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: size.height - 28,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSearchBox(
                      caption: "Search Doctor",
                      borderRadious: 8.0,
                      width: 350,
                      controller: TextEditingController(),
                      onChange: (val) {}),
                  Container(
                    width: 350,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey, width: 0.3)),
                  ),
                  

       Container(
   alignment: Alignment.center,
   child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text("Doc Id: "),
        Text("Doc Id: "),
        Text("Name: "),
        Text("Doc Id: "),
       ],),
       ),
                ],
              ),
 

Expanded(
  child:   Container(
  
    decoration: BoxDecoration(
  
      borderRadius: BorderRadius.circular(8),
  
      border: Border.all(color: Colors.grey,width: 0.3)
  
    ),
  
  ),
)

            ],
          ),




        ),
      ),
    );
  }
}
