import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_progress_indicator/smart_progress_indicator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Progress Plugin Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProgressDemoScreen(),
    );
  }
}

class ProgressDemoScreen extends StatefulWidget {
  const ProgressDemoScreen({super.key});

  @override
  State<ProgressDemoScreen> createState() => _ProgressDemoScreenState();
}

class _ProgressDemoScreenState extends State<ProgressDemoScreen> {
  double _progress = 0.0;
  bool _isUploading = false;
  StreamSubscription<double>? _uploadSubscription;

  void _startFakeUpload() {
    _isUploading = true;
    _uploadSubscription = Stream<double>.periodic(
          const Duration(milliseconds: 100),
          (tick) => (tick + 1) * 0.02,
        )
        .takeWhile((value) => value <= 1.0)
        .listen(
          (value) {
            setState(() => _progress = value);
          },
          onDone: () {
            setState(() => _isUploading = false);
          },
        );
  }

  void _cancelUpload() {
    _uploadSubscription?.cancel();
    setState(() {
      _isUploading = false;
      _progress = 0.0;
    });
  }

  @override
  void dispose() {
    _uploadSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Progress Indicator")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmartProgressIndicator(
            progress: _progress,
            shape: ProgressIndicatorShape.circular,
            showProgressText: true,
            size: 50,
            color: Colors.teal,
            message: _isUploading ? "Uploading file..." : "Not uploading",
            showCancelButton: _isUploading,
            onCancelPressed: _cancelUpload,
          ),
          const SizedBox(height: 40),
          SmartProgressIndicator(
            progress: _progress,
            shape: ProgressIndicatorShape.linear,
            color: Colors.green,
            strokeWidth: 12,
            showProgressText: true,
            message: "Linear Style",
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _isUploading ? null : _startFakeUpload,
            child: const Text("Start Upload"),
          ),
        ],
      ),
    );
  }
}
