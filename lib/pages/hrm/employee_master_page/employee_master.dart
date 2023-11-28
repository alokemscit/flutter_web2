import 'package:flutter/material.dart';
import 'package:web_2/component/settings/config.dart';
import 'package:web_2/component/widget/custom_datepicker.dart';
import 'package:web_2/component/widget/custom_dropdown.dart';
import 'package:web_2/component/widget/custom_textbox.dart';

class EmployeeMaster extends StatelessWidget {
  const EmployeeMaster({super.key});
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: _leftPart(),
                ),
                Expanded(
                    flex: 4,
                    child: _middlePart(),
                    ),
                Expanded(
                    flex: 3,
                    child: Container(
                      // height: 200,
                      color: const Color.fromARGB(255, 7, 114, 255),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_leftPart() {
  return Container(
    decoration: BoxDecorationTopRounded,
    // height: 200,
    //  color: Colors.amber,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                "Basic Information:",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline),
              ),
            ),
            CustomTextBox(
                caption: "ID",
                width: 100,
                maxlength: 10,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomDropDown(
                    id: null,
                    height: 33,
                    labeltext: "Prefix",
                    list: const [],
                    onTap: (v) {},
                    width: 100),
                const Icon(
                  Icons.launch_outlined,
                  size: 18,
                  color: kGrayColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                    child: CustomTextBox(
                        caption: "Name",
                        width: double.infinity,
                        maxlength: 100,
                        isFilled: true,
                        controller: TextEditingController(),
                        onChange: (v) {})),
              ],
            ),


 Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: CustomDatePicker(
                    date_controller: TextEditingController(),
                    label: "Date of Birth",
                    bgColor: Colors.white,
                    height: 32,
                    isBackDate: true,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: CustomDropDown(
                      id: null,
                      height: 32,
                      labeltext: "Nationality",
                      list: const [],
                      onTap: (v) {},
                      width: 100),
                ),
              ],
            ),
           




            CustomTextBox(
                caption: "Father's Name",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            CustomTextBox(
                caption: "Mother's name",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            CustomTextBox(
                caption: "Spouse Name",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Gender",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Religion",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                )
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Maritial Status",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Blood Group",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

           
           
           
              Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: CustomDropDown(
                      id: null,
                      height: 32,
                      labeltext: "Identity Type",
                      list: const [],
                      onTap: (v) {},
                      width: 100),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: CustomTextBox(
                caption: "Identity Number",
                width: double.infinity,
                maxlength: 100,
                isFilled: true,
                controller: TextEditingController(),
                onChange: (v) {}),
                ),
              ],
            ),
           
          ],
        ),
      ),
    ),
  );
}



_middlePart() {
  return Container(
    decoration: BoxDecorationTopRounded,
    // height: 200,
    //  color: Colors.amber,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 8),
              child: Text(
                "General Official Information:",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 38,),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomDropDown(
                                  id: null,
                                  height: 32,
                                  labeltext: "Company",
                                  list: const [],
                                  onTap: (v) {},
                                  width:double.infinity ),
                ),
                 InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ),
              ],
            ),
                      
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Designation",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Grade",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
           



  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Department",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Unit/Section",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
           



  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Type of Employeement",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Current Job Status",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      const Icon(
                        Icons.launch_outlined,
                        size: 18,
                        color: kGrayColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
           

 Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDatePicker(
                    date_controller: TextEditingController(),
                    label: "Date of Join",
                    bgColor: Colors.white,
                    height: 32,
                    isBackDate: true,
                  ),
                      ),
                       
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomDropDown(
                            id: null,
                            height: 32,
                            labeltext: "Current Job Status",
                            list: const [],
                            onTap: (v) {},
                            width: 100),
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.launch_outlined,
                          size: 18,
                          color: kGrayColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

           
 
           
            CustomTextBox(
                caption: "Notes",
                width: double.infinity,
               textInputType: TextInputType.multiline,
                        isFilled: true,
                        maxLine: 4,
                        maxlength: 500,
                       height: 116,
                
                controller: TextEditingController(),
                onChange: (v) {}),
          ],
        ),
      ),
    ),
  );
}
