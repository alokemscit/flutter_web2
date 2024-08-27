

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../component/widget/custom_autocomplete.dart';
import '../../../component/widget/custom_datepicker.dart';
import '../../../component/widget/custom_dropdown.dart';
 
import '../../../component/widget/custom_icon_button.dart';
import '../../../component/widget/custom_textbox.dart';
 
import '../../../component/widget/iconbutton.dart';
import '../../../component/widget/light_rolling_switch.dart';
import '../bloc/mobile_search_bloc.dart';

class DialogBodyPartOne extends StatelessWidget {
  const DialogBodyPartOne({
    super.key,
    required this.genderID,
    required this.mobileTextController, required this.dateTextController,
  });

  final String? genderID;
  final TextEditingController mobileTextController;
  final TextEditingController dateTextController;

  @override
  Widget build(BuildContext context) {
   
     List<String> _year_list = List.generate(131, (index) => (index ).toString());
     List<String> _month_list = List.generate(12, (index) => (index + 1).toString());
     List<String> _days_list = List.generate(31, (index) => (index ).toString());

    return BlocBuilder<MobSearchBloc, MobSearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextBox(
                    caption: 'HCN',
                    width: 130,
                    maxlength: 11,
                    controller: TextEditingController(),
                    onChange: (String value) {},
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  CustomTextBox(
                    caption: 'Mobile',
                    textInputType: TextInputType.phone,
                    width: 130,
                    maxlength: 11,
                    controller: mobileTextController,
                    onChange: (String value) {
                      if (value.length == 11) {
                        context.read<MobSearchBloc>().add(
                            MobSearcheventSetStatus(
                                isSearch: true,
                                mobNo: mobileTextController.text));
                      } else {
                        context.read<MobSearchBloc>().add(
                            MobSearcheventSetStatus(
                                isSearch: false, mobNo: ''));
                      }
                    },
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:
                        // buildFloatingSearchBar(context)
                        CustomIconButton(
                      caption: "Find",
                      icon: Icons.find_in_page_rounded,
                      onTap: () async {
                        await _secondAlert(context);
                        // print("Truuuuuuuuuuuuuuuuuue");
                      },
                    ),
                  )
                ],
              ),
              CustomTextBox(
                caption: 'Name',
                width: double.infinity,
                maxlength: 150,
                controller: TextEditingController(),
                onChange: (String value) {},
              ),
              CustomTextBox(
                caption: 'Address',
                width: double.infinity,
                height: 50,
                maxlength: 250,
                textInputType: TextInputType.multiline,
                maxLine: null,
                controller: TextEditingController(),
                onChange: (String value) {},
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 4),
                    child: const Text("Age :"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 2),
                    child: CustomAutoComplete(
                      fruitOptions: _year_list,
                      caption: 'Year',
                      width: 55,
                      maxlength: 3,
                      textInputType: TextInputType.phone,
                      controller: TextEditingController(),
                      onChange: (String value) {
                        print(value.toString());
                      },
                      onSelected: (p0) {
                        print(p0.toString());
                      },
                    ),
                  ),

         Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4,left: 8),
                    child: CustomAutoComplete(
                      fruitOptions: _month_list,
                      caption: 'Month',
                      width: 58,
                      maxlength: 2,
                      textInputType: TextInputType.phone,
                      controller: TextEditingController(),
                      onChange: (String value) {
                        print(value.toString());
                      },
                      onSelected: (p0) {
                        print(p0.toString());
                      },
                    ),
                  ),


           Padding(
                    padding: const EdgeInsets.only(top: 4, right: 8,left: 4),
                    child: CustomAutoComplete(
                      fruitOptions: _days_list,
                      caption: 'Day(s)',
                      width: 60,
                      maxlength: 2,
                      textInputType: TextInputType.phone,
                      controller: TextEditingController(),
                      onChange: (String value) {
                        print(value.toString());
                      },
                      onSelected: (p0) {
                        print(p0.toString());
                      },
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 2),
                    child: CustomDatePicker(
                      width: 134,
                      date_controller: dateTextController,
                      bgColor: Colors.white,
                      height: 32,
                      label: "DOB",
                      isBackDate: true,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3,right: 3,top: 8,bottom: 4),// .symmetric(horizontal: 3, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropDown(
                      id: genderID,
                      list: const [],
                      onTap: (value) {
                        // groupID = value.toString();

                        // context.read<DropdownBloc>().add(setGroupID(
                        //     groupID: value.toString(), deptList: myModel.deptList));
                      },
                      width: 160,
                      labeltext: "Select Gender",
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomDropDown(
                      id: genderID,
                      list: const [],
                      onTap: (value) {
                        // groupID = value.toString();

                        // context.read<DropdownBloc>().add(setGroupID(
                        //     groupID: value.toString(), deptList: myModel.deptList));
                      },
                      width: 205,
                      labeltext: "Select Country",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextBox(
                      caption: 'Home Phone',
                      textInputType: TextInputType.phone,
                      width: 160,
                      maxlength: 11,
                      controller: TextEditingController(),
                      onChange: (String value) {},
                    ),
                    CustomTextBox(
                      caption: 'Contact Persion Mobile',
                      textInputType: TextInputType.phone,
                      width: 205,
                      maxlength: 11,
                      controller: TextEditingController(),
                      onChange: (String value) {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropDown(
                      id: genderID,
                      list: const [],
                      onTap: (value) {
                        // groupID = value.toString();

                        // context.read<DropdownBloc>().add(setGroupID(
                        //     groupID: value.toString(), deptList: myModel.deptList));
                      },
                      width: 160,
                      labeltext: "Visit Type",
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomDropDown(
                      id: genderID,
                      list: const [],
                      onTap: (value) {
                        // groupID = value.toString();

                        // context.read<DropdownBloc>().add(setGroupID(
                        //     groupID: value.toString(), deptList: myModel.deptList));
                      },
                      width: 205,
                      labeltext: "Booking Mode",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropDown(
                      id: genderID,
                      list: const [],
                      onTap: (value) {
                        // groupID = value.toString();

                        // context.read<DropdownBloc>().add(setGroupID(
                        //     groupID: value.toString(), deptList: myModel.deptList));
                      },
                      width: 160,
                      labeltext: "Package Type",
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    CustomDropDown(
                      id: genderID,
                      list: [],
                      onTap: (value) {
                        // groupID = value.toString();

                        // context.read<DropdownBloc>().add(setGroupID(
                        //     groupID: value.toString(), deptList: myModel.deptList));
                      },
                      width: 205,
                      labeltext: "Consultancy Type",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: CustomTextBox(
                  caption: 'Remarks',
                  width: double.infinity,
                  height: 50,
                  maxlength: 250,
                  textInputType: TextInputType.multiline,
                  maxLine: null,
                  controller: TextEditingController(),
                  onChange: (String value) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 4, right: 2),
                      child: Text(
                        'Is Send SMS ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 13, 27, 34)),
                      ),
                    ),
                    LiteRollingSwitch(
                      value: true,
                      width: 60,
                      textOn: 'Yes',
                      textOff: 'No',
                      colorOn: const Color.fromARGB(255, 0, 0, 0),
                      colorOff: Colors.blueGrey.withOpacity(0.5),
                      iconOn: Icons.check,
                      iconOff: Icons.close,
                      textOnColor: Colors.white70,
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'on' : 'Yes'}');
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 4, right: 2),
                      child: Text(
                        'Is For Telemedicine?',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 13, 27, 34)),
                      ),
                    ),
                    LiteRollingSwitch(
                      value: false,
                      width: 60,
                      textOn: 'Yes',
                      textOff: 'No',
                      colorOn: const Color.fromARGB(255, 0, 0, 0),
                      colorOff: Colors.blueGrey.withOpacity(0.5),
                      iconOn: Icons.check,
                      iconOff: Icons.close,
                      textOnColor: Colors.white70,
                      animationDuration: const Duration(milliseconds: 300),
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'on' : 'off'}');
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}


Future<void> _secondAlert(BuildContext context) async => showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('second alert dialog'),
        content: const SingleChildScrollView(
          child: Text('data'),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('pop'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
