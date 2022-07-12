import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form/HomePage.dart';
import 'package:form/helpers/DatabaseHelper.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _designation = TextEditingController();
  TextEditingController _qualification = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  var select = "S1";
  var operation = "F";
  var ch1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginForm"),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name : "),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'enyter a name'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("DOB : "),
                  SizedBox(
                    height: 10,
                  ),
                  DateTimePicker(
                    initialValue: '',
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Designation : "),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _designation,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'enyter a name'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Qualification : "),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _qualification,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'enyter a name'),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Radio(
                          value: "F",
                          groupValue: operation,
                          onChanged: (val) {
                            setState(() {
                              operation = val;
                            });
                          }),
                      Text("Female"),
                      Radio(
                          value: "M",
                          groupValue: operation,
                          onChanged: (val) {
                            setState(() {
                              operation = val;
                            });
                          }),
                      Text("Male"),
                    ],
                  ),
                  Row(
                    children: [
                      DropdownButton(
                          value: select,
                          items: [
                            DropdownMenuItem(
                              child: Text("Surat"),
                              value: "S1",
                            ),
                            DropdownMenuItem(
                              child: Text("Valsad"),
                              value: "v1",
                            ),
                            DropdownMenuItem(
                              child: Text("Surat"),
                              value: "m1",
                            ),
                          ],
                          onChanged: (val) {
                            select = val;
                          })
                    ],
                  ),
                  Text("Email : "),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'enyter a name'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'enter email';
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(val)) {
                        return 'enter valid email';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("IsRelocate"),
                      Checkbox(
                          value: ch1,
                          onChanged: (val) {
                            ch1 = val;
                          })
                    ],
                  ),
                  Text("MobileNo : "),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _mobile,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintText: 'enyter a name'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'plaese enter mobile no';
                      }
                      if (val.length != 10) {
                        return 'number must be 10 digit';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_form.currentState.validate()) {


                                var name = _name.text.toString();
                                var designation = _designation.text.toString();
                                var qualification =
                                    _qualification.text.toString();
                                var email = _email.text.toString();
                                var mobile = _mobile.text.toString();

                                DatabaseHelper obj = new DatabaseHelper();
                                var id = await obj.addEmployee(
                                    name,
                                    designation,
                                    qualification,
                                    email,
                                    mobile,
                                    operation,
                                    select);

                                print("" + id.toString());
                                Fluttertoast.showToast(
                                    msg: "Employee insert ",
                                    timeInSecForIosWeb: 1,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 20,
                                    textColor: Colors.red);

                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HomePage()));
                              }
                            },
                            child: Text("Save")),
                      ),
                      Container(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Save")),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
