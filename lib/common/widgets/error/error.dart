import 'package:flutter/material.dart';

import '../../../core/error/app_error.dart';
import '../../bloc/button_bloc/button_cubit.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key, 
    required this.errorType, 
    required this.buttonCubit
  });

  final AppErrorType errorType;
  final ButtonCubit buttonCubit;

  @override
  Widget build(BuildContext context) {
    // Provide a meaningful error display
    return AlertDialog(
      title: Text('Error Occurred'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display error-specific information
          Text(_getErrorMessage()),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Optionally retry or dismiss
              Navigator.of(context).pop();
              //buttonCubit.reset(); // Assuming you have a reset method
            },
            child: Text('Dismiss'),
          )
        ],
      ),
    );
  }

  String _getErrorMessage() {
    switch (errorType) {
      case AppErrorType.network:
        return 'Network error. Please check your connection.';
      case AppErrorType.api:
        return 'Server error. Please try again later.';
      // Add more specific error messages
      default:
        return 'An unexpected error occurred.';
    }
  }
}