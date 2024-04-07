import 'dart:async';

import 'package:among_us2/fetures/home/distance_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearbyPlayersListWidget extends StatefulWidget {
  const NearbyPlayersListWidget({Key? key}) : super(key: key);

  @override
  _NearbyPlayersListWidgetState createState() =>
      _NearbyPlayersListWidgetState();
}

class _NearbyPlayersListWidgetState extends State<NearbyPlayersListWidget> {
  Position? userLocation;
  late bool isCooldownActive;
  late DateTime cooldownEndTime;

  @override
  void initState() {
    super.initState();
    initializeCooldownState();
    getUserLocation();
  }

  Future<void> initializeCooldownState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCooldownActive = prefs.getBool('isCooldownActive') ?? false;
      int? endTimeMillis = prefs.getInt('cooldownEndTimeMillis');
      cooldownEndTime = endTimeMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(endTimeMillis)
          : DateTime.now();
    });
  }

  Future<void> saveCooldownState(bool active, DateTime endTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCooldownActive', active);
    await prefs.setInt('cooldownEndTimeMillis', endTime.millisecondsSinceEpoch);
  }

  void getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isCooldownActive)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CountdownTimer(
                endTime: cooldownEndTime.millisecondsSinceEpoch,
                textStyle: const TextStyle(fontSize: 18),
                onEnd: () {
                  setState(() {
                    isCooldownActive = false;
                    saveCooldownState(false, DateTime.now());
                  });
                },
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Locations")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No players nearby."),
                    );
                  }

                  List<String> nearbyTeams = [];

                  for (var loc in snapshot.data!.docs) {
                    if (userLocation != null) {
                      double destinationLat = loc["Lat"];
                      double destinationLong = loc["Long"];

                      if (isWithinRadius(
                          destinationLat,
                          destinationLong,
                          userLocation!.latitude,
                          userLocation!.longitude,
                          20.00)) {
                        nearbyTeams.add(loc["Team"]);
                      }
                    }
                  }

                  if (nearbyTeams.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (var team in nearbyTeams)
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Teams")
                                .doc(team)
                                .collection("players")
                                .snapshots(),
                            builder: (context, teamSnapshot) {
                              if (teamSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              if (teamSnapshot.hasError) {
                                return Text(
                                    "Error fetching team data: ${teamSnapshot.error}");
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Team: $team',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    children: [
                                      for (var playerDoc
                                          in teamSnapshot.data!.docs)
                                        ListTile(
                                          title: Text(playerDoc["name"]),
                                          subtitle: Text(playerDoc["email"]),
                                          trailing: ElevatedButton(
                                            onPressed: () {
                                              handleKillPlayer(
                                                  team, playerDoc.id);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: isCooldownActive
                                                  ? MaterialStateProperty.all(
                                                      Colors.grey)
                                                  : null,
                                            ),
                                            child: const Text("Kill"),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          ),
                      ],
                    );
                  }

                  return const Center(
                    child: Text("Please wait for a bit..."),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void handleKillPlayer(String team, String playerId) async {
    if (!isCooldownActive) {
      try {
        await FirebaseFirestore.instance
            .collection("Teams")
            .doc(team)
            .collection("players")
            .doc(playerId)
            .delete();

        setState(() {
          isCooldownActive = true;
          cooldownEndTime = DateTime.now().add(const Duration(minutes: 5));
          saveCooldownState(true, cooldownEndTime);
        });
      } catch (e) {
        print("Error removing player: $e");
      }
    }
  }
}

class CountdownTimer extends StatefulWidget {
  final int endTime;
  final TextStyle textStyle;
  final Function()? onEnd;

  const CountdownTimer({
    required this.endTime,
    required this.textStyle,
    this.onEnd,
    Key? key,
  }) : super(key: key);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds =
        ((widget.endTime - DateTime.now().millisecondsSinceEpoch) / 1000)
            .floor();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds -= 1;
        if (_remainingSeconds <= 0) {
          _timer.cancel();
          widget.onEnd?.call();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (_remainingSeconds / 60).floor();
    int seconds = _remainingSeconds % 60;
    return Text(
      'Cooldown: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
      style: widget.textStyle,
    );
  }
}
