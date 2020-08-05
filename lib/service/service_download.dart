

import 'dart:io';

import 'package:dio/dio.dart';

class ServiceDownload {

 static Future download2({Dio dio, String url, String savePath}) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) { return status < 500; }
        ),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  static void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
//  static void download2({String url,String savePath}) async
//  {
//    Dio dio = Dio();
//
//
//    try {
//      Response response = await dio.get(
//          url.toString(),
//          onReceiveProgress:showDownloadProgress,
//           //recive data
//          options: Options(
//              responseType: ResponseType.bytes,
//               followRedirects: false
//              ,validateStatus: (status)
//          {
//             return status<500;
//          }));
//
//      File file =File(savePath);
//
//      var raf=file.openSync(mode: FileMode.write);
//     raf.writeStringSync(response.data);
//     await raf.close();
//
//    } catch (e) {
//     print("error is :");
//     print(e.toString());
//    }
//  }
//
//
//  static void showDownloadProgress(received,total)
//  {
//    if(total!=-1)
//    {
//      print("${(received/total * 100).toStringAsFixed(0) + "%"}");
//    }
//  }

}