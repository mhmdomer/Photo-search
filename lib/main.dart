import 'package:flutter/material.dart';
import 'result.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: _MyApp(),
  )
  );

class _MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<_MyApp> {


  @override
  Widget build(BuildContext context) {
    
    TextEditingController searchController = TextEditingController();
    print('build main');

    return Scaffold(
      appBar: AppBar(title: Text('Photo Search'), centerTitle: true,),
      body: Material(
        color: Colors.white,
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(40),
                child: Image(image: AssetImage('assets/images/photobay.png'), height: 200, width: 200,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  autofocus: true,
                  style: TextStyle(
                    height: 0.7
                  ),
                  controller: searchController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    )
                  ),
                  onSubmitted: (String value) {
                    goToResult(searchController.text);
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: RaisedButton(
                        elevation: 4,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        child: Text('Search images'),
                        onPressed: () {
                          goToResult(searchController.text);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void goToResult(String value) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Result(value);
    }));
  }
}