import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form/helpers/DatabaseHelper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> alldata;

  getdata() async {
    DatabaseHelper obj = new DatabaseHelper();
    setState(() {
      alldata = obj.getAllEmployee();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  _createDialog(id) {
    AlertDialog alert = AlertDialog(
      title: Text(
        "Are you sure ?",
        textAlign: TextAlign.center,
      ),
      content: Text("do you really want to delete permantely"),
      contentPadding: EdgeInsets.all(10),
      actions: [
        Row(
          children: [
            Container(
              child: ElevatedButton(
                onPressed: () async {
                  DatabaseHelper obj = new DatabaseHelper();
                  int status = await obj.deleteEmployee(id);
                  print("" + status.toString());

                  Navigator.of(context).pop();
                  if (status == 1) {
                    Fluttertoast.showToast(
                        msg: "delete success",
                        gravity: ToastGravity.BOTTOM,
                        toastLength: Toast.LENGTH_SHORT,
                        textColor: Colors.white,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red);
                    getdata();
                  } else {
                    print("error");
                  }
                },
                child: Text("Yes"),
              ),
            ),
            Container(
                child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("no"),
            ))
          ],
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: alldata,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            if(snapshots.data.length<=0)
            {
              return Center(child: Text("No Data!"));
            }else
            {
              return ListView.builder(
                  itemCount: snapshots.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Text(snapshots.data[index]["name"].toString()),
                          Row(
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    var id =
                                        snapshots.data[index]["eid"].toString();
                                    _createDialog(id);
                                  },
                                  child: Text("Delete"),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
          }
          else
            {
              return Center(child: CircularProgressIndicator());
            }
        });
  }
}
