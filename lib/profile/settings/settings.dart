import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/auth/login.dart';
import 'package:portugalgo/listing/createlisting.dart';

import '../../appbar/appbar.dart';
import '../../auth/socialsignin/google.dart';
import '../../auth/user.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import 'circularcontainer.dart';
import 'curved_edges/curved_edges.dart';
import 'profile.dart';
import 'sectionheading.dart';
import 'settingsmenutile.dart';

class SettingsScreen extends StatelessWidget {
  final GoogleSignInAccount? user;
  final User? emailUser;

  SettingsScreen({Key? key, this.user,this.emailUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            primaryheadercontainer(
              child: Container(
                color: TColors.primary,
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    Positioned(
                      top: -150,
                      right: -250,
                      child: circularcontainer(
                        backgroundColor: TColors.textWhite.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      right: -300,
                      child: circularcontainer(
                        backgroundColor: TColors.textWhite.withOpacity(0.1),
                      ),
                    ),
                    Column(
                      children: [
                        TappBar(
                          title: Text(
                            'Owner portal',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: TColors.white),
                          ),
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),
                        // Profile card, pass the user or null
                        userprofiletile(googleuser: user,emailUser:emailUser),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  //account settings
                  const sectionheading(
                    title: 'Property Management',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: TSizes.spaceBtwItems,
                            mainAxisSpacing: TSizes.spaceBtwItems,
                            childAspectRatio: 8,
                          ),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return getTile(index);
                          },
                        );
                      } else {
                        return Column(
                          children: List.generate(5, (index) => getTile(index)),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(height: TSizes.spaceBtwInputFields),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async => {
                        //await GoogleSignInApi.logout(),
                        Get.to(() => LoginScreen())
                      },
                      child: const Text('Log out'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTile(int index) {
    List<TsettingsMenuTile> tiles = [
      TsettingsMenuTile(
        icon: Iconsax.building_4,
        title: 'My Advertisements',
        subtitle: 'See your listed property',
        onTap: () {},
      ),
      TsettingsMenuTile(
        icon: Iconsax.folder_add4,
        title: 'Add Advertisement',
        subtitle: 'Add a new property',
        onTap: ()=>Get.to(()=>ListingPage()),
      ),
      TsettingsMenuTile(
        icon: Iconsax.bag_tick,
        title: 'Reservation Management',
        subtitle: 'Track availability, prices, and discounts',
        onTap: () {},
      ),
      TsettingsMenuTile(
        icon: Iconsax.bank,
        title: 'Billing',
        subtitle: 'Manage your billing and finances',
        onTap: () {},
      ),
      TsettingsMenuTile(
        icon: Iconsax.notification,
        title: 'Notifications',
        subtitle: 'Manage Notifications',
        onTap: () {},
      ),
    ];
    return tiles[index];
  }
}

class userprofiletile extends StatelessWidget {
  final GoogleSignInAccount? googleuser;
  final User? emailUser;

  userprofiletile({super.key, this.googleuser,this.emailUser});

  @override
  Widget build(BuildContext context) {
        final displayName = googleuser?.displayName ?? emailUser?.firstName ?? 'Guest user';
    final email = googleuser?.email ?? emailUser?.email ?? 'guest@example.com';

    return ListTile(
      leading: circularImage(
        image: TImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        displayName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        email,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() =>  ProfileScreen(googleuser: googleuser,emailUser: emailUser,)),
        icon: const Icon(Iconsax.edit, color: TColors.white),
      ),
    );
  }
}

class primaryheadercontainer extends StatelessWidget {
  const primaryheadercontainer({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return homepagewidget(child: child);
  }
}

class homepagewidget extends StatelessWidget {
  const homepagewidget({
    super.key,
    this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: curvedEdges(),
      child: child,
    );
  }
}
