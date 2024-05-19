import 'package:flutter/material.dart';
import 'package:web_2/component/widget/custom_datepicker.dart';
import 'package:web_2/for_test.dart';

import '../../component/widget/custom_button.dart';
import '../../component/widget/custom_search_box.dart';
import '../../component/widget/custom_textbox.dart';

class DoctorLeave extends StatelessWidget {
  const DoctorLeave({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
   // print(size.width);
    return Scaffold(
      backgroundColor:Colors.white, //kDefaultIconLightColor,
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
     padding: const EdgeInsets.all(8),
      width: 350 ,
      margin: const EdgeInsets.only(top: 20),
      //color: Colors.amber,
     // margin:EdgeInsets.only(left: 0) ,
     decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.grey,width: 0.1),
     ),
   alignment: Alignment.topCenter,
    child:  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Text("ID: ",style: TextStyle(fontWeight: FontWeight.w600),),
        const Text("1234"),
        const SizedBox(width: 6,),
        const Text("NAME: ",style: TextStyle(fontWeight: FontWeight.w600),),
        ConstrainedBox(constraints: const BoxConstraints(maxWidth: 220,maxHeight: 15),
        child: const Text("Md. Abjsjsh fhlksdh reeeee eee eee e re rerye",style: TextStyle(color: Color.fromARGB(255, 0, 42, 77)),)),
       ],),
       ),



    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
       padding: const EdgeInsets.all(4),
        width: 350 ,
        
        //color: Colors.amber,
       // margin:EdgeInsets.only(left: 0) ,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey,width: 0.1),
       ),
       alignment: Alignment.topCenter,
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text("Leave Info",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),
          ),
           Padding(
             padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
             child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                CustomDatePicker(date_controller: TextEditingController(),label: "From Date",bgColor: Colors.white,),
                 CustomDatePicker(date_controller: TextEditingController(),label: "To Date",bgColor: Colors.white,)
               ],),
           ),


           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8),
             child: CustomTextBox(caption: 'Remarks', controller: TextEditingController(), onChange: ( value) {  },
             width: 320,
             height: 80,
             maxLine: 4,
             maxlength: 150,
             ),
           ),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
  child:   Row(
  
    mainAxisAlignment:MainAxisAlignment.end,
  
    crossAxisAlignment:CrossAxisAlignment.start ,
  
    children: [
  
      CustomButton(text: "Submit", onPressed: (){})
  
    ],
  
  ),
)

        ],



      ),
         ),
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
