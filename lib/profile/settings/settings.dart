import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portugalgo/auth/login.dart';

import '../../appbar/appbar.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import 'circularcontainer.dart';
import 'curved_edges/curved_edges.dart';
import 'profile.dart';
import 'sectionheading.dart';
import 'settingsmenutile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
                          TappBar(title: Text('Owner Portal',style: Theme.of(context).textTheme.headlineMedium!.apply(color:TColors.white),),),
                          const SizedBox(height: TSizes.spaceBtwSections,),
                          //profile  card

                          const userprofiletile(),
                          const SizedBox(height: TSizes.spaceBtwSections,)
                        ],
                      ),
                    ],
                  ),
                
              ),
            ),
            //body
            Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //account settings
                const sectionheading(title: 'Property Management',showActionButton: false,),
                const SizedBox(height: TSizes.spaceBtwItems,),
                TsettingsMenuTile(icon: Iconsax.safe_home, title: 'My Properties', subtitle: 'See your listed properties',onTap: ()=>{},),
                TsettingsMenuTile(icon: Iconsax.home4, title: 'List property', subtitle: 'Add a new property',onTap: () =>{},),
                TsettingsMenuTile(icon: Iconsax.bag_tick, title: 'Reservation Management', subtitle: 'Track availability,prices and discounts',onTap: ()=>{},),
                TsettingsMenuTile(icon: Iconsax.bank, title: 'Billing', subtitle: 'Manage your billing and finances',onTap: () {},),
                TsettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subtitle: 'Manage Notifiications',onTap: () {},),


                //App settings
                const SizedBox(height: TSizes.spaceBtwSections,),

                SizedBox(height:TSizes.spaceBtwInputFields),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    
                    
                    onPressed:   ()=>Get.to(()=>LoginScreen()),
                     child: Text('Log out')),
                )


                

              ],
            ),)
          ],
        ),
      ),
    );
  }
}

class userprofiletile extends StatelessWidget {
  const userprofiletile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  
            
                  
                     circularImage(image:  TImages.user,width: 50,height: 50,padding: 0,),                 
                  
                
              
            
      title: Text('User',style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
      subtitle: Text('user@gmail.com',style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
      trailing: IconButton(onPressed: ()=>Get.to(()=>const ProfileScreen()), icon:const Icon(Iconsax.edit,color: TColors.white,)),
    
    );
  }
}
class primaryheadercontainer extends StatelessWidget {
  const primaryheadercontainer({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return homepagewidget(
      child:child
    );
  }
}
class homepagewidget extends StatelessWidget {
  const homepagewidget({
    super.key, this.child,
  });
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: curvedEdges(),
      child: child
    );
  }
}