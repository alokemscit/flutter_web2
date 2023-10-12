import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController date_controller;
  final String? label;

  const CustomDatePicker(
      {super.key, required this.date_controller, this.label = 'Select Date'});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}


class _CustomDatePickerState extends State<CustomDatePicker> {


@override
void initState() {
  super.initState();
 widget.date_controller.text =   DateFormat('dd/MM/yyyy').format(DateTime.now());
}


  @override
  Widget build(BuildContext context) {
    //String formattedDate =DateFormat('dd/MM/yyyy').format(DateTime.now());
    return SizedBox(
      width: 140,
      height: 35,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: TextFormField(
          controller: widget.date_controller,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(fontSize: 14),
            border: const OutlineInputBorder(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            suffixIcon: InkWell(
              child: const Icon(Icons.calendar_month_outlined),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context, // Pass the correct BuildContext.
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                      setState(() {
                         widget.date_controller.text = formattedDate;
                      });
                 
                } else {
                  // print("Date is not selected");
                  setState(() {
                     widget.date_controller.text =
                      DateFormat('dd/MM/yyyy').format(DateTime.now());
                  });
                 
                }
              },
            ),
          ),
          readOnly: true,
        ),
      ),
    );
  }
}
