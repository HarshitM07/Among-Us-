import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final markersProvider = StateProvider<List<Marker>>((ref) => []);
