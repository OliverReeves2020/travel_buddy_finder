import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Rest/TripClient.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController TripnameController = TextEditingController();
TextEditingController LocationController = TextEditingController();
TextEditingController DateController = TextEditingController();

// Define a custom Form widget.
class UpdateTripForm extends StatelessWidget {

   UpdateTripForm({Key? key, required this.user, required this.password,required this.tripId})
      : super(key: key);
  final String user;
  final String password;
  String tripId;


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
            controller: TripnameController,
            decoration: InputDecoration(labelText: "Enter TripName"),
            // The validator receives the text that the user has entered.

          ),
          Divider(height: 5),
          TextFormField(
            controller: LocationController,
            decoration: InputDecoration(labelText: "Enter Location"),
            // The validator receives the text that the user has entered.

          ),
          Divider(height: 5),
          TextField(
              controller: DateController, //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Choose Date"
                //label text of field
              ),
              readOnly: true, // when true user cannot edit text
              onTap: () async {
                //when click we have to show the datepicker

                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate: DateTime(
                        2023), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2050));
                if (pickedDate != null) {
                  print(
                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

                  String formattedDate = DateFormat('dd/MM/yyyy').format(
                      pickedDate); // format date
                  print(
                      formattedDate); //formatted date output

                  DateController.text = formattedDate;
                } else {
                  print("Date is not selected");
                }
              }),
          ElevatedButton(
            onPressed: () async {
              // Validate returns true if the form is valid, or false otherwise.
              if(tripId.isNotEmpty){
              if (DateController.text.isNotEmpty||TripnameController.text.isNotEmpty||LocationController.text.isNotEmpty) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                String date=DateController.text;
                date=date.replaceAll("/", "");
                print("here");
                var res = await new TripClient().put(
                  tripId,
                    user,
                    password,
                    TripnameController.text,
                    LocationController.text,
                    date);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
                if (res == "created") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Trip Successfully created')),
                  );
                  Navigator.of(context).pop();
                } else if (res == "error") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('error occured'),
                    ),
                  );

                  //Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('error')),
                  );
                  //Navigator.of(context).pop();
                }
              }}
            },
            child: const Text('Submit'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}

// Define a corresponding State class.
