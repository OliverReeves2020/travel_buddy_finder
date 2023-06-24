import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Rest/LoginClient.dart';
import '../Rest/TripClient.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController UserNameController = TextEditingController();
TextEditingController PassKeyController = TextEditingController();

// Define a custom Form widget.
class CreateAccountForm extends StatelessWidget {
  CreateAccountForm({Key? key})
      : super(key: key);



  //create init state to reset values
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Divider(height: 5),
          TextFormField(
            controller: UserNameController,
            decoration: InputDecoration(labelText: "Enter Username"),
            // The validator receives the text that the user has entered.

          ),

          Divider(height: 5),
          TextFormField(
            controller: PassKeyController,
            decoration: InputDecoration(labelText: "Enter Password"),
            // The validator receives the text that the user has entered.

          ),

          ElevatedButton(
            onPressed: () async {
              // Validate returns true if the form is valid, or false otherwise.

                if (UserNameController.text.isNotEmpty&&PassKeyController.text.isNotEmpty) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')));
                  var res = await new LoginClient().put(
                      UserNameController.text,
                      PassKeyController.text,);


                  if (res == "created") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account created')),
                    );
                    Navigator.of(context).pop();
                  } else if (res == "error") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('username already exists'),
                      ),
                    );

                    //Navigator.of(context).pop();
                  }
                }},

            child: const Text('Create Account'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}

// Define a corresponding State class.
