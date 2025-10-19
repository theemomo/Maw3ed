import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MapScreenShimmer extends StatelessWidget {
  const MapScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      direction: ShimmerDirection.ltr,
      child: Column(
        children: [
          // Map placeholder
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: size.width,
            height: size.height * 0.4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 30),

          // List of shimmer event cards
          Expanded(
            child: ListView.builder(
              itemCount: 3, // number of fake event cards to show
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title line
                      Container(
                        width: size.width * 0.5,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),

                      // Description lines
                      Container(
                        width: size.width * 0.8,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: size.width * 0.6,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 15),

                      // Date + time row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width * 0.25,
                            height: 16,
                            color: Colors.white,
                          ),
                          Container(
                            width: size.width * 0.2,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
