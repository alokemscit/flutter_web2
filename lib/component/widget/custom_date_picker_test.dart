

import 'package:intl/intl.dart';

import '../../core/config/const.dart';

class CustomDatePickerDropDown extends StatefulWidget {
  // ignore: non_constant_identifier_names
   TextEditingController date_controller;
   String? label;
   Color? bgColor;
   double? height;
   double? width;
   bool? isBackDate;
   Color borderColor;
   Color fontColor;
   TextAlign? textAlign;
   bool isFilled;
   Color labelTextColor;
   double labelFontSize;
   Color hintTextColor;
   double borderRadious;
   Color focusedBorderColor;
   double focusedBorderWidth;
   Color enabledBorderColor;
   double enabledBorderwidth;
   bool isInputMode;
   bool isShowCurrentDate;
   FontWeight textfontWeight;
   double textfontSize;
   bool isOnleClickDate;
   bool isFutureDateDisplay;
   FocusNode? focusNode;

   CustomDatePickerDropDown({
    super.key,
    // ignore: non_constant_identifier_names
    required this.date_controller,
    this.label = 'Select Date',
    this.bgColor = const Color.fromARGB(255, 218, 216, 216),
    this.height = 28,
    this.width = 130,
    this.borderColor = appColorGrayLight,
    this.isBackDate = false,
    this.isFilled = true,
    this.fontColor = Colors.black,
    this.textAlign = TextAlign.start,
    this.labelTextColor = appColorGrayDark,
    this.hintTextColor = Colors.black,
    this.borderRadious = 0,
    this.focusedBorderColor = Colors.black,
    this.focusedBorderWidth = 0.4,
    this.enabledBorderColor = Colors.grey,
    this.enabledBorderwidth = 0.6,
    this.isInputMode = false,
    this.focusNode,
    this.isShowCurrentDate = false,
    this.textfontWeight = FontWeight.w500,
    this.textfontSize = 12,
    this.isOnleClickDate = false,
    this.isFutureDateDisplay = true,
    this.labelFontSize=12
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
      widget.date_controller.text = widget.date_controller.text == ''
          ? DateFormat('dd/MM/yyyy').format(DateTime.now())
          : widget.date_controller.text;
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
          popUpAnimationStyle: AnimationStyle(
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 300)),
          tooltip: widget.label,
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
                      bool bb = false;
                      try{
                        DateFormat('dd/MM/yyyy')
                              .parse(widget.date_controller.text);
                              bb=true;
                      }catch(e){
                        bb=false;
                      }

                      DateTime fromDate = widget.isShowCurrentDate
                          ? DateTime.now()
                          : bb? DateFormat('dd/MM/yyyy')
                              .parse(widget.date_controller.text): DateTime.now();

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
        style: customTextStyle.copyWith(
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
          labelStyle: customTextStyle.copyWith(
              color: widget.labelTextColor,
              fontWeight: FontWeight.normal,
              fontSize: widget.labelFontSize ),
          hintStyle: TextStyle(
              color: widget.hintTextColor, fontWeight: FontWeight.normal,),
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
        inputFormatters: [
                                      //dateFormatter,
                                      LengthLimitingTextInputFormatter(
                                          10), // Limit to 10 characters
                                      DateInputFormatter(),
                                    ],
       // readOnly: true,
        //  enabled: false,
        enableInteractiveSelection: false,
      );
}



class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String oldText = oldValue.text;
    String newText = newValue.text;

    // Prevent invalid characters (only digits and "/")
    if (!RegExp(r'^[0-9/]*$').hasMatch(newText)) {
      return oldValue;
    }

    // Handle backspace - allow deletion of "/"
    if (oldText.length > newText.length) {
      return newValue;
    }

    // Automatically insert the "/" at the right positions
    if (newText.length == 2 && !newText.contains("/")) {
      newText += '/';
    } else if (newText.length == 5 && newText.lastIndexOf("/") == 2) {
      newText += '/';
    }

    // Validate the day (dd) and month (mm)
    if (newText.length >= 2) {
      String day = newText.substring(0, 2);
      if (int.tryParse(day) != null &&
          (int.parse(day) < 1 || int.parse(day) > 31)) {
        return oldValue; // Invalid day
      }
    }
    if (newText.length >= 5) {
      String month = newText.substring(3, 5);
      if (int.tryParse(month) != null &&
          (int.parse(month) < 1 || int.parse(month) > 12)) {
        return oldValue; // Invalid month
      }
    }

    // Truncate if the user tries to exceed the format
    if (newText.length > 10) {
      newText = newText.substring(0, 10);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}