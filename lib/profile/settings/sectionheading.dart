

import 'package:flutter/material.dart';

class sectionheading extends StatelessWidget {
  const sectionheading({
    super.key, this.textcolor,  this.showActionButton=true, required this.title,  this.buttonTitle="View all", this.onPressed,
  });
  final Color? textcolor;
  final bool showActionButton;
  final String title,buttonTitle;
  final void Function ()?onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: Theme.of(context).textTheme.headlineSmall!.apply(color: textcolor),maxLines: 1,overflow: TextOverflow.ellipsis,),
       if (showActionButton) TextButton(onPressed: onPressed, child: Text(buttonTitle))
      ],
    );
  }
}