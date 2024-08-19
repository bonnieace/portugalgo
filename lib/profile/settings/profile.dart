import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/profile/settings/sectionheading.dart';

import '../../appbar/appbar.dart';
import '../../auth/login.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../helpers/helper_functions.dart';

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
              const sectionheading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Display first name, last name, email, and user ID
              profilemenu(onPressed: () {}, title: 'First Name', value: displayName),
              profilemenu(onPressed: () {}, title: 'Last Name', value: lastName),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Personal info
              const sectionheading(title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              profilemenu(onPressed: () {}, title: "User ID", value: userId),
              profilemenu(onPressed: () {}, title: "E-mail", value: email),
              profilemenu(onPressed: () {}, title: "Phone Number", value: ''),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () => {},
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        child: Center(
          child: Image(
            fit: fit,
            image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}
