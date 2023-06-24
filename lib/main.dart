import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel_buddy_finder/Objects/Login.dart';
import 'package:travel_buddy_finder/pagecontroller.dart';
import 'FeedPage.dart';
import 'Forms/Account.dart';
import 'Rest/LoginClient.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = "travel buddy finder";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      color: Colors.deepPurpleAccent,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.grey,
        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const LoginWidget(),
      ),
    );

    return const Placeholder();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Travel Buddy Finder',
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign in',
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'UserID',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  //take controller text check if empty

                  print(nameController.text);
                  print(passwordController.text);
                  if (nameController.text == "" ||
                      passwordController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("invalid username or password"),

                    ));
                  } else {

                    // call http function
                    // if valid continue and set user and password for the current session
                    //push Navigation page to top view
                    var res=await LoginClient().get(nameController.text,passwordController.text);

                    if(res=="error"){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("invalid username or password"),
                      ));
                    }
                    else{
                    var r=LoginValidator.fromJson(json.decode(res));
                    if(r.match=="valid"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BasicBottomNavigation(
                                  user: nameController.text,
                                  password: passwordController.text,
                                )));}
                    else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("invalid username or password"),
                    ));}}
                  }
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('no account:'),
              TextButton(
                child: const Text(
                  'Create Account',
                ),
                onPressed: () {
                  //show account creation screen
                  showDataAlert();
                  //signup screen
                },
              )
            ],
          ),
        ],
      ),
    );

  }
  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: EdgeInsets.only(
              top: 10,
            ),
            title: Text("Create Account"),
            content: CreateAccountForm(),
          );
        });
  }
}
