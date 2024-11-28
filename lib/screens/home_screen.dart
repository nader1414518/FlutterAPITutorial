import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "API Playground",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton(
              onPressed: () async {
                var res = await http.post(
                  Uri.parse(
                      "https://fake-nodejs-k7gt58qaw-coders-projects-4ae845be.vercel.app/register"),
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: jsonEncode(
                    {
                      "username": "test2@gmail.com",
                      "password": "12345678",
                    },
                  ),
                );

                print(res.body);
              },
              child: const Text(
                "Register",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
              onPressed: () async {
                var res = await http.post(
                  Uri.parse(
                      "https://fake-nodejs-k7gt58qaw-coders-projects-4ae845be.vercel.app/login"),
                  headers: {
                    "Content-Type": "application/json",
                  },
                  body: jsonEncode(
                    {
                      "username": "test2@gmail.com",
                      "password": "12345678",
                    },
                  ),
                );

                // print(res.body);
                Map<String, dynamic> parsedRes = Map<String, dynamic>.from(
                  jsonDecode(res.body) as Map,
                );

                print(parsedRes["token"]);

                if (parsedRes["result"] == true) {
                  setState(() {
                    token = parsedRes["token"];
                  });
                }
              },
              child: const Text(
                "Login",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FilledButton(
              onPressed: () async {
                var res = await http.get(
                  Uri.parse(
                      "https://fake-nodejs-k7gt58qaw-coders-projects-4ae845be.vercel.app/user"),
                  headers: {
                    // "Content-Type": "application/json",
                    "Authorization": "Bearer $token",
                  },
                );

                // print(res.body);

                Map<String, dynamic> parsedRes = Map<String, dynamic>.from(
                  jsonDecode(res.body) as Map,
                );

                if (parsedRes["result"] == true) {
                  print("My email is " + parsedRes["username"]);
                }
              },
              child: const Text(
                "Get User Data",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
