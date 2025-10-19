import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:maw3ed/generated/l10n.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderContent extends StatefulWidget {
  const CalenderContent({super.key});

  @override
  State<CalenderContent> createState() => _CalenderContentState();
}

class _CalenderContentState extends State<CalenderContent> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit()..getEventsForSpecificDay(DateTime.now()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2010, 1, 1),
                    lastDay: DateTime(
                      _focusedDay.year + 10,
                      _focusedDay.month,
                      _focusedDay.day,
                    ),

                    // Calendar behavior
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.saturday,
                    availableGestures: AvailableGestures.all,
                    weekendDays: const [DateTime.friday],

                    // Selected day logic
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                      BlocProvider.of<HomeCubit>(
                        context,
                      ).getEventsForSpecificDay(selectedDay);
                      // print(selectedDay);
                    },

                    // Styling
                    headerStyle: HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle:  TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontWeight: FontWeight.bold,
                      ),
                      weekendTextStyle: const TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (previous, current) =>
                            current is FetchingEventsLoading ||
                            current is FetchingEventsLoaded,
                        builder: (context, state) {
                          if (state is FetchingEventsLoading) {
                            return const SizedBox();
                          } else if (state is FetchingEventsLoaded) {
                            if (state.events.isEmpty) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: size.height * 0.05),
                                  Opacity(
                                    opacity: 0.7,
                                    child: CachedNetworkImage(
                                      width: size.width * 0.3,
                                      imageUrl:
                                          'https://cdn-icons-png.flaticon.com/512/969/969563.png',
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Text(
                                    S.of(context).noEventsForThisDay,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              );
                            } else {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.events.length,
                                itemBuilder: (context, index) {
                                  final List<Color> eventColors = [
                                    const Color(0xFFC9C3E5),
                                    const Color(0xFFE4B7B5),
                                    const Color(0xFFA9D0C3),
                                    const Color(0xFFD8DFAD),
                                    const Color(0xFFFFD6A5),
                                    const Color(0xFFB5EAD7),
                                    const Color(0xFFFFB7B2),
                                    const Color(0xFFA7C7E7),
                                  ];
                                  final List<Color> eventButtonColors = [
                                    const Color(0xFF4B3D91), // Dark Violet
                                    const Color(0xFF7B2F2D), // Deep Rosewood
                                    const Color(0xFF2E6E5C), // Dark Emerald
                                    const Color(0xFF63692C), // Army Olive
                                    const Color(
                                      0xFF8A4A00,
                                    ), // Deep Burnt Orange
                                    const Color(0xFF1E7B62), // Deep Teal
                                    const Color(0xFF8B1F19), // Crimson Coral
                                    const Color(0xFF174E89), // Midnight Blue
                                  ];
                                  return LayoutBuilder(
                                    builder: (context, constraints) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                            AppRoutes.eventDetailsRoute,
                                            arguments: {
                                              'backgroundColor':
                                                  eventColors[index %
                                                      eventColors.length],
                                              'event': state.events[index],
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                eventColors[index %
                                                    eventColors.length],
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(30),
                                                  bottomLeft: Radius.circular(
                                                    30,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    30,
                                                  ),
                                                ),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color:
                                            //         eventColors[index %
                                            //                 eventColors.length]
                                            //             .withOpacity(0.4),
                                            //     blurRadius: 12,
                                            //     offset: const Offset(4, 6),
                                            //   ),
                                            // ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.events[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: const Color(
                                                        0xFF1E1E1E,
                                                      ),
                                                    ),
                                              ),
                                              Text(
                                                state.events[index].description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: const Color(
                                                        0xFF1E1E1E,
                                                      ),
                                                    ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${state.events[index].date.day} / ${state.events[index].date.month} / ${state.events[index].date.year}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: const Color(
                                                            0xFF1E1E1E,
                                                          ),
                                                        ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 13,
                                                          vertical: 5,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          eventButtonColors[index %
                                                              eventColors
                                                                  .length],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            30,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      '${state.events[index].time.hour.toString().padLeft(2, '0')}:${state.events[index].time.minute.toString().padLeft(2, '0')}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                eventColors[index %
                                                                    eventColors
                                                                        .length],
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          }
                          return const Center(
                            child: Text("Something went wrong!"),
                          );
                        },
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
