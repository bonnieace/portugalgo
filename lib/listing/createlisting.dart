import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';

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
            automaticallyImplyLeading: false,
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
                  "It's easy to get started on Portugalgo",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildStep(
                        "Tell us about your space",
                        "Share some basic information, like the location and how many guests can stay.",
                        Iconsax.house,
                      ),
                      SizedBox(height: 16),
                      buildStep(
                        "Make it stand out",
                        "Add some photos, a title, and a description.",
                        Iconsax.image,
                      ),
                      SizedBox(height: 16),
                      buildStep(
                        "Complete your listing and publish it",
                        "Choose an introductory price, check a few details, and publish your ad.",
                        Iconsax.check,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SpaceTypePage());
                    },
                    child: Text("Begin"),
                  ),
                ),
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
}


class SpaceTypePage extends StatelessWidget {
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
                    horizontal: constraints.maxWidth * 0.2, // 20% padding on each side
                    vertical: 16.0, // Adjust as needed
                  )
                : EdgeInsets.all(16.0), // Default padding for small screens
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What kind of space will guests have?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
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
                          Get.to(() => ListingPage());
                        },
                        child: Text("Previous"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the next page
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
          },
        ),
      ),
    );
  }
}
