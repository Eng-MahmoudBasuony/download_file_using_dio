import 'package:dio/dio.dart';
import 'package:download_file_using_dio/service/api_service.dart';
import 'package:download_file_using_dio/service/service_download.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Files"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              RaisedButton.icon(
                label: Text("Download PDF"),
                icon: Icon(Icons.file_download),
                onPressed: ()
                {
                  getDirectoryDownloads();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void getPermission() async {
    print("===getPermission==");
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  void getDirectoryDownloads() async
  {
    var dio = Dio();
    String path=await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    String fullPath="$path/SampleData.zip";

    ServiceDownload.download2(dio: dio,url: ApiService.zipTest,savePath: fullPath);
  }
}
