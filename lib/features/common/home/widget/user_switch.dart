import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Custom pill-shaped switch với ảnh background và khả năng thay đổi màu
class UserRoleSwitch extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final RxBool? rxValue;
  final Color activeBackgroundColor;
  final Color inactiveBackgroundColor;
  final Widget? activeImageWidget;
  final Widget? inactiveImageWidget;
  final double width;
  final double height;

  const UserRoleSwitch({
    super.key,
    this.value,
    this.onChanged,
    this.rxValue,
    this.activeBackgroundColor = const Color(0xFFFFA726),
    this.inactiveBackgroundColor = const Color(0xFF42A5F5),
    this.activeImageWidget,
    this.inactiveImageWidget,
    this.width = 70,
    this.height = 36,
  }) : assert(value != null || rxValue != null, 'Either value or rxValue must be provided');

  @override
  State<UserRoleSwitch> createState() => _UserRoleSwitchState();
}

class _UserRoleSwitchState extends State<UserRoleSwitch> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _toggleAnimation;

  bool get currentValue => widget.rxValue?.value ?? widget.value ?? false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _toggleAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);

    if (currentValue) {
      _animationController.value = 1.0;
    }

    // Listen to RxBool changes
    if (widget.rxValue != null) {
      widget.rxValue!.listen((value) {
        if (mounted) {
          setState(() {
            if (value) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(UserRoleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rxValue == null && oldWidget.value != widget.value) {
      if (currentValue) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.rxValue != null) {
      widget.rxValue!.value = !widget.rxValue!.value;
    } else if (widget.onChanged != null) {
      widget.onChanged!(!currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _toggleAnimation,
        builder: (context, child) {
          final currentColor = Color.lerp(
            widget.inactiveBackgroundColor,
            widget.activeBackgroundColor,
            _toggleAnimation.value,
          )!;

          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: currentColor,
              borderRadius: BorderRadius.circular(widget.height / 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: [
                  // Image Widget ở vị trí đối diện với toggle button
                  if (currentValue && widget.activeImageWidget != null ||
                      !currentValue && widget.inactiveImageWidget != null)
                    Align(
                      alignment: currentValue ? Alignment.centerLeft : Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: currentValue ? 6 : 0,
                          right: currentValue ? 0 : 6,
                        ),
                        child: SizedBox(
                          width: widget.height - 12,
                          height: widget.height - 12,
                          child: currentValue
                              ? widget.activeImageWidget
                              : widget.inactiveImageWidget,
                        ),
                      ),
                    ),

                  // Toggle Button
                  Align(
                    alignment: Alignment(_toggleAnimation.value * 2 - 1, 0),
                    child: Container(
                      width: widget.height - 8,
                      height: widget.height - 8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
