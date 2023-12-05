import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../../core/fp/either.dart';
import '../../../../../../core/providers/application_providers.dart';

part 'home_customer_provider.g.dart';

@riverpod
Future<int> getTotalSchedulesToday(
  GetTotalSchedulesTodayRef ref,
  int userId,
) async {
  final DateTime(:year, :month, :day) = DateTime.now();
  final filter = (date: DateTime(year, month, day, 0, 0, 0), userId: userId);

  final scheduleResult =
      await ref.read(scheduleRepositoryProvider).findScheduleByDate(filter);

  return switch (scheduleResult) {
    Success(value: List(length: final totalSchedules)) => totalSchedules,
    Failure(:final exception) => throw exception,
  };
}
