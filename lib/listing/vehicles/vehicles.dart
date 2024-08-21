import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../constants/image_strings.dart';
import '../../helpers/helper_functions.dart';
import '../createlisting.dart';

class vehicles extends StatelessWidget {
  const vehicles({super.key});

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
                  "What type of vehicle would you like to advertise?",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildOption(
                        "Cars",
                        "List your car for hire.",
                        Iconsax.car,
                      ),
                      buildOption(
                        "Scooters",
                        "List your scooter for hire.",
                        Iconsax.speedometer, 
                      ),
                      buildOption(
                        "Boats",
                        "List your boat for hire.",
                        Iconsax.ship,
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
          },
        ),
      ),
    );
  }
}