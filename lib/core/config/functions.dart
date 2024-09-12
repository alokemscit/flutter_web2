// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
 

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:web_2/core/config/const.dart';

import '../entity/entity_age.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Age> AgeCalculator(DateTime birthDate) async {
  final now = DateTime.now();
  int years = now.year - birthDate.year;
  int months = now.month - birthDate.month;
  int days = now.day - birthDate.day;

  // Check if the birthday has occurred this year
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    years--;
    months += 12;
  }

  // Adjust months and days if days < 0
  if (days < 0) {
    months--;
    days += DateTime(now.year, now.month - 1, 0).day;
  }

  // Adjust years if months < 0
  if (months < 0) {
    years--;
    months += 12;
  }

  return Age(years: years, months: months, days: days);
}

Future<void> savePdf(BuildContext context, String url) async {
  CustomBusyLoader loader = CustomBusyLoader(context: context);
  try {
    loader.show();
    //await Share.share(url);
    final filename = url.substring(url.lastIndexOf("/") + 1);
    final response = await http.get(Uri.parse(url));
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    loader.close();
    await Share.shareFiles([(file.path)], text: 'Inv Report');
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('PDF saved')));
  } catch (e) {
    loader.close();
    print(e.toString());
  }
}

CustomCupertinoAlertWithYesNo(BuildContext context, Widget title,
    Widget content, void Function() no, void Function() yes,
    [String? noButtonCap, String? yesButtonCap]) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: title,
        content: Container(
          // Wrap content in a container to allow for better layout adjustments
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: content,
        ),
        actions: [
          CupertinoDialogAction(
            child: Text(noButtonCap ?? 'No'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              no();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true, // Emphasize the primary action
            child: Text(yesButtonCap ?? 'Yes'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              yes();
            },
          ),
        ],
      );
    },
  );
}

Future<File> getImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    return File(pickedImage.path);
  } else {
    return File(''); // or return File(); for an empty file
  }
}

Future<String> imageFileToBase64(String fileUrl) async {
  // Fetch the file content using an HTTP request
  if (!kIsWeb) {
    File inputFile = File(fileUrl);
    List<int> fileBytes = inputFile.readAsBytesSync();
    String base64String = base64Encode(fileBytes);
    return base64String;
  }
  var response = await http.get(Uri.parse(fileUrl));

  if (response.statusCode == 200) {
    // Convert the file content to Base64
    String base64String = base64Encode(response.bodyBytes);
    return base64String;
  } else {
    throw Exception('Failed to load file');
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// Future<ModelStatus> getStatusWithDialog(
//   List<dynamic> jsonData,
//   CustomAwesomeDialog dialog,
// ) async {
//   //print(jsonData);
//   if (jsonData.isEmpty) {
//     dialog
//       ..dialogType = DialogType.error
//       ..message = "Server error!"
//       ..show();
//     return ModelStatus(id: "", msg: "Server error", status: "4");
//   }
//   DialogType dt;
//   String msg = '';
//   ModelStatus list = jsonData
//       .map(
//         (e) => ModelStatus.fromJson(e),
//       )
//       .first;

//   dt = DialogType.success;
//   if (list.status == "2") {
//     dt = DialogType.warning;
//   }
//   if (list.status == "3") {
//     dt = DialogType.error;
//   }
//   msg = list.msg!;
//   if (list.status != "1") {
//     dialog
//       ..dialogType = dt
//       ..message = msg
//       ..show();
//   }
//   return list;
// }

Map<int, TableColumnWidth> CustomColumnWidthGenarator(List<int> columnWidth) {
  final Map<int, TableColumnWidth> columnWidthMap = {};

  for (int i = 0; i < columnWidth.length; i++) {
    columnWidthMap[i] = FlexColumnWidth(columnWidth[i].toDouble());
  }

  return columnWidthMap;
}

const _kDefaultDecoration = BoxDecoration(
  color: kBgDarkColor,
);

CustomTableRow(
  List<String> col, [
  Decoration decoration = _kDefaultDecoration,
]) {
  return TableRow(
    decoration: decoration,
    children: col
        .map((e) => TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  e,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ))
        .toList(),
  );
}

CustomTableRowWithWidget(
  List<Widget> col, [
  Decoration decoration = _kDefaultDecoration,
]) {
  return TableRow(
    decoration: decoration,
    children: col
        .map((e) => TableCell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: e,
              ),
            ))
        .toList(),
  );
}

CustomTableEditCell(Function() onTap,
        [IconData icon = Icons.edit, double iconSize = 14,Color iconColor= kWebHeaderColor]) =>
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Center(
            child: InkWell(
          onTap: () {
            // print('object');
            onTap();
          },
          child: Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
        )),
      ),
    );

CustomTableCell2(String? text,
        [isCenter = false,
        double fintSize = 12,
        FontWeight fontweight = FontWeight.w400]) =>
    TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: isCenter
            ? Center(
                child: Text(
                  text!,
                  style: customTextStyle.copyWith(
                      fontSize: fintSize, fontWeight: fontweight),
                ),
              )
            : Text(
                text!,
                style: customTextStyle.copyWith(
                    fontSize: fintSize, fontWeight: fontweight),
              ),
      ),
    );


    Widget CustomTableColumnHeaderBlack(String text,
    [
      AlignmentGeometry? alignment = Alignment.centerLeft,
      double fontSize = 12,
    FontWeight fontWeight = FontWeight.bold,
    
    EdgeInsets? padding =
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4)]) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Container(
      //  decoration: BoxDecoration(color: appColorGrayDark.withOpacity(0.09),
       
      //  //border: Border.all(color: kBgColorG,width: 0.5)
      //  ),
      alignment: alignment,
      padding: padding,
      child: Text(
        text,
        style: TextStyle(fontWeight: fontWeight, fontFamily: appFontLato, fontSize: fontSize,color: Colors.black),
      ),
    ),
  );
}

Widget CustomTableCellTableBody(String text,
    [double fontSize = 12,
    FontWeight fontWeight = FontWeight.w300,
    AlignmentGeometry? alignment = Alignment.centerLeft,
    EdgeInsets? padding =
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4)]) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: Container(
      // decoration: BoxDecoration(
      //border: Border.all(color:Colors.black, width: 0.5)),
      alignment: alignment,
      padding: padding,
      child: Text(
        text,
        style: TextStyle(fontWeight: fontWeight, fontSize: fontSize),
      ),
    ),
  );
}

String generateUniqueId() {
  var uuid = const Uuid();
  return uuid.v4();
}

// Fetch PDF file from the remote URL
Future<Uint8List> fetchPdfBytes(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Convert response body (PDF content) to a byte array (Uint8List)
    return Uint8List.fromList(response.bodyBytes);
  } else {
    throw Exception('Failed to load PDF: ${response.statusCode}');
  }
}

bool isValidDateRange(String fdate, String tdate) {
  // Define the date format
  DateFormat format = DateFormat('dd/MM/yyyy');

  // Parse the string into a DateTime object
  DateTime fromDate = format.parse(fdate);
  //print(fromDate);

  DateTime toDate = format.parse(tdate);
  // print(toDate);
  if (toDate.isBefore(fromDate)) {
    //print('abcd');
    return false;
  }
  // Duration difference = fromDate.difference(toDate);

  //print(difference);
  return true;
}

bool checkJson(List<dynamic> x) {
  if (x == []) {
    return false;
  }
  var y = x.map((e) => ModelStatus.fromJson(e));
  if (y.isEmpty) {
    return false;
  }
  if (y.first.status == '3') {
    return false;
  }
  return true;
}

bool checkJsonForSaveUpdate(List<dynamic> x) {
  if (x == []) {
    return false;
  }
  var y = x.map((e) => ModelStatus.fromJson(e));
  if (y.isEmpty) {
    return false;
  }
  // if (y.first.status == '3') {
  //   return false;
  // }
  return true;
}

Future<ModelStatus> getStatusWithDialog(
  List<dynamic> jsonData,
  CustomAwesomeDialog dialog,
) async {
  //print(jsonData);
  if (jsonData.isEmpty) {
    dialog
      ..dialogType = DialogType.error
      ..message = "Server error!"
      ..show();
    return ModelStatus(id: "", msg: "Server error", status: "4");
  }
  DialogType dt;
  String msg = '';
  ModelStatus list = jsonData
      .map(
        (e) => ModelStatus.fromJson(e),
      )
      .first;

  dt = DialogType.success;
  if (list.status == "2") {
    dt = DialogType.warning;
  }
  if (list.status == "3") {
    dt = DialogType.error;
  }
  msg = list.msg!;
  if (list.status != "1") {
    dialog
      ..dialogType = dt
      ..message = msg
      ..show();
  }
  return list;
}

List<ModelCommonMaster> getStatusMaster() {
  List<ModelCommonMaster> ml = [];
  ml.add(ModelCommonMaster(id: "1", name: "Active"));
  ml.add(ModelCommonMaster(id: "0", name: "Inactive"));
  return ml;
}

Future<ModelStatus> commonSaveUpdate(data_api2 api, CustomBusyLoader loader,
    CustomAwesomeDialog dialog, List<dynamic> parameter) async {
  loader.show();
  try {
    var x = await api.createLead(parameter);
    //print(x);
    loader.close();
    if (checkJsonForSaveUpdate(x)) {
      return await getStatusWithDialog(x, dialog);
    } else {
      dialog
        ..dialogType = DialogType.error
        ..message = 'Faillure to save/update operation!'
        ..show();
      return ModelStatus(
          id: '',
          status: '3',
          msg: 'Faillure to save/update operation!',
          extra: '');
    }
  } catch (e) {
    loader.close();
    dialog
      ..dialogType = DialogType.error
      ..message = e.toString()
      ..show();
    return ModelStatus(id: '', status: '3', msg: e.toString(), extra: '');
  }
}

bool isCheckCondition(bool b, CustomAwesomeDialog dialog, String msg) {
  if (b) {
    dialog
      ..dialogType = DialogType.warning
      ..message = msg
      ..show();
    return true;
  }
  return false;
}

List<DropdownMenuItem<String>> CustomGenerateDropdownList(List<dynamic> list) =>
    list
        .map((f) => DropdownMenuItem<String>(
            value: f.id,
            child: Text(
              f.name!,
              style: CustomDropdownTextStyle,
            )))
        .toList();

// String encription(String jsonString) {
//   const keyString =
//       '12345678901234567890123456789AAA'; // 32 characters for AES-256
//   const ivString = '1234567890123456'; // 16 characters for AES-128

//   final key = encrypt.Key.fromUtf8(keyString);
//   final iv = encrypt.IV.fromUtf8(ivString);
//   final encrypter = encrypt.Encrypter(encrypt.AES(key));
//   final encrypted = encrypter.encrypt(jsonString, iv: iv);
//   return encrypted.base64;
// }

// String decription(String string) {
//   const keyString =
//       '12345678901234567890123456789AAA'; // 32 characters for AES-256
//   const ivString = '1234567890123456'; // 16 characters for AES-128

//   final key = encrypt.Key.fromUtf8(keyString);
//   final iv = encrypt.IV.fromUtf8(ivString);
//   final encrypter = encrypt.Encrypter(encrypt.AES(key));

//   final decrypted = encrypter.decrypt64(string, iv: iv);
//   return decrypted;
// }

// String encryptText(
//   String plainText,
// ) {
//   final key = encrypt.Key.fromUtf8('12345678901234567890123456789AAA'
//       .padRight(32, ' ')); // Ensure the key is 32 bytes long
//   final iv = encrypt.IV.fromLength(16); // Generate a random 16-byte IV

//   final encrypter = encrypt.Encrypter(encrypt.AES(key));

//   final encrypted = encrypter.encrypt(plainText, iv: iv);

//   return '${encrypted.base64}:${iv.base64}'; // Include IV with encrypted text for decryption
// }

Future<pw.Font> CustomLoadFont(String path) async {
  final data = await rootBundle.load(path);
  return pw.Font.ttf(data);
}

pw.Widget pwTableColumnHeader(String name, pw.Font? font,
        [pw.Alignment aligment = pw.Alignment.centerLeft,
        double fontSize = 12,
        pw.FontWeight fontWeight = pw.FontWeight.bold]) =>
    pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: pw.Align(
            alignment: aligment,
            child: pw.Text(name,
                style: pw.TextStyle(
                    fontSize: fontSize, fontWeight: fontWeight, font: font))));

pw.Widget pwTableCell(String name, pw.Font? font,
        [pw.Alignment aligment = pw.Alignment.centerLeft,
        double fontSize = 9,
        pw.FontWeight fontWeight = pw.FontWeight.bold]) =>
    pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: pw.Align(
            alignment: aligment,
            child: pw.Text(name,
                style: pw.TextStyle(fontSize: fontSize, font: font))));

pw.Widget pwTextCaption(
  String name,
  pw.Font? font, [
  double fontSize = 9,
  pw.FontWeight fontWeight = pw.FontWeight.bold,
  pw.Alignment aligment = pw.Alignment.centerLeft,
  PdfColor color = PdfColors.black,
]) =>
    pw.Align(
        alignment: aligment,
        child: pw.Text(name,
            style: pw.TextStyle(
                fontSize: fontSize,
                font: font,
                color: color,
                fontWeight: fontWeight)));

Map<int, pw.TableColumnWidth> pwTableColumnWidthGenerator(
    List<int> columnWidth) {
  final Map<int, pw.TableColumnWidth> columnWidthMap = {};

  for (int i = 0; i < columnWidth.length; i++) {
    columnWidthMap[i] = pw.FlexColumnWidth(columnWidth[i].toDouble());
  }
  return columnWidthMap;
}

pw.Widget pwGenerateTable(List<int> columnWidth, List<pw.Widget> headerRow,
        List<pw.TableRow> bodyChildren) =>
    pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      columnWidths: pwTableColumnWidthGenerator(columnWidth),
      children: [
        pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColors.grey100),
            children: headerRow),
        ...bodyChildren
      ],
    );

pw.Widget pwText2Col(pw.Font? font, String caption1, String text1,
        String caption2, String text2,
        [double fontSize = 9]) =>
    pw.Table(columnWidths: pwTableColumnWidthGenerator([70, 50]), children: [
      pw.TableRow(children: [
        pw.Row(children: [
          pwTextCaption(caption1, font, fontSize),
          pwTextCaption(text1, font, fontSize, pw.FontWeight.normal),
        ]),
        pw.Row(children: [
          pw.Spacer(),
          pwTextCaption(caption2, font, fontSize),
          pwTextCaption(text2, font, fontSize, pw.FontWeight.normal),
        ]),
      ])
    ]);
pw.Widget pwHeight([double height = 8]) => pw.SizedBox(height: height);
pw.Widget pwTextOne(pw.Font? font, String caption, String text,
        [double fontSize = 9,
        pw.MainAxisAlignment aligment = pw.MainAxisAlignment.center]) =>
    pw.Row(mainAxisAlignment: aligment, children: [
      pw.Text(caption,
          style: pw.TextStyle(
              fontSize: fontSize,
              font: font,
              //color: color,
              fontWeight: pw.FontWeight.bold)),
      pw.Text(text,
          style: pw.TextStyle(
              fontSize: fontSize,
              font: font,
              //color: color,
              fontWeight: pw.FontWeight.bold))
    ]);

// Future<bool> CustomUserCheckNotInLogin(dynamic contrlller) async{
//   if (contrlller.user.value.uid == null) {
//     contrlller.isLoading.value = false;
//     contrlller.isError.value = true;
//     contrlller.errorMessage.value = 'Re-Login Required';
//     return false;
//   }
//   return true;
// }

Future<bool> isValidLoginUser(dynamic contrlller) async{
  if (contrlller.user.value.uid == null) {
    contrlller.isLoading.value = false;
    contrlller.isError.value = true;
    contrlller.errorMessage.value = 'Re-Login Required';
    return false;
  }
  return true;
}
void CustomInitError(dynamic controller,String msg){
  controller.isLoading.value = false;
      controller.isError.value = true;
      controller.errorMessage.value = msg;
}


 

Future<pw.Font> pwFontloader(String path) async {
  final data = await rootBundle.load(path);
  return pw.Font.ttf(data);
}
 

 

pw.SizedBox pwSizedBox([double height = 0, double weight = 0]) => pw.SizedBox(height: height,width: weight);
pw.BoxDecoration pwBoxDecorationFooter=const pw.BoxDecoration(color: PdfColors.grey100);
   

pw.TableRow pwTableRow(List<pw.Widget> children,
        [pw.BoxDecoration decoration =
            const pw.BoxDecoration(color: PdfColors.white)]) =>
    pw.TableRow(children: children,decoration: decoration);
pw.Alignment pwAligmentRight = pw.Alignment.centerRight;
pw.Alignment pwAligmentLeft = pw.Alignment.centerLeft;
pw.Alignment pwAligmentCenter = pw.Alignment.center;
pw.MainAxisAlignment pwMainAxisAlignmentStart = pw.MainAxisAlignment.start;
pw.MainAxisAlignment pwMainAxisAlignmentEnd = pw.MainAxisAlignment.end;
pw.MainAxisAlignment pwMainAxisAlignmentCenter = pw.MainAxisAlignment.center;
 

pw.Widget pwLogo(pw.MemoryImage image) =>
    pw.Image(image, width: 150, height: 80);
 

 