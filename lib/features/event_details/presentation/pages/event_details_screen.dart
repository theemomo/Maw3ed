import 'package:flutter/material.dart';
import 'package:maw3ed/core/entities/event_model.dart';
import 'package:maw3ed/core/route/app_routes.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;
  final Color backgroundColor;
  const EventDetailsScreen({
    super.key,
    required this.event,
    required this.backgroundColor,
  });

  // Color utilities
  Color _lighten(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  Color _darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Widget _buildDetail(
    String label,
    String value,
    BuildContext context,
    Size size,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: const Color(0xFF1E1E1E),
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 30),
          padding: const EdgeInsets.all(20),
          width: size.width,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF1E1E1E), width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Center(
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: const Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Generate lighter and darker tones from the background color
    final Color lighterColor = _lighten(backgroundColor, 0.0);
    final Color darkerColor = _darken(backgroundColor, 0.1);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        margin: const EdgeInsets.only(
          right: 30,
          left: 30,
          top: 100,
          bottom: 100,
        ),
        padding: const EdgeInsets.all(30),
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [lighterColor, darkerColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: darkerColor.withOpacity(0.8),
              blurRadius: 12,
              offset: const Offset(4, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildDetail("Title", event.title, context, size),
            _buildDetail("Description", event.description, context, size),

            Text(
              "Date & Time",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: const Color(0xFF1E1E1E),
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 30),
              padding: const EdgeInsets.all(20),
              width: size.width,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF1E1E1E), width: 1.5),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${event.time.hour.toString().padLeft(2, '0')}:${event.time.minute.toString().padLeft(2, '0')}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  Text(
                    "${event.date.day} / ${event.date.month} / ${event.date.year}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.findLocationRoute,
                  arguments: event.location,
                );
              },
              child: _buildDetail(
                "Go To Your Maw'ed",
                '${event.location.latitude.toStringAsFixed(4)}, ${event.location.longitude.toStringAsFixed(4)}',
                context,
                size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
