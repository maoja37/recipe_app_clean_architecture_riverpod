
import 'package:flutter/material.dart';
import 'package:recipe_huto_test/core/constants/size.dart';
import 'package:recipe_huto_test/core/errors/failures.dart';


class CustomErrorWidget extends StatelessWidget {
  final Failure failure;
    // Optional callback for retry functionality
    // its also worth noting that VoidCallback is just a typedef for void Function()
  final VoidCallback? onRetry;

  const CustomErrorWidget({
    super.key,
    required this.failure,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    String message;
    
    //conditional statements to detemine the rror message to show to the user
    if (failure is ServerFailure) {
      message = (failure as ServerFailure).message;
    } else if (failure is NetworkFailure) {
      message = 'No internet connection';
    } else {
      message = 'Something went wrong';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const VerticalSpacing(16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            //conditional retry button
            if (onRetry != null) ...[
              const VerticalSpacing(16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}