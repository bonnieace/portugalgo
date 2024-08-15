import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/image_strings.dart';
import '../helpers/helper_functions.dart';
import '../profile/settings/settings.dart';

class PricingPage extends StatefulWidget {
  @override
  _PricingPageState createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage> {
  bool _isEditing = false;
  TextEditingController _priceController = TextEditingController(text: '33');

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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Now, set your price",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "You can change it at any time.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isEditing
                          ? SizedBox(
                              width: 140, // Increase the width of the text field
                              child: TextFormField(
                                controller: _priceController,
                                style: TextStyle(
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none, // Remove the outline
                                  prefixText: '\$',
                                ),
                                textAlign: TextAlign.center,
                                onFieldSubmitted: (value) {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isEditing = true;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    '\$${_priceController.text}',
                                    style: TextStyle(
                                      fontSize: 72,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Icon(Icons.edit, size: 24),
                                ],
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Pre-tax guest price: \$38",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Action when the link is pressed
                    },
                    child: Text(
                      "Learn more about pricing",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back(); // Navigate back
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Colors.grey[200],
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the next page
                    Get.to(() => SettingsScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: const Color.fromARGB(255, 6, 132, 235),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: Text("Finish"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
