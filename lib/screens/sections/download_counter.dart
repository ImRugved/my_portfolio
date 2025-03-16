import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';
import 'package:provider/provider.dart';
import 'package:rugved_portfolio_flutter/providers/downloadCount_provider.dart';

class DownloadCounter extends StatelessWidget {
  const DownloadCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadCounterProvider>(
      builder: (context, counterProvider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(
                'Resume Downloads',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              counterProvider.isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  : counterProvider.errorMessage.isNotEmpty
                      ? Text(
                          counterProvider.errorMessage,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedSlideOdometerNumber(
                              odometerNumber:
                                  OdometerNumber(counterProvider.downloadCount),
                              duration: const Duration(milliseconds: 1000),
                              letterWidth: 14,
                              numberTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
              // if (!counterProvider.isLoading &&
              //     counterProvider.errorMessage.isEmpty)
              //   TextButton(
              //     onPressed: () => counterProvider.loadDownloadCount(),
              //     child: Text(
              //       'Refresh',
              //       style: TextStyle(
              //         fontSize: 12,
              //         color: Theme.of(context).colorScheme.primary,
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
      },
    );
  }
}
