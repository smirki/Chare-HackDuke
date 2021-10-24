import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:autodonate/state_management.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final stateManager = HomePageManager();

  final donationController = TextEditingController();
  final capController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    donationController.dispose();
    capController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          Center(
            child: Wrap(
              spacing: 10,
              alignment: WrapAlignment.center,
              children: [
                TextField(controller: donationController),
                ElevatedButton(
                  onPressed: () =>
                      stateManager.setDonation(donationController.text),
                  child: Text('Set your donation amount'),
                ),
                TextField(controller: capController),
                ElevatedButton(
                  onPressed: () => stateManager.setCap(capController.text),
                  child: Text('Set your donation limit'),
                ),
              ],
            ),
          ),
          SizedBox(height: 0),
          ValueListenableBuilder<RequestState>(
            valueListenable: stateManager.resultNotifier,
            builder: (context, requestState, child) {
              if (requestState is RequestLoadInProgress) {
                return CircularProgressIndicator();
              } else if (requestState is RequestLoadSuccess) {
                return Expanded(
                    child:
                        SingleChildScrollView(child: Text(requestState.body)));
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
