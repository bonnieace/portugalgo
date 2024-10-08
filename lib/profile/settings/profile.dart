import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/profile/settings/sectionheading.dart';
import 'package:http/http.dart' as http;

import '../../appbar/appbar.dart';
import '../../auth/user.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../helpers/helper_functions.dart';
import '../../auth/login.dart';

class ProfileScreen extends StatelessWidget {
  final GoogleSignInAccount? googleuser;
  final User? emailUser;

  const ProfileScreen({super.key, this.googleuser, this.emailUser});

  @override
  Widget build(BuildContext context) {
    // Use values from either googleuser or emailUser
    final fullname = googleuser?.displayName ?? emailUser?.firstName ?? 'Guest User';

    // Split the display name into first and last names
    final nameParts = fullname.split(' ');
    final displayName = nameParts.isNotEmpty ? nameParts.first : 'Guest User';
    final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : (emailUser?.lastName ?? '');

    final email = googleuser?.email ?? emailUser?.email ?? 'guest@example.com';
    final userId = emailUser?.id ?? 'N/A'; // No userId in GoogleSignInAccount

    return Scaffold(
      appBar: const TappBar(
        title: Text('Profile'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    circularImage(image: TImages.user, width: 80, height: 80),
                    TextButton(
                      onPressed: () => {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const sectionheading(title: 'User Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Display each editable field as a tile
              profilemenu(
                onPressed: () {
                  _editValue(context, displayName, lastName, email, userId);
                },
                title: 'First Name',
                value: displayName,
              ),
              profilemenu(
                onPressed: () {
                  _editValue(context, displayName, lastName, email, userId);
                },
                title: 'Last Name',
                value: lastName,
              ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                const sectionheading(title: 'Profile Information', showActionButton: false),
                              const SizedBox(height: TSizes.spaceBtwSections),


              profilemenu(
                onPressed: () {
                  _editValue(context, displayName, lastName, email, userId);
                },
                title: 'Email',
                value: email,
              ),
              profilemenu(
                onPressed: () {
                  _editValue(context, displayName, lastName, email, userId);
                },
                title: 'User ID',
                value: userId,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwSections),


              Center(
                child: TextButton(
                  onPressed: () => {
                    deleteUserAndNavigate(userId,context)

                  },
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editValue(BuildContext context, String firstName, String lastName, String email, String userId) {
    // Create controllers for each field
    final TextEditingController firstNameController = TextEditingController(text: firstName);
    final TextEditingController lastNameController = TextEditingController(text: lastName);
    final TextEditingController emailController = TextEditingController(text: email);
    final TextEditingController userIdController = TextEditingController(text: userId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields,),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields,),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                SizedBox(height: TSizes.spaceBtwInputFields,),
                TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(labelText: 'User ID'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Collect all field values and send the update request
                updateUser(
                  userIdController.text,
                  firstNameController.text,
                  lastNameController.text,
                  emailController.text,
                );
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUser(String anaId, String firstName, String lastName, String email) async {
    // Define the API URL with the ana_id parameter
    final String url = "https://api.global-software.org/management/user/update?ana_id=$anaId";

    // Define the API key and headers
    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "X-Api-Key": "6b21ac76-6753-4fc7-b5f8-2e93881b577c",
    };

    // Define the JSON body with all fields
    final Map<String, dynamic> body = {
      "ana_id": anaId,
      "ana_nome": firstName,
      "ana_cognome": lastName,
      "ana_email": email,
      "ana_password": "sonia" // Assuming the password is static for now
    };

    // Perform the PUT request
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      print('User updated successfully');
    } else {
      print('Failed to update user: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> deleteUserAndNavigate(String anaId, BuildContext context) async {
    final String apiUrl = 'https://api.global-software.org/management/user/delete';
    
    final Uri uri = Uri.parse('$apiUrl?anaid=$anaId');

    try {
      final response = await http.delete(
        uri,
        headers: {
          'X-Api-Key': '6b21ac76-6753-4fc7-b5f8-2e93881b577c', // Replace with your API key
        },
      );

      if (response.statusCode == 200) {
        // Successfully deleted
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Handle server errors or invalid responses
        print('Failed to delete user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('An error occurred: $e');
    }
  }
}

class profilemenu extends StatelessWidget {
  const profilemenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.onPressed,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(
                icon,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class circularImage extends StatelessWidget {
  const circularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = TSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          fit: StackFit.expand,
          children: [
            isNetworkImage
                ? Image.network(image, fit: fit)
                : Image.asset(image, fit: fit),
            if (overlayColor != null)
              Container(
                width: width,
                height: height,
                color: overlayColor!.withOpacity(0.5),
              ),
          ],
        ),
      ),
    );
  }
}
Future<void> deleteUserAndNavigate(String anaId, BuildContext context) async {
  final String apiUrl = 'https://api.global-software.org/management/user/delete';
  
  final Uri uri = Uri.parse('$apiUrl?anaid=$anaId');

  try {
    final response = await http.delete(
      uri,
      headers: {
        'X-Api-Key': '6b21ac76-6753-4fc7-b5f8-2e93881b577c', // Replace with your API key
      },
    );

    if (response.statusCode == 200) {
      // Successfully deleted
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      // Handle server errors or invalid responses
      print('Failed to delete user. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle network or other errors
    print('An error occurred: $e');
  }
}
