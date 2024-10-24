  
 
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

 
import '../../core/config/const.dart';
 

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor:kBgLightColor,
      appBar: AppBar(
        backgroundColor:kBgLightColor,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
                onTap: () async{
                 await savePdf(context,url);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.share,color:Colors.blueAccent,))),
          )
        ],
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
