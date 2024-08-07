import 'package:flutter/material.dart';

import 'curved_edges.dart';

class curved_edges_widget extends StatelessWidget {
  const curved_edges_widget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath (
      clipper: curvedEdges(),
      child: child,
    );
  }
}