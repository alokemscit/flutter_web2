
// ignore_for_file: non_constant_identifier_names

 

import '../../core/config/const.dart';

Future<void> CustomDialog(BuildContext context, Widget title,
    Widget bodyContent, void Function() onPress,
    [bool scrollable = true,bool isSaveButton=true]
    ) {
  final GlobalKey buttonKey = GlobalKey();
  bool isButtonDisabled = false;
  void disableButton() {
    isButtonDisabled = true;
    Future.delayed(const Duration(seconds: 1), () {
      // Enable the button after the delay
      if (buttonKey.currentContext != null) {
        isButtonDisabled = false;
      }
    });
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void _onButtonPressed() {
    if (!isButtonDisabled) {
      onPress();
      disableButton();
    }
  }

  return showDialog<void>(
    //barrierColor:Colors.white,
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        actionsPadding:EdgeInsets.zero,
        backgroundColor: Colors.white.withOpacity(0.8),
        surfaceTintColor: Colors.white.withOpacity(0.5),
        scrollable: scrollable,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        contentPadding: const EdgeInsets.only(top: 5.0),
        // elevation: 0,
        title: Material(
          color: Colors.transparent,
          child: Container(
             decoration: BoxDecorationForAccordian,
            
            
            child: title)
          ), //AppointDialogTitle(data: data,),
        titlePadding: EdgeInsets.zero,
        // contentPadding: const EdgeInsets.all(8),
        content: Container(
          decoration: customBoxDecoration.copyWith(borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: bodyContent,
          ),
        ), //AppointmentDialogBody(),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child:  Text('Close',style: customTextStyle,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
         isSaveButton? TextButton(
            key: buttonKey,
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            onPressed: _onButtonPressed,
            child:  Text('Save',style: customTextStyle,),
          ):const SizedBox(),
        ],
      );
    },
  );
}
