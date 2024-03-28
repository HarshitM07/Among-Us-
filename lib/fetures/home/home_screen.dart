import 'package:among_us2/fetures/home/widgits/map_widgit.dart';
import 'package:among_us2/fetures/home/widgits/nearby_player_widgit.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';

void main(List<String> args) {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: const [
          Text(
            "you are a",
            style: TextStyle(fontSize: 10),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Imposter",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
        title: const Text('Home'),
      ),
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          // Enable snapping. This is true by default.
          snap: true,
          // Set custom snapping points.
          snappings: [0.1, 0.7, 1.0],
          // Define to what the snappings relate to. In this case,
          // the total available space that the sheet can expand to.
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        // The body widget will be displayed under the SlidingSheet
        // and a parallax effect can be applied to it.
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: MapWidgit(),
        ),
        builder: (context, state) {
          // This is the content of the sheet that will get
          // scrolled, if the content is bigger than the available
          // height of the sheet.
          return const SizedBox(
            height: 500,
            child: Center(
              // content on the sheet
              child: NearbyPlayersListWidgit(),
            ),
          );
        },
      ),
    );
  }
}
