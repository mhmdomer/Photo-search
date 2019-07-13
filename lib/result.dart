import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'Image.dart';
import 'single.dart';

class Result extends StatefulWidget {
  final String query;

  Result(this.query);

  @override
  _ResultState createState() => _ResultState(this.query);
}

class _ResultState extends State<Result> {
  static String key = '12664126-ea22023ea9e55e8b3c96993f7';
  final String uri = 'https://pixabay.com/api/?key=$key';
  static List<MyImage> list;
  String query;
  String result = 'connecting...';

  _ResultState(this.query);

  @override
  Widget build(BuildContext context) {
    print('build result');
    return Scaffold(
        body: FutureBuilder(
      future: _makeGetRequest(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        List<MyImage> data = snapshot.data;
        if (data != null && data.length > 0) {
          return ListView.builder(
//                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).orientation == Orientation.portrait) ? 2 : 3),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [InkWell(
                    onTap: () {
                      print('tapping$index');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Single(data[index].big);
                      }));
                    },
                    child: Container(child: Image.network(data[index].light), width: MediaQuery.of(context).size.width),
              )]);
            },
          );
        } else if (data != null && data.length == 0) {
          return Center(
            child: Text('No images found for this search !!'),
          );
        } else if (data == null &&
            snapshot.connectionState == ConnectionState.done) {
          _makeGetRequest();
          return Result(query);
        } else {
//                print(snapshot.connectionState);
//                print(snapshot.data);
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  Future<List<MyImage>> _makeGetRequest() async {
    // make request
    print('making request');
    Response response = await get(uri + '&q=$query');
    print(query);
    Map<dynamic, dynamic> map = jsonDecode(response.body);
//  setState(() {
    list = MyImage.getImages(map['hits']);
//  });
    print(list.length);
    return list;
  }
}
