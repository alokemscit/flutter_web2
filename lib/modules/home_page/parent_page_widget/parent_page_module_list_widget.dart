// ignore: must_be_immutable

import 'package:web_2/core/config/const.dart';

import 'package:web_2/core/config/responsive.dart';

import '../../admin/module_page/model/model_module.dart';
import '../home_page.dart';

// ignore: must_be_immutable
class ParentMainModuleListWidget extends StatelessWidget {
  List<ModuleMenuList> list;
  ParentMainModuleListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    print(context.width);
    return Responsive(
        mobile: _mobile(list),
        tablet: _desktop(list, context),
        desktop: _desktop(list, context));
  }
}

_desktop(List<ModuleMenuList> list, BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Padding(
    padding: size.width <= 650
        ? const EdgeInsets.only(bottom: 45)
        : const EdgeInsets.only(bottom: 0),
    child: GridView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.width <= 500
            ? 1:(size.width > 500 && size.width < 800)?2
            : (size.width > 800 && size.width < 1000)
            
                ? 3:(size.width > 1000 && size.width < 1400)?4
                : (size.width >= 1400 && size.width < 1730)
                    ? 5
                    : 7,
        childAspectRatio: 2.0,
        mainAxisSpacing: 25.0,
        crossAxisSpacing: 25.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            // print('object');
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomePage(
                    module: list[index],
                  ),
                ));
          },
          child: Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.black87.withOpacity(0.3), width: 0.4),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      spreadRadius: 1,
                      color:appBlueHighDeep
                          .withOpacity(0.0535)),
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 5,
                      color: const Color.fromARGB(255, 41, 241, 1)
                          .withOpacity(0.015)),
                  BoxShadow(
                      blurRadius: 80,
                      spreadRadius: 40,
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.015))
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Spacer(flex: 4,),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.s,
                    children: [
                      Image(
                        image: AssetImage(
                            "assets/images/${list[index].img!}.png"),
                        height: size.width < 650 ? 40 : 30,
                        width: size.width < 650 ? 40 : 30,
                        fit: BoxFit.contain,
                        //color: Colors.amber,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                      8.widthBox,
                      Expanded(
                        child: Text(
                          list[index].name!,
                          style: customTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: appColorMint),
                        ),
                      )
                    ],
                  ),
                  const Spacer(flex: 1,),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          maxLines: 3,
                          list[index].desc!,
                          softWrap: true,
                          // overflow: TextOverflow.ellipsis,
                          style: customTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 4,),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

_mobile(List<ModuleMenuList> list) => ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            decoration: customBoxDecoration.copyWith(
                border: Border.all(color: kHeaderolor.withOpacity(0.25))),
            margin: const EdgeInsets.only(bottom: 12, top: 4),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage(
                        module: list[index],
                      ),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(8),
                              //  color:Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 10.5,
                                  offset: const Offset(0, 0),
                                )
                              ]),
                          child: Center(
                            child: Image(
                              image: AssetImage(
                                  "assets/images/${list[index].img!}.png"),
                              width: 40,
                              height: 32,
                              color: kHeaderolor.withOpacity(0.8),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Text(
                            list[index].name!,
                            style: customTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kHeaderolor,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      list[index].desc!,
                      overflow: TextOverflow.clip,
                      style: customTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
