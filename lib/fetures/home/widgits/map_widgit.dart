import 'dart:async';

import 'package:among_us2/core/geolocator_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapWidgit extends StatefulWidget {
  const MapWidgit({super.key});

  @override
  State<MapWidgit> createState() => _MapWidgitState();
}

class _MapWidgitState extends State<MapWidgit> {
  String text = "your current location";
  GeolocatorServices geoservices = GeolocatorServices();
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      Position location = await geoservices.determinePosition();

      setState(() {
        text = "${location.latitude} , ${location.longitude} ";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
