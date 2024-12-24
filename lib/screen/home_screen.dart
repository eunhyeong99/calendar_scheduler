import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // Map<DateTime, List<ScheduleTable>> schedules = {
  //   DateTime.utc(2024, 3, 8): [
  //     ScheduleTable(
  //       id: 1,
  //       startTime: 11,
  //       endTime: 12,
  //       content: '플러터 공부하기',
  //       date: DateTime.utc(2024, 3, 8),
  //       color: categoryColors[0],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //     ScheduleTable(
  //       id: 2,
  //       startTime: 14,
  //       endTime: 16,
  //       content: 'NestJS Study',
  //       date: DateTime.utc(2024, 3, 8),
  //       color: categoryColors[3],
  //       createdAt: DateTime.now().toUtc(),
  //     ),
  //   ],
  // };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final schedule = await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) => ScheduleBottomSheet(
              selectedDay: selectedDay,
            ),
          );
          if (schedule == null) {
            return;
          }

          // final dateExists = schedules.containsKey(schedule.date);
          //
          // final List<ScheduleTable> existingSchedules =
          //     dateExists ? schedules[schedule.date]! : [];

          // existingSchedules.add(schedule);

          // setState(() {
          //   schedules = {
          //     ...schedules,
          //     schedule.date: [
          //       if (schedules.containsKey(schedule.date))
          //         ...schedules[schedule.date]!,
          //       schedule,
          //     ]
          //   };
          // });

        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime.now(),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            TodayBanner(
              selectedDay: selectedDay!,
              taskCount: 0,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: ListView.separated(
                  itemCount: 0,
                  itemBuilder: (BuildContext context, int index) {
                    // final selectedSchedules = schedules[selectedDay]!;
                    // final scheduleModel = selectedSchedules[index];

                    return ScheduleCard(
                      startTime: 12,
                      endTime: 14,
                      content: 'scheduleModel.content',
                      color: Color(
                        int.parse(
                          'FF000000',
                          radix: 16,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 8.0);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(date) {
    if (selectedDay == null) {
      return false;
    }
    return date.isAtSameMomentAs(selectedDay!);
  }
}
