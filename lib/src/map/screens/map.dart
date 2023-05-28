import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/map/controllers/expandable_fab.dart';
import 'package:MyMedice/src/map/models/action_button.dart';
import 'package:MyMedice/src/map/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class TMap extends StatefulWidget {
  const TMap({Key? key}) : super(key: key);

  @override
  State<TMap> createState() => _TMapState();
}

List<Map<String, dynamic>> _data = [];
LocationData? _locationData;
final Location _location = Location();
final MapController _mapController = MapController();
var myLoction = LatLng(
  _locationData!.latitude!,
  _locationData!.longitude!,
);

class _TMapState extends State<TMap> {
  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return;
      }
      final permissionStatus = await _location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        if (await _location.requestPermission() != PermissionStatus.granted) {
          return;
        }
      }
      final currentLocation = await _location.getLocation();
      setState(() {
        _locationData = currentLocation;
        _mapController.move(
          LatLng(currentLocation.latitude!, currentLocation.longitude!),
          15.0,
        );
      });
    } catch (e) {
      debugPrint('Could not get the location: $e');
    }
  }

  Future<void> _loadData() async {
    try {
      final jsonString =
          await rootBundle.loadString('lib/src/Localisation/locations.json');
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      setState(() => _data = jsonData.cast<Map<String, dynamic>>());
    } catch (e) {
      if (kDebugMode) print('Error loading data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const TFloatingActionButton(),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: _locationData != null
              ? LatLng(
                  _locationData!.latitude!,
                  _locationData!.longitude!,
                )
              : LatLng(28.41937647834312, 2.6138395797088356),
          zoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          if (_locationData != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: myLoction,
                  builder: (_) => const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 42.0,
                  ),
                ),
              ],
            ),
          MarkerLayer(
            markers: _data
                .map(
                  (location) => Marker(
                    point: LatLng(
                      (location['lat'] is double) ? location['lat'] : 0.0,
                      (location['lon'] is double) ? location['lon'] : 0.0,
                    ),
                    builder: (context) => IconButton(
                      icon: const Icon(
                        Icons.medication_rounded,
                        color: Color.fromARGB(255, 168, 13, 2),
                        size: 32.0,
                      ),
                      onPressed: () {
                        Get.snackbar(
                            location['name'], 'Address: ${location['address']}',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.blue.withOpacity(0.1),
                            colorText: Colors.black,
                            duration: const Duration(milliseconds: 2200));
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TFloatingActionButton extends StatefulWidget {
  const TFloatingActionButton({
    super.key,
  });

  @override
  State<TFloatingActionButton> createState() => _TFloatingActionButtonState();
}

class _TFloatingActionButtonState extends State<TFloatingActionButton> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return tLoctionController(distance: 120, children: [
      ActionButton(
        icon: const Image(
          image: AssetImage('assets/icons/pharmacy_logo.png'),
          height: 30,
          width: 30,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(tDefaultSize - 15)),
          // Display all the list of pharmacy
          builder: (context) => ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final pharmacy = _data[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 3),
                elevation: 4,
                color: Colors.green.shade300,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset(
                      'assets/icons/pharmacy_logo.png',
                      height: 34,
                    ),
                  ),
                  title: Text(
                    pharmacy['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  subtitle: Text(
                    pharmacy['address'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.blue.shade300),
                  ),
                  onTap: () {
                    Get.back();
                    final pharmacyLocation = LatLng(
                      pharmacy['lat'] is double ? pharmacy['lat'] : 0.0,
                      pharmacy['lon'] is double ? pharmacy['lon'] : 0.0,
                    );
                    _mapController.move(pharmacyLocation, 15.0);
                  },
                ),
              );
            },
          ),
        ),
      ),
      ActionButton(
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          Get.defaultDialog(
            title: "Seach",
            titleStyle: const TextStyle(fontSize: 20),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Column(
                children: [
                  const Text("Serach for pharmacy"),
                  const SizedBox(
                    height: tDefaultSize / 2,
                  ),
                  TypeAheadField(
                    noItemsFoundBuilder: (context) => SizedBox(
                      height: 75,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.search_off,
                              size: 30,
                              color: Colors.blue,
                            ),
                            // ignore: unnecessary_const
                            const Text(tNoResultsFounds,
                                // ignore: unnecessary_const
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        color: Colors.white, // Color ta3 nafida
                        elevation: 4.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    debounceDuration: const Duration(milliseconds: 400),
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //itemsInSearch.clear();
                                  _textEditingController.clear();
                                  setState(() {
                                    _textEditingController.text = '';
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red.withOpacity(0.4),
                                )),
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            hintText: tSearch,
                            prefixIcon: const Icon(Icons.search),
                            prefixIconColor: Colors.grey.shade900,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none))),
                    suggestionsCallback: (value) {
                      return DataService.getSuggestions(value);
                    },
                    itemBuilder: (context, String suggestion) {
                      return Card(
                        color: Colors.blue.withOpacity(0.3),
                        elevation: 4,
                        margin: const EdgeInsets.all(3),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                                minRadius: 20,
                                child: Image.asset(
                                  "assets/logo/medicine.png",
                                  height: 22,
                                  width: 22,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  suggestion,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      setState(() {});
                    },
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            confirm: Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, side: BorderSide.none),
                child: const Text("Ok"),
              ),
            ),
            cancel: ElevatedButton(
                onPressed: () => Get.back(), child: const Text("Cancel")),
          );
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.location_on,
          color: Colors.red,
        ),
        onPressed: () {
          _mapController.move(myLoction, 15.0);
        },
      ),
    ]);
  }
}

Widget _buildIconButton({
  // required parameters
  required VoidCallback onPressed,
  required Icon icon,
  required String tooltip,
}) {
  // return an IconButton widget
  return IconButton(
    // call onPressed() when pressed, catch any errors
    onPressed: () {
      try {
        onPressed();
      } catch (e) {
        debugPrint('Error handling button press: $e');
      }
    },
    // set icon
    icon: icon,
    // set colors
    color: Colors.blue,
    splashColor: Colors.white,
    highlightColor: Colors.white,
    // set tooltip
    tooltip: tooltip,
  );
}