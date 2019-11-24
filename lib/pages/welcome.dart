import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/groceries.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Smart Shopping',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'Cumpărături fără bătăi de cap',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                elevation: 8,
                color: Colors.blueAccent,
                colorBrightness: Brightness.dark,
                child: Text('Login'),
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
