import 'package:flutter/material.dart';
import 'package:flutter_app485/main.dart';

void main() => runApp(new Myhome_page());

class Myhome_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: home_screen()
    );
  }
}
class home_screen extends StatefulWidget {
  @override
  _home_screenState createState() => _home_screenState();
}
TextEditingController ip_add = TextEditingController();
class _home_screenState extends State<home_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],

        body: Padding(
            padding: EdgeInsets.fromLTRB(00.0, 0.0, 0.0, 0.0),
            child: SafeArea(

                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          SizedBox(height: 20.0),
                          Text(
                              "WELCOME",
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 28.0,
                                //fontWeight: FontWeight.bold
                              )
                          ),
                          SizedBox(height: 10.0),
                          Card(
                              child: Column(
                                  children: <Widget>[

                                    Padding(

                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(

                                        decoration: InputDecoration(
                                          labelText: 'IP Address & Port Number',
                                          prefixIcon: Icon(Icons.person),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(8)),
                                        ),
                                        controller: ip_add,
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[

                                        MaterialButton(
                                          color: Colors.blueGrey,
                                          child: Text('submit',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          onPressed: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ScanScreen()),)
                                          },
                                        ),

                                      ],
                                    )
                                  ])
                          ),
                        ])

                )
            )
        )

    );
  }
}
