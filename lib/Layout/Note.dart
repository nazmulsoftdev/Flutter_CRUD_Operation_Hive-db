import 'package:app1/Layout/Edit/edit.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            elevation: 5,
            backgroundColor: Color(0xfff5f6fa),
            title: Text(
              'Are you sure?',
              style: TextStyle(color: Color(0xffF79F1F)),
            ),
            content: Text('Do you want to exit the App',
                style: TextStyle(color: Color(0xffF79F1F))),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No', style: TextStyle(color: Color(0xff009432))),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes', style: TextStyle(color: Color(0xffEA2027))),
              ),
            ],
          ),
        )) ??
        false;
  }

  Box? UserContact;

  @override
  void initState() {
    UserContact = Hive.box("Contact-Note");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.pushNamed(context, "/Add-Page");
            },
            child: Icon(Icons.add),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ValueListenableBuilder(
                      valueListenable: Hive.box("Contact-Note").listenable(),
                      builder: (content, box, widget) {
                        return ListView.builder(
                          itemBuilder: (_, index) {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title:
                                    Text(UserContact!.getAt(index).toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blueGrey),),
                                trailing: Container(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Edit(
                                                      userIndex:index,
                                                      updateNum: UserContact!
                                                          .getAt(index))));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                  elevation: 5,
                                                  backgroundColor:
                                                      Color(0xfff5f6fa),
                                                  title: Text(
                                                    'Are you sure?',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffF79F1F)),
                                                  ),
                                                  content: Text(
                                                      'Do you want to delete ',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xffF79F1F))),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      child: Text('No',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff009432))),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        await UserContact!
                                                            .deleteAt(index);
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: Text('Yes',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffEA2027))),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: UserContact!.keys.toList().length,
                        );
                      }),
                )
              ],
            ),
          )),
        ),
        onWillPop: _onWillPop);
  }
}
