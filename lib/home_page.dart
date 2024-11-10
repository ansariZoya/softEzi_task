import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  String data = " ";
  bool showdata = false;

  Future<void> fetchData() async {
    final input = _inputController.text;
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$input'));
    try {
      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body).toString();
          showdata = true;
          log(response.body);
        });
      } else {
        setState(() {
          data = 'Error: ${response.statusCode}';
          showdata = true;
        });
      }
    } catch (e) {
      setState(() {
        data = 'Error:$e';
        showdata = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
        child: Center(
            child: Column(
          children: [
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "SoftEzi Soultions LLP",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 15,),
                RichText(text: const TextSpan(
                  children: [
                    TextSpan(
                      text:"Welcome to the SoftEzi!.... ",
                      style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: "We believe that ",
                      style: TextStyle(color: Colors.black,fontSize: 15),
                    ),
                    TextSpan(
                      text: "Great things in business are never done by one person; they’re done by a team of people.",
                      style: TextStyle(color: Color.fromARGB(255, 150, 19, 106),fontSize: 15,fontWeight: FontWeight.w500)
                    )
                  ]
                )
                ),const SizedBox(height: 15,),
                  
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'select id number',
                ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                onPressed: () {
                  setState(() {
                    fetchData();
                  });
                },
                child: const Text('Press this button ')),
            const SizedBox(
              height: 15,
            ),
            AnimatedOpacity(
              opacity: showdata ? 1.0 : 0.00,
              duration: const Duration(seconds: 1),
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                width: showdata ? 300 : 0,
                height: showdata ? 150 : 0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 211, 211, 65),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  data,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
