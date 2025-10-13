import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayContent extends StatelessWidget {
  const TodayContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: StreamBuilder<DateTime>(
            stream: Stream.periodic(
              const Duration(seconds: 1),
              (_) => DateTime.now(),
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              }
          
              final now = snapshot.data!;
              final formattedTime = DateFormat('hh.mm').format(now);
              final formattedMonth = DateFormat('MMM').format(now);
              final formattedDay = DateFormat('EEEE').format(now);
              // final formattedDate = DateFormat('EEEE, MMMM d, y').format(now);
          
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDay,
                    style:  TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formattedTime,
                    style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formattedMonth.toUpperCase(),
                    style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold, height: 0.8),
                  ),
                  const SizedBox(height: 8),
                  Container()
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Container(
            decoration:  BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
        )
      ],
    );
  }
}
