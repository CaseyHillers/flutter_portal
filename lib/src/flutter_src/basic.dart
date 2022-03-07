// ignore_for_file: unnecessary_null_comparison, diagnostic_describe_all_properties

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'layer.dart';
import 'proxy_box.dart';

/// A widget that can be targeted by a [CompositedTransformFollower].
///
/// When this widget is composited during the compositing phase (which comes
/// after the paint phase, as described in [WidgetsBinding.drawFrame]), it
/// updates the [link] object so that any [CompositedTransformFollower] widgets
/// that are subsequently composited in the same frame and were given the same
/// [MyLayerLink] can position themselves at the same screen location.
///
/// A single [MyCompositedTransformTarget] can be followed by multiple
/// [CompositedTransformFollower] widgets.
///
/// The [MyCompositedTransformTarget] must come earlier in the paint order than
/// any linked [CompositedTransformFollower]s.
///
/// See also:
///
///  * [CompositedTransformFollower], the widget that can target this one.
///  * [LeaderLayer], the layer that implements this widget's logic.
class MyCompositedTransformTarget extends SingleChildRenderObjectWidget {
  /// Creates a composited transform target widget.
  ///
  /// The [link] property must not be null, and must not be currently being used
  /// by any other [MyCompositedTransformTarget] object that is in the tree.
  const MyCompositedTransformTarget({
    Key? key,
    required this.link,
    Widget? child,
  })  : assert(link != null),
        super(key: key, child: child);

  /// The link object that connects this [MyCompositedTransformTarget] with one or
  /// more [CompositedTransformFollower]s.
  ///
  /// This property must not be null. The object must not be associated with
  /// another [MyCompositedTransformTarget] that is also being painted.
  final MyLayerLink link;

  @override
  MyRenderLeaderLayer createRenderObject(BuildContext context) {
    return MyRenderLeaderLayer(
      link: link,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, MyRenderLeaderLayer renderObject) {
    renderObject.link = link;
  }
}