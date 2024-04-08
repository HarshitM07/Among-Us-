import 'dart:async';

import 'package:among_us2/core/geolocator_services.dart';
import 'package:among_us2/provider/location_marker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final mapControllerProvider = Provider<MapController>((ref) => MapController());

class MapWidget extends ConsumerStatefulWidget {
  const MapWidget({super.key});

  @override
  ConsumerState<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends ConsumerState<MapWidget> {
  late final MapController _mapController;
  GeolocatorServices geoservices = GeolocatorServices();

  @override
  void initState() {
    super.initState();
    _updateLocation();
  }

  Future<void> _updateLocation() async {
    try {
      _mapController.move(
        LatLng(31.7070, 76.5263),
        17,
      );
    } catch (e) {
      print('Error updating location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    _mapController = ref.watch(mapControllerProvider);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            bounds: LatLngBounds(
              LatLng(31.7071, 76.5262),
              LatLng(31.7073, 76.5264),
            ),
            interactiveFlags: InteractiveFlag.all &
                ~InteractiveFlag.pinchZoom &
                ~InteractiveFlag.doubleTapZoom,
            center: LatLng(31.7070, 76.5263),
            zoom: 17,
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/harshvss/clur4jhs701dg01pihy490el6/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGFyc2h2c3MiLCJhIjoiY2x1cjQ5eTdxMDNxYjJpbjBoM2JwN2llYSJ9.bXR-Xw8Cn0suHXrgG_Sgnw',
              userAgentPackageName: 'com.example.app',
              additionalOptions: const {
                'accessToken':
                    'pk.eyJ1IjoiaGFyc2h2c3MiLCJhIjoiY2x1cjQ5eTdxMDNxYjJpbjBoM2JwN2llYSJ9.bXR-Xw8Cn0suHXrgG_Sgnw',
              },
            ),
            MarkerLayer(
              markers: ref.watch(markersProvider),
            ),
          ],
        ),
        Positioned(
          child: IconButton(
            onPressed: () async {
              await _updateLocation();
            },
            icon: const Icon(Icons.location_searching_rounded),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
