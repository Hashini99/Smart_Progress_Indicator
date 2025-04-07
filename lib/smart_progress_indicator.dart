import 'package:flutter/material.dart';

enum ProgressIndicatorShape { circular, linear }

class SmartProgressIndicator extends StatelessWidget {
  final double progress; // From 0.0 to 1.0
  final double size; // Size of circular indicator
  final Color color; // Main progress color
  final Color backgroundColor; // Background color of progress bar
  final bool showProgressText; // Show percentage text
  final String? message; // Optional message below indicator
  final ProgressIndicatorShape shape; // Shape type
  final double strokeWidth; // Thickness of progress line
  final bool showCancelButton; // Show cancel button
  final VoidCallback? onCancelPressed; // Callback for cancel button

  const SmartProgressIndicator({
    super.key,
    required this.progress,
    this.size = 100.0,
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.showProgressText = false,
    this.message,
    this.shape = ProgressIndicatorShape.circular,
    this.strokeWidth = 8.0,
    this.showCancelButton = false,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          shape == ProgressIndicatorShape.circular
              ? SizedBox(
                width: size,
                height: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: strokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      backgroundColor: backgroundColor,
                    ),
                    if (showProgressText)
                      Text(
                        "${(progress * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: size * 0.2,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: strokeWidth,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      backgroundColor: backgroundColor,
                    ),
                    if (showProgressText)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${(progress * 100).toStringAsFixed(0)}%",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                message!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
          if (showCancelButton && onCancelPressed != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextButton.icon(
                onPressed: onCancelPressed,
                icon: const Icon(Icons.cancel, color: Colors.red),
                label: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
