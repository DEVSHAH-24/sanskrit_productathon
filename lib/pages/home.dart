import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/data.dart';
import '../models/dataModel.dart';
import '../models/firebaseModel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool completed = false;
  List<DataModel> usersData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'People nearby',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<Data>(
          builder: (context, data, child) {
            usersData = data.usersData;
            return usersData.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: usersData.length,
                      itemBuilder: (context, index) {
                        DataModel dataModel = usersData[index];
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: Image.network(
                              dataModel.photoUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                            onTap: () {},
                            title: Text(
                              dataModel.name,
                            ),
                            subtitle: Text(
                              dataModel.label,
                            ),
                            trailing: Provider.of<Data>(context)
                                    .sentByMeRequest(dataModel.userId)
                                ? FlatButton(
                                    child: Text(
                                      'Request Sent',
                                    ),
                                    onPressed: () {},
                                  )
                                : Provider.of<Data>(context)
                                        .receivedForMeRequest(dataModel.userId)
                                    ? FlatButton(
                                        child: Text(
                                          'Accept',
                                        ),
                                        onPressed: () {
                                          Provider.of<Data>(context,
                                                  listen: false)
                                              .accept(dataModel.userId);
                                        },
                                      )
                                    : Provider.of<Data>(context)
                                            .isConnected(dataModel.userId)
                                        ? FlatButton(
                                            child: Text(
                                              'Connected',
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      title: Text('ERROR'),
                                                      content: Text(
                                                        'Are You Sure?',
                                                      ),
                                                      elevation: 40,
                                                      actions: <Widget>[
                                                        FlatButton(
                                                          onPressed: () async {
                                                            await Navigator
                                                                    .maybePop(
                                                                        context)
                                                                .then((value) => Provider.of<
                                                                            Data>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .removeConnect(
                                                                        dataModel
                                                                            .userId));
                                                          },
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Text(
                                                            'Yes',
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () async {
                                                            await Navigator
                                                                .maybePop(
                                                                    context);
                                                          },
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          child: Text(
                                                            'No',
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            },
                                          )
                                        : FlatButton(
                                            textColor: Colors.black,
                                            child: Text(
                                              'Connect',
                                            ),
                                            onPressed: () {
                                              Provider.of<Data>(context,
                                                      listen: false)
                                                  .connect(dataModel.userId);
                                            },
                                          ),
                          ),
                        );
                      },
                    ),
                  )
                : (!completed
                    ? SpinKitDoubleBounce(
                        color: Colors.black,
                      )
                    : Center(
                        child: Text(
                          'No Users Nearby',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ));
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchUsers() async {
    FirebaseModel firebaseModel = FirebaseModel();
    completed = await firebaseModel.fetchUsers(context);
    setState(() {
      completed = completed;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }
}
