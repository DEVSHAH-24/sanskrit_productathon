import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sanskrit_project/models/data.dart';
import 'package:sanskrit_project/models/dataModel.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<DataModel> usersData = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'People Nearby',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer<Data>(
          builder: (context, data, child) {
            usersData = data.items;
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
                              dataModel.email,
                            ),
                            trailing: IconButton(
                              icon: CircleAvatar(
                                child: Icon(
                                  Icons.mail,
                                ),
                              ),
                              onPressed: () {
                                final Uri _emailLaunchUri = Uri(
                                  scheme: 'mailto',
                                  path: dataModel.email,
                                );
                                launch(
                                  _emailLaunchUri.toString(),
                                  forceSafariVC: true,
                                  forceWebView: true,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : SpinKitDoubleBounce(
                    color: Colors.black,
                  );
          },
        )
      ],
    );
  }
}
