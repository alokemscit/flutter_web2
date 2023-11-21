

// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/main_app_menu.dart';
import '../home_page.dart';

// ignore: must_be_immutable
class ParentMainModuleListWidget extends StatelessWidget {
  List<main_app_menu> list;
  ParentMainModuleListWidget({
    Key? key,
    required this.list,
    
  }) : super(key: key);

   

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: size.width <= 650? const EdgeInsets.only(bottom: 45):const EdgeInsets.only(bottom: 0),
      child: GridView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: size.width <= 650
              ? 1
              : (size.width > 650 && size.width < 1200)
                  ? 2
                  : (size.width >= 1200 && size.width < 1600)
                      ? 3
                      : 4,
          childAspectRatio: 2.0,
          mainAxisSpacing: 25.0,
          crossAxisSpacing: 25.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
               // print('object');
                Navigator.push(
                  context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomePage(module: list[index],),
                ));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  alignment: Alignment.topLeft,
      
                 
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                          color: Colors.black87.withOpacity(0.3), width: 0.38),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1,
                            color: const Color.fromARGB(255, 11, 0, 36)
                                .withOpacity(0.135)),
                        BoxShadow(
                            blurRadius: 50,
                            spreadRadius: 15,
                            color: const Color.fromARGB(255, 41, 241, 1)
                                .withOpacity(0.015)),
                        BoxShadow(
                            blurRadius: 80,
                            spreadRadius: 40,
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.015))
                      ]
      
                    
                      ),
      
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              // border: Border.all(color: Colors.black)
                            ),
                            child: Image(
                              image: AssetImage(
                                  "assets/images/${list[index].icon!}"),
                              height: size.width < 650?40:(size.width >= 1200 && size.width < 1600)
                                  ? 60
                                  : (size.width > 650 && size.width < 805)
                                      ? 50
                                      : 70,
                              width:size.width < 650?30: (size.width >= 1200 && size.width < 1600)
                                  ? 50
                                  : (size.width > 650 && size.width < 805)
                                      ? 40
                                      : 60,
                              fit: BoxFit.fill,
                              //color: Colors.amber,
                              colorBlendMode: BlendMode.srcIn,
                            )),
                        Text(
                          list[index].name!,
                          style: GoogleFonts.roboto(
                              fontSize: size.width < 650?15:(size.width > 650 && size.width < 805)
                                  ? 16
                                  : 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.indigo),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              maxHeight:  (size.width > 650 && size.width <= 705)
                                  ? 30
                                  : (size.width > 705 && size.width < 805)
                                      ? 45
                                      : (size.width >= 1200 && size.width < 1600)
                                          ? 50
                                          : 100),
                          child: Text(
                            list[index].description!,
                            style: GoogleFonts.roboto(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
