// ignore_for_file: use_key_in_widget_constructors, prefer_if_null_operators, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheckemployee/utils/colors.dart';

class AppPrimaryWidget extends StatefulWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final Alignment? alignment;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;

  /// For shape of widget
  final BoxShape? boxShape;

  /// Widget with border
  final BoxBorder? border;
  final double? borderWidth;

  /// For Single color background
  final Color? backgroundColor;

  /// Opacity for gradiant colors
  final double gradiantOpacity;

  /// For perform click events
  final VoidCallback? onTap;
  final bool isOnTapColorShow;
  final Color? splashColor;
  final Color? highlightColor;
  final double? onTapRadius;
  final BoxConstraints? constraints;

  /// For linear gradient direction
  final bool isGradientFromTTB;
  final bool isGradientFromRTL;
  final bool isGradientFromBTT;

  const AppPrimaryWidget({
    Key? key,
    this.width,
    this.height,
    this.child,
    this.borderRadius,
    this.borderWidth,
    this.border,
    this.boxShape,
    this.alignment,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.boxShadow,
    this.onTap,
    this.gradiantOpacity = 1,
    this.isOnTapColorShow = true,
    this.splashColor,
    this.highlightColor,
    this.onTapRadius,
    this.constraints,
    this.isGradientFromTTB = false,
    this.isGradientFromRTL = false,
    this.isGradientFromBTT = false,
  }) : assert(gradiantOpacity >= 0.0 || gradiantOpacity <= 1.0, "Gradiant opacity should be 0.0 or more Or 1.0 or less");

  @override
  State<AppPrimaryWidget> createState() => _AppPrimaryWidgetState();
}

class _AppPrimaryWidgetState extends State<AppPrimaryWidget> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if (widget.onTap != null) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: appButtonScaleAnimationDurationGlobal ?? 50,
        ),
        lowerBound: 0.0,
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap != null && _controller != null) {
      _scale = 1 - _controller!.value;
    }
    final _widget = AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment ?? Alignment.center,
      padding: widget.padding ?? EdgeInsets.all(16),
      margin: widget.margin,
      constraints: widget.constraints,
      decoration: widget.border != null
          ? BoxDecoration(
              borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : null,
              border: widget.border,
              shape: widget.boxShape ?? BoxShape.rectangle,
              color: widget.backgroundColor,
              boxShadow: widget.boxShadow,
            )
          : BoxDecoration(
              borderRadius: widget.borderRadius != null ? BorderRadius.circular(widget.borderRadius!) : null,
              shape: widget.boxShape ?? BoxShape.rectangle,
              boxShadow: widget.boxShadow,
              color: widget.backgroundColor != null ? widget.backgroundColor : null,
              gradient: widget.backgroundColor == null
                  ? LinearGradient(
                      colors: [
                        primaryColor.withOpacity(widget.gradiantOpacity),
                        secondaryColor.withOpacity(widget.gradiantOpacity),
                      ],
                      begin: widget.isGradientFromTTB
                          ? widget.isGradientFromBTT
                              ? Alignment.bottomCenter
                              : Alignment.topCenter
                          : widget.isGradientFromRTL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                      end: widget.isGradientFromTTB
                          ? widget.isGradientFromBTT
                              ? Alignment.topCenter
                              : Alignment.bottomCenter
                          : widget.isGradientFromRTL
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.mirror,
                    )
                  : null,
            ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: InkWell(
            onTap: () => widget.onTap?.call(),
            splashColor: widget.isOnTapColorShow ? widget.splashColor : Colors.transparent,
            highlightColor: widget.isOnTapColorShow ? widget.highlightColor : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.onTapRadius ?? 0),
            child: _widget,
          ),
        ),
      );
    } else {
      return _widget;
    }
  }
}
