import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:autodonate/state_management.dart';

class Map extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Center(
          child: Wrap(
            spacing: 50,
            alignment: WrapAlignment.center,
            children: [
              Image.asset("assets/images/Maps.jpg"),
              ElevatedButton(
                onPressed: stateManager.makeDonation,
                child: Text('Make a Donation'),
              ),
              ElevatedButton(
                onPressed: stateManager.setStore,
                child: Text('Choose a store'),
              ),
              ElevatedButton(
                onPressed: stateManager.setCharity,
                child: Text('Choose a Charity'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ValueListenableBuilder<RequestState>(
          valueListenable: stateManager.resultNotifier,
          builder: (context, requestState, child) {
            if (requestState is RequestLoadInProgress) {
              return CircularProgressIndicator();
            } else if (requestState is RequestLoadSuccess) {
              return Expanded(
                  child: SingleChildScrollView(
                      child: Text(
                requestState.body,
                style: TextStyle(fontSize: 20),
              )));
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
