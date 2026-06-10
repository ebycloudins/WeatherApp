import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherShimmer extends StatelessWidget {
  const WeatherShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(height: 30, width: 150, color: Colors.white),

            const SizedBox(height: 20),

            Container(height: 20, width: double.infinity, color: Colors.white),

            const SizedBox(height: 12),

            Container(height: 20, width: double.infinity, color: Colors.white),

            const SizedBox(height: 12),

            Container(height: 20, width: double.infinity, color: Colors.white),

            const SizedBox(height: 12),

            Container(height: 20, width: double.infinity, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
