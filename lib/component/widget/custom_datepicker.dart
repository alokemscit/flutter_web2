
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    // ignore: non_constant_identifier_names
    required TextEditingController date_controller, this.label='Select Date',
  }) : _date_controller = date_controller;

  // ignore: non_constant_identifier_names
  final TextEditingController _date_controller;
  final String? label;
  @override
  Widget build(BuildContext context) {
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
          controller: _date_controller,
          decoration: InputDecoration(
            labelText: label,
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
                  _date_controller.text = formattedDate;
                } else {
                  // print("Date is not selected");
                  _date_controller.text = '';
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