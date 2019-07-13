import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'Image.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class Single extends StatefulWidget {
  final String url;
  Single(this.url);
  @override
  _SingleState createState() => _SingleState(url);
}

class _SingleState extends State<Single> {

  final String url;
  _SingleState(this.url);
  @override
  Widget build(BuildContext context) {
    print('build single');
    return Scaffold(
      body: Material(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(child: Container(), flex: 1,),
                Expanded(child: Image.network(url), flex: 9,),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: RaisedButton(
                          onPressed: () {
                            _downloadImage(url);
                          },
                          child: Text('download'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _downloadImage(String url, {AndroidDestinationType destination, bool whenError = false}) async {
    try {
      String imageId;

      if (whenError) {
        imageId = await ImageDownloader.downloadImage(url).catchError((error) {
          if (error is PlatformException) {
            var path = "";
            if (error.code == "404") {
              print("Not Found Error.");
            } else if (error.code == "unsupported_file") {
              print("UnSupported FIle Error.");
              path = error.details["unsupported_file_path"];
            }
          }

          print(error);
        }).timeout(Duration(seconds: 10), onTimeout: () {
          print("timeout");
        });
      } else {
        print('downloading...');
        if (destination == null) {
          imageId = await ImageDownloader.downloadImage(url);
        } else {
          imageId = await ImageDownloader.downloadImage(
            url,
            destination: destination,
          );
        }
      }

      if (imageId == null) {
        return;
      }
      
    } on PlatformException catch (error) {
      return;
    }

    if (!mounted) return;

  }
}
