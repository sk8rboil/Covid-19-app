// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_function_literals_in_foreach_calls, avoid_print, camel_case_types
// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:convert';

import 'package:covid_19_app/models/todaycase.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  Summarys? dataSummary;

  Future todaycase() async {
    try {
      var response =
          await http.get(Uri.parse('https://covid19.mathdro.id/api'));
      /*  print(response.body); */
      var data = json.decode(response.body);
      print(data);
      dataSummary = Summarys.fromJson(data);
      print(dataSummary?.confirmed.value);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-19'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: todaycase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              caseCard('CONFIRM', '${dataSummary?.confirmed.value}',
                  Colors.redAccent.shade100),
              caseCard('RECOVER:', '${dataSummary?.recovered.value}',
                  Colors.amberAccent),
              caseCard(
                  'DEATH CASE:', '${dataSummary?.deaths.value}', Colors.black),
            ],
          );
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class caseCard extends StatelessWidget {
  caseCard(this.title, this.value, this.cardcolor, {Key? key})
      : super(key: key);

  String title;
  String value;
  Color cardcolor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: cardcolor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
