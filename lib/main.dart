import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_app485/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ScanScreen()
    );
  }
}
class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}


List data;

//to uncomment
Future<String> loging() async{
  //print("test1");
  var url = "http://"+ip_add.text+"/qrscanner/getData.php";
  var response = await http.post(url, body: {
  });
  var respBody = json.decode(response.body);
  data = respBody['server_response'];
  //print("data = " + data.toString());
  //print(data[0]['time']);//return data;

}


class _ScanState extends State<ScanScreen> {
  String barcode = "";

//String barcode = barcode;
  insertMethod(String id)async {
    //print(id);
    String theUrl = "http://"+ip_add.text+"/qrscanner/InsertData.php";
    var res = await http.post(theUrl, body: {
      "barcode": id,
    }
    );
    var respBody = json.decode(res.body);
    //print(respBody);

  }
  deleteMethod(String data)async {
    //print(data);
    String theUrl = "http://"+ip_add.text+"/qrscanner/delete.php";
    var res = await http.post(theUrl, body: {
      "id": data,
    }
    );
    var respBody = json.decode(res.body);
    //print(respBody);

  }

  @override
  void initState() {
    super.initState();
  }

  Future scan()async{
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        insertMethod(barcode);

      });
    } on PlatformException catch(e){
      if (e.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          this.barcode = 'Camera permission not granted';
        });
      } else {
        setState(() {
          this.barcode = 'Unknown error: $e';
        });
      }
    } on FormatException{
      setState(() {
        this.barcode = 'null (User returned using the "back"-button before scanning anything, Result)';
      });
    } catch (e) {
      setState(() {
        this.barcode = 'Unknown error:$e';
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    //print(ip_add.text);
    loging();
    //print("test = " + data.toString());
    var contentList =
    Card(
        child :Table(
          //defaultColumnWidth: FixedColumnWidth(120.0),
            columnWidths: {
              0: FlexColumnWidth(4),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(1),
            },
            border: TableBorder.all(
                color: Colors.black12,
                style: BorderStyle.solid,
                width: 1),
            children: [
              TableRow(
                  children: [
                    Container(color:Colors.black38,child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text('Date', style: TextStyle(fontSize: 20.0, color: Colors.white)),])),
                    Container(color:Colors.black38,child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text('Barcode', style: TextStyle(fontSize: 20.0, color: Colors.white))])),
                    Container(color:Colors.black38,child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text('Del', style: TextStyle(fontSize: 20.0, color: Colors.white))])),

                  ]),
              if(data != null)
                for(var i in data)
                  TableRow(
                      children: [
                        Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text(i['time'], style: TextStyle(fontSize: 18.0)),])),
                        Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[Text(i['barcode'], style: TextStyle(fontSize: 18.0))])),
                        Container(child: Column(mainAxisAlignment: MainAxisAlignment.center,children:[IconButton(icon:Icon(Icons.delete,color:Colors.grey),onPressed:(){
                          // print(i['id']);
                          deleteMethod(i['id']);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),);

                        })])),

                      ])
            ]



        )
    );
    var result_scan;
    // print("barcode = " + barcode);
    if(barcode!= "")
      result_scan =  Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text("Your result = "+barcode, textAlign: TextAlign.center,),);
    else
      result_scan =  Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),);

    return MaterialApp(
        home : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black38,
              title: new Text('Code Scanner'),
              actions:<Widget>[
                IconButton(icon: Icon(Icons.refresh), onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),);
                })
              ],
              centerTitle: true,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: new Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    result_scan,
                    contentList,



                  ],
                ),
              ),
            ),

            floatingActionButton : FloatingActionButton(
              onPressed: (scan),
              child:Icon(Icons.scanner),
              backgroundColor: Colors.black38,
            )
        ));
  }
}