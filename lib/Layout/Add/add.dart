import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  Box? UserContact;

  @override
  void initState() {
    UserContact = Hive.box("Contact-Note");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "Favorite Number",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          maxLength: 11,
                          decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.teal)),
                              hintText: 'Store a valid Number',
                              helperText: 'Add Phone Number.',
                              labelText: 'Number',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                              prefixText: ' ',
                              suffixText: 'BD',
                              suffixStyle:
                                  const TextStyle(color: Colors.green)),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Number is Empty";
                            }
                            if (val.length < 11) {
                              return "Number must be atleast 11 characters long";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var TextData = _controller.text;
                              await UserContact?.add(TextData);
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Add"),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
