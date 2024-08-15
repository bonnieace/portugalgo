import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:portugalgo/listing/setprice.dart';

import '../constants/image_strings.dart';
import '../helpers/helper_functions.dart';


class LocationSelectionPage extends StatefulWidget {
  @override
  _LocationSelectionPageState createState() => _LocationSelectionPageState();
}

class _LocationSelectionPageState extends State<LocationSelectionPage> {
  LatLng _pickedLocation = LatLng (38.7223, -9.1393); // Default location: Portugal

  void _onLocationPicked(LatLng location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 600;
        var padding = isLargeScreen
            ? EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.2, // 20% padding on each side
                vertical: 20.0)
            : EdgeInsets.all(16.0);

        return Scaffold(
          appBar: AppBar(
            leading: Image(
              height: 150,
              image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Where is your space?",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Text(
                  "Your address isn't shared with guests until they've booked.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: _pickedLocation,
                      initialZoom: 14.0,
                      onTap: (tapPosition, LatLng location) => _onLocationPicked(location),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _pickedLocation, child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                             
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.back(); // Navigate to the previous page
                      },
                      child: Text("Previous"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to the next page with the selected location
                         Get.to(() => PricingPage());
                      },
                      child: Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
