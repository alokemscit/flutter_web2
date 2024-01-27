// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class CustomForm extends ViewModelWidget<CustomFormViewModel> {
//   @override
//   Widget build(BuildContext context, CustomFormViewModel model) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(40.0), // Adjust the height as needed
//         child: TitleBar(
//           minimizeButton: true,
//           maximizeButton: true,
//           onClose: () {
//             // Implement close button action
//             model.closeForm();
//           },
//           onMinimize: () {
//             // Implement minimize button action
//             model.minimizeForm();
//           },
//           onMaximize: () {
//             // Implement maximize button action
//             model.maximizeForm();
//           },
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("Your Form Content Goes Here"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement form submission logic
//                 model.submitForm();
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomFormViewModel extends BaseViewModel {
//   bool minimized = false;
//   bool maximized = false;

//   void closeForm() {
//     // Implement close button action
//     // Close the form or navigate away
//   }

//   void minimizeForm() {
//     // Implement minimize button action
//     minimized = true;
//     notifyListeners();
//   }

//   void maximizeForm() {
//     // Implement maximize button action
//     maximized = !maximized;
//     notifyListeners();
//   }

//   void submitForm() {
//     // Implement form submission logic
//     // Access form data and perform actions
//   }
// }
