import 'package:intl/intl.dart';

import '../core/config/const.dart';

class DropdownCalendar extends StatefulWidget {
  const DropdownCalendar({super.key});

  @override
  _DropdownCalendarState createState() => _DropdownCalendarState();
}

class _DropdownCalendarState extends State<DropdownCalendar> {
  DateTime? selectedDate;
  final TextEditingController txt_date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomDatePickerDropDown(
      isShowCurrentDate: true,
      date_controller: txt_date,
      fontColor: Colors.black,
      textfontWeight: FontWeight.w600,

      // borderRadious: 50,
    ));
  }
}

class CustomDatePickerDropDown extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final TextEditingController date_controller;
  final String? label;
  final Color? bgColor;
  final double? height;
  final double? width;
  final bool? isBackDate;
  final Color borderColor;
  final Color fontColor;
  final TextAlign? textAlign;
  final bool isFilled;
  final Color labelTextColor;
  final Color hintTextColor;
  final double borderRadious;
  final Color focusedBorderColor;
  final double focusedBorderWidth;
  final Color enabledBorderColor;
  final double enabledBorderwidth;
  final bool isInputMode;
  final bool isShowCurrentDate;
  final FontWeight textfontWeight;
  final double textfontSize;
  final bool isOnleClickDate;
  final bool isFutureDateDisplay;
  final FocusNode? focusNode;
   
  const CustomDatePickerDropDown({
    super.key,
    // ignore: non_constant_identifier_names
    required this.date_controller,
    this.label = 'Select Date',
    this.bgColor = const Color.fromARGB(255, 218, 216, 216),
    this.height = 28,
    this.width = 130,
    this.borderColor = appColorGrayLight,
    this.isBackDate = false,
    this.isFilled = false,
    this.fontColor = Colors.black87,
    this.textAlign = TextAlign.start,
    this.labelTextColor = Colors.black87,
    this.hintTextColor = Colors.black,
    this.borderRadious = 0,
    this.focusedBorderColor = Colors.black,
    this.focusedBorderWidth = 0.3,
    this.enabledBorderColor = Colors.grey,
    this.enabledBorderwidth = 0.4,
    this.isInputMode = false,
    this.focusNode,
    this.isShowCurrentDate = false,
    this.textfontWeight = FontWeight.w500,
    this.textfontSize = 13,
    this.isOnleClickDate = false,
    this.isFutureDateDisplay = true,   
  });


  @override
  State<CustomDatePickerDropDown> createState() =>
      _CustomDatePickerDropDownState();
}

class _CustomDatePickerDropDownState extends State<CustomDatePickerDropDown> {
  bool isMonth = false;
  @override
  void initState() {
    super.initState();
    if (widget.isShowCurrentDate) {
      widget.date_controller.text =
          DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    //String formattedDate =DateFormat('dd/MM/yyyy').format(DateTime.now());
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadious),
          color: Colors.white,
          
 


        ),
        width: widget.width,
        height: widget.height,
        child: PopupMenuButton<int>(
          padding: EdgeInsets.zero,
          shadowColor: appGray100,
       popUpAnimationStyle: AnimationStyle(curve:Curves.bounceOut,duration: const Duration(milliseconds: 800) ),

          tooltip: 'Select date',
          itemBuilder: (context) => [
            PopupMenuItem<int>(
              onTap: () {},
              enabled: false,
              value: 1,
              child: SizedBox(
                
                width: 280,
                height: 220,
                child: Theme(
                  data: ThemeData(
                    textTheme: const TextTheme(
                      titleSmall: TextStyle(
                        fontSize: 12, // Adjust font size as needed
                        fontWeight: FontWeight.normal,
                        color: Colors.black, // Adjust text color as needed
                      ),
                    ),
                  ),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate:
                        widget.isBackDate! ? DateTime(2000) : DateTime.now(),
                    lastDate: widget.isFutureDateDisplay
                        ? DateTime.now().add(const Duration(days: 365))
                        : DateTime.now(),
                    initialCalendarMode: DatePickerMode.day,
                    onDisplayedMonthChanged: (DateTime newDate) {
                      isMonth = true;
                    },
                    onDateChanged: (DateTime value) {
                      DateTime fromDate = widget.isShowCurrentDate
                          ? DateTime.now()
                          : DateFormat('dd/MM/yyyy')
                              .parse(widget.date_controller.text);
                      if (value.day != fromDate.day &&
                          value.month != fromDate.month &&
                          isMonth) {
                        isMonth = false;
                        //return;
                      }
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(value);

                      //  print(formattedDate);
                      setState(() {
                        widget.date_controller.text = formattedDate;
                        if (!isMonth) {
                          Navigator.of(context).pop();
                        }
                        isMonth = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          ],
          child: Stack(
            children: [
              _cText(widget),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _cText(dynamic widget) => TextFormField(
        focusNode: widget.focusNode,

        controller: widget.date_controller,
        style: TextStyle(
            fontFamily: "Muli",
            fontSize: widget.textfontSize,
            fontWeight: widget.textfontWeight,
            color: widget.fontColor),
        textAlignVertical: TextAlignVertical.center,
        textAlign: widget.textAlign!,
        decoration: InputDecoration(
          fillColor: Colors
              .white, // Color.fromARGB(255, 253, 253, 255), //Colors.white,
          filled: widget.isFilled,
          labelText: widget.label,
          labelStyle: TextStyle(
              color: widget.labelTextColor,
              fontWeight: FontWeight.w300,
              fontSize: 13),
          hintStyle: TextStyle(
              color: widget.hintTextColor, fontWeight: FontWeight.w300),
          counterText: '',
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadious)),
              borderSide: const BorderSide(color: Colors.white)),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadious),
            borderSide: BorderSide(
                color: widget.focusedBorderColor,
                width: widget.focusedBorderWidth),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadious),
            borderSide: BorderSide(
                color: widget.enabledBorderColor,
                width: widget.enabledBorderwidth),
          ),
          // contentPadding:
          //   const EdgeInsets.symmetric(vertical: 0, horizontal: 4),

          contentPadding: const EdgeInsets.only(
              bottom: 8,
              left: 6,
              right: 4) //.symmetric(vertical: 8, horizontal: 6),
          ,

          suffixIcon: const Icon(Icons.calendar_month_outlined),
        ),
        readOnly: true,
        //  enabled: false,
        enableInteractiveSelection: false,
      );
}
