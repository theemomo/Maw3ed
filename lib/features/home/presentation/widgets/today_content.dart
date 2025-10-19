import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:maw3ed/core/route/app_routes.dart';
import 'package:maw3ed/features/home/presentation/cubits/home_cubit/home_cubit.dart';
import 'package:maw3ed/features/home/presentation/widgets/date_time_shimmer.dart';
import 'package:maw3ed/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class TodayContent extends StatelessWidget {
  const TodayContent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit()..getTodayEvents(),
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            onRefresh: () {
              return BlocProvider.of<HomeCubit>(context).getTodayEvents();
            },
            child: Column(
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
                        // While waiting, show a small fade-in shimmer or spinner
                        return const DateTimeShimmer();
                      }

                      final now = snapshot.data!;
                      final formattedTime = DateFormat('hh.mm').format(now);
                      final formattedMonth = DateFormat(
                        'd MMM yyyy',
                      ).format(now);
                      final formattedDay = DateFormat('EEEE').format(now);

                      return AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedDay,
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedMonth.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                height: 0.8,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
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
                                  SizedBox(height: size.height * 0.1),
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
                                    S.of(context).noEventsFotToday,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.black87),
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
                                            vertical: 10,
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                eventColors[index %
                                                    eventColors.length],
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                  bottomLeft: Radius.circular(
                                                    20,
                                                  ),
                                                  bottomRight: Radius.circular(
                                                    20,
                                                  ),
                                                ),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.black.withOpacity(
                                            //       0.4,
                                            //     ),
                                            //     blurRadius: 12,
                                            //     offset: const Offset(4, 6),
                                            //   ),
                                            // ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                        0.55,
                                                    child: Text(
                                                      state.events[index].title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                              0xFF1E1E1E,
                                                            ),
                                                          ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
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
                                                  InkWell(
                                                    onTap: () {},
                                                    child: const CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage: NetworkImage(
                                                        'https://cdn-icons-png.flaticon.com/512/14984/14984838.png',
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
