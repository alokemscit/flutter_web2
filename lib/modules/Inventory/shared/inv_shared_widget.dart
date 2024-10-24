import '../../../core/config/const.dart';

Widget InvleftPanelWithTree(  
Widget dropdown1, 
Widget dropdown2,
List<Widget> treeChild,
Widget? table,
[double minWidth=1050]
)=> Column(
      children: [
       // 8.heightBox,
        Row(
          children: [
            Expanded(
              child: CustomGroupBox(
                  padingvertical: 0,
                  groupHeaderText: '',
                  child: Row(
                    children: [
                      Expanded(
                          child: dropdown1
                              ),
                      12.widthBox,
                      dropdown2
                    ],
                  )),
            )
          ],
        ),
        8.heightBox,
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                      color: appColorGrayDark,
                      spreadRadius: 0.1,
                      blurRadius: 0.5)
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child:  Column(
                    children: treeChild,
                  )),
                ),
              ],
            ),
          ),
        ),
        minWidth < 1050
            ? const SizedBox()
            : table==null?const SizedBox(): CustomGroupBox(
                bgColor: Colors.white,
                height: 280,
                child:  table
                     
     )
      ],
    );



InvTree_child(String text, bool isID, Function() fun) => Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 18),
      child: InkWell(
        onTap: () {
          fun();
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_ios,
              color: appColorGrayDark,
              size: isID ? 16 : 14,
            ),
            4.widthBox,
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: isID ? appGray100 : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            color: appColorGray200,
                            blurRadius: .05,
                            spreadRadius: .01)
                      ]),
                  child: Text(
                    text,
                    style: customTextStyle.copyWith(
                        fontSize: 11,
                        color: !isID ? appColorMint : Colors.black,
                        fontFamily: appFontLato),
                  )),
            ),
          ],
        ),
      ),
    );



Widget InvEditText(TextEditingController cnt, FocusNode focusnode,
    [int maxlength = 15,
    Function()? fun,
    Function()? submit,
    bool isReadOnly = false, textAlign=TextAlign.center,  textInputType= TextInputType.number]) {
  focusnode.addListener(() {
    if (focusnode.hasFocus) {
      cnt.selection = TextSelection(
        baseOffset: 0,
        extentOffset: cnt.text.length,
      );
    }
  });
  return TableCell(
      verticalAlignment: TableCellVerticalAlignment.fill,
      child: Row(
        children: [
          Expanded(
            child: CustomTextBox(
                onChange: (v) {
                  if (fun != null) {
                    fun();
                  }
                },
                onSubmitted: (p0) {
                  if (submit != null) {
                    submit();
                  }
                },
               
                isDisable: isReadOnly,
                isReadonly: isReadOnly,
                fontColor: isReadOnly ? Colors.red : appColorMint,
                fontWeight: FontWeight.bold,
                fillColor: Colors.white,
                isFilled: true,
                focusNode: focusnode,
                textAlign: textAlign,
                maxlength: maxlength,
                textInputType: textInputType,
                caption: '',
                controller: cnt),
          ),
        ],
      ));
}



Widget InvFooterCell(String text, [bool isBorder = false]) => TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        decoration: isBorder
            ? const BoxDecoration(
                border: Border(
                    top: BorderSide(color: appColorGrayDark, width: 0.8)))
            : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: Text(
              text,
              style: customTextStyle.copyWith(
                  color: appColorMint,
                  fontFamily: appFontOpenSans,
                  fontSize: 12),
            ))
          ],
        ),
      ),
    );