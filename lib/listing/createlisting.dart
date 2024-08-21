import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/listing/locationdetails.dart';
import 'package:portugalgo/listing/maplocation.dart';
import 'package:portugalgo/listing/vehicles/vehicles.dart';

import '../constants/image_strings.dart';
import '../helpers/helper_functions.dart';

class ListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 600;
        final dark = THelperFunctions.isDarkMode(context);


        return Scaffold(
          appBar: AppBar(
            leading: Image(
              height: 150,
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
        ),
           
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: true,
          ),
          body: Padding(
            padding: isLargeScreen
                ? EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.2, // 20% padding on each side
                    vertical: 16.0, // Adjust as needed
                  )
                : EdgeInsets.all(16.0), // Default padding for small screens
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "It's easy to get started!What would you like to advertise?",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildOption(
                        "Accomodation",
                        "List your house or apartment.",
                        Iconsax.building_3,
                      ),
                      buildOption(
                        "Activities",
                        "Add tours and things to do.",
                        Iconsax.activity5,
                      ),
                      buildOption(
                        "Vehicles",
                        "Add cars,bikes,boats etc..",
                        Iconsax.car,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
               
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildStep(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
    Widget buildOption(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: Icon(icon, size: 40, color: Colors.blue),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          onTap: () {
            // Select this option
            if (title == "Accomodation") {
            Get.to(() => SpaceTypePage());
          }
          if (title == "Vehicles") {
            Get.to(() => vehicles());
          }
          },
        ),
      ),
    );
  } 
}


class SpaceTypePage extends StatefulWidget {
  @override
  _SpaceTypePageState createState() => _SpaceTypePageState();
}

class _SpaceTypePageState extends State<SpaceTypePage> {
  String? selectedTitle;
  Map<String, String> selectedOptions = {};

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 600;
        final dark = THelperFunctions.isDarkMode(context);

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
            padding: isLargeScreen
                ? EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.2,
                    vertical: 16.0,
                  )
                : EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What kind of space will guests have?",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      buildOption(
                        "An entire space",
                        "Guests have the whole space to themselves.",
                        Iconsax.house,
                      ),
                      buildOption(
                        "One Bedroom",
                        "Guests have their own room in a house, plus access to shared spaces.",
                        Iconsax.house_2,
                      ),
                      buildOption(
                        "A shared room",
                        "Guests sleep in a room or common area that can be shared with you or others.",
                        Iconsax.people,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Previous"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the next page
                          Get.to(() => SpaceDetailsPage());
                        },
                        child: Text("Next"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildOption(String title, String subtitle, IconData icon) {
    bool isSelected = selectedOptions.isNotEmpty && selectedOptions.containsKey(title);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: Icon(icon, size: 40, color: isSelected ? Colors.blue : Colors.grey),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          onTap: () {
            showSpaceTypeDialog(title);
          },
        ),
      ),
    );
  }

  void showSpaceTypeDialog(String title) {
    String? selectedType;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Select Space Type",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjusts the dialog size to fit the content
              children: <String>['private villa', 'Apartment', 'Hotel','Townhouse villa', 'Other', 'Camping','Resort', 'Penthouse', 'Hostel','Houseboat', 'Condo', 'Share house'] // Replace with items from DB later
                  .map((String value) {
                return ListTile(
                  title: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: value == selectedType ? Colors.blue : Colors.black87, // Highlight selected item
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      // Clear any previous selection
                      selectedOptions.clear();
            
                      // Set the new selection
                      selectedType = value;
                      selectedOptions[title] = value;
                    });
                    Navigator.of(context).pop(); // Close the dialog
                    print(selectedOptions);
                  },
                  leading: Icon(
                    value == selectedType ? Icons.check_circle : Icons.circle,
                    color: value == selectedType ? Colors.blue : Colors.grey,
                  ), // Add a check icon to indicate selection
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}

class SpaceDetailsPage extends StatefulWidget {
  @override
  _SpaceDetailsPageState createState() => _SpaceDetailsPageState();
}

class _SpaceDetailsPageState extends State<SpaceDetailsPage> {
  int guests = 4;
  int quarters = 1;
  int beds = 1;
  int bathrooms = 1;

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
                  "Share some more information about your space",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                Text(
                  "You'll add more details later.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildCounterTile("Max Occupancy", guests, (value) {
                        setState(() {
                          guests = value;
                        });
                      }),
                      buildCounterTile("Quarters", quarters, (value) {
                        setState(() {
                          quarters = value;
                        });
                      }),
                      buildCounterTile("Beds", beds, (value) {
                        setState(() {
                          beds = value;
                        });
                      }),
                      buildCounterTile("Bathrooms", bathrooms, (value) {
                        setState(() {
                          bathrooms = value;
                        });
                      }),
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
                        // Navigate to the next page
                        Get.to(()=>AmenitiesSelectionPage());
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

  Widget buildCounterTile(String title, int count, Function(int) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (count > 0) {
                    onChanged(count - 1); // Decrement count
                  }
                },
                icon: Icon(Icons.remove_circle_outline, color: Colors.blue),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  onChanged(count + 1); // Increment count
                },
                icon: Icon(Icons.add_circle_outline, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class Amenity {
  final String name;
  final IconData icon;
  bool isSelected;

  Amenity({required this.name, required this.icon, this.isSelected = false});
}

class AmenitiesSelectionPage extends StatefulWidget {
  @override
  _AmenitiesSelectionPageState createState() => _AmenitiesSelectionPageState();
}

class _AmenitiesSelectionPageState extends State<AmenitiesSelectionPage> {
  List<Amenity> amenities = [
    Amenity(name: 'Wifi', icon: Icons.wifi),
    Amenity(name: 'Television', icon: Icons.tv),
    Amenity(name: 'Kitchen', icon: Icons.kitchen),
    Amenity(name: 'Air Conditioning', icon: Icons.ac_unit),
    Amenity(name: 'Heating', icon: Icons.local_fire_department),
    Amenity(name: 'Parking', icon: Icons.local_parking),
    Amenity(name: 'Washer', icon: Icons.local_laundry_service),
    Amenity(name: 'Dryer', icon: Icons.dry),
    Amenity(name: 'Smoke Detector', icon: Icons.smoke_free),
    Amenity(name: 'First Aid Kit', icon: Icons.medical_services),
    Amenity(name: 'Fire Extinguisher', icon: Icons.fire_extinguisher),
    Amenity(name: 'Hot Tub', icon: Icons.hot_tub),
  ];

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final padding = isLargeScreen
        ? EdgeInsets.symmetric(
            horizontal: screenWidth * 0.2,
            vertical: 20.0,
          )
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
              "Select the amenities available in your space",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Expanded(
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: isLargeScreen ? 160.0 : 150.0,  // Reduce max width for larger screens
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      childAspectRatio: isLargeScreen ? 1.1 : 1.0,  // Slight adjustment for large screens
    ),
    itemCount: amenities.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            amenities[index].isSelected = !amenities[index].isSelected;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: amenities[index].isSelected ? Colors.blue.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: amenities[index].isSelected ? Colors.blue : Colors.grey,
            ),
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                amenities[index].icon,
                size: 28,  // Slightly reduce icon size for large screens
                color: amenities[index].isSelected ? Colors.blue : Colors.grey,
              ),
              SizedBox(height: 8.0),
              Text(
                amenities[index].name,
                style: TextStyle(
                  fontSize: 13,  // Slightly reduce text size for large screens
                  color: amenities[index].isSelected ? Colors.blue : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    },
  ),
),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate to the previous page
                  },
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next page
                    Get.to(()=>LocationDetailsScreen());
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
