import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController date_controller;
  final String? label;
  final Color? bgColor;
  final double? height;
  final double? width;
  final bool? isBackDate;
  final Color borderColor;

  const CustomDatePicker(
      {super.key,
      required this.date_controller,
      this.label = 'Select Date',
      this.bgColor = const Color.fromARGB(255, 218, 216, 216),
      this.height = 35,
      this.width = 140,
      this.borderColor = Colors.black38,
      this.isBackDate = false});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  void initState() {
    super.initState();
    widget.date_controller.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    //String formattedDate =DateFormat('dd/MM/yyyy').format(DateTime.now());
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
          color: widget.bgColor,
          //border: Border.all(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        child: TextFormField(
          onTap: () {
            getDates();
          },
          controller: widget.date_controller,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(fontSize: 14),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: widget.borderColor, width: 0.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
            suffixIcon: InkWell(
                child: const Icon(Icons.calendar_month_outlined),
                onTap: () async {
                  getDates();
                }),
          ),
          readOnly: true,
        ),
      ),
    );
  }

  Future<void> getDates() async {
    DateTime? pickedDate = await showDatePicker(
      context: context, // Pass the correct BuildContext.
      initialDate: DateTime.now(),
      firstDate: widget.isBackDate! ? DateTime(1800) : DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
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
  }
}
