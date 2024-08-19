import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/appbar/appbar.dart';
import 'package:portugalgo/listing/maplocation.dart';

import '../constants/image_strings.dart';
import '../constants/sizes.dart';
import '../helpers/helper_functions.dart';
import '../validators/validation.dart';

class LocationDetailsScreen extends StatelessWidget {
  const LocationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLargeScreen = constraints.maxWidth > 600;
          var padding = isLargeScreen
              ? EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.2, // 20% padding on each side
                  vertical: 20.0,
                )
              : const EdgeInsets.all(16.0);

          return Padding(
            padding: padding,
            child: SingleChildScrollView(
              
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
                SizedBox(height: 20,),
                LocationForm(),
                
              ],
            )),
          );
        },
      ),
    );
  }
}

class LocationForm extends StatelessWidget {
  const LocationForm({super.key});

  void _submitLocation(
    BuildContext context,
    String street,
    String area,
    String postalCode,
    String city,
    String country,
  ) {
    // Handle the submission of the location data
    print('Street: $street');
    print('Area: $area');
    print('Postal Code: $postalCode');
    print('City: $city');
    print('Country: $country');

    // Display a success message, navigate to another screen, etc.
   /* ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location submitted successfully!')),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController streetController = TextEditingController();
    final TextEditingController areaController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController countryController = TextEditingController();

    return Form(
      child: Column(
        children: [
          // Street
          TextFormField(
            controller: streetController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.home),
              labelText: "Street",
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Area
          TextFormField(
            controller: areaController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.map_1),
              labelText: "Area",
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Postal Code
          TextFormField(
            controller: postalCodeController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.location),
              labelText: "Postal Code",
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // City
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.building_4),
              labelText: "City",
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          // Country
          TextFormField(
            controller: countryController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.flag),
              labelText: "Country",
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwSections),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => {_submitLocation(
                context,
                streetController.text,
                areaController.text,
                postalCodeController.text,
                cityController.text,
                countryController.text,
              ),
              Get.to(()=>LocationSelectionPage())
              },
              
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
