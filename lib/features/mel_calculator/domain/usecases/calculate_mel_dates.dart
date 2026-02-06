import '../entities/mel_category.dart';

class CalculateMelDates {
  List<MelCategory> call({
    required int categoryADelay,
    required int categoryBDelay,
    required int categoryCDelay,
    required int categoryDDelay,
  }) {
    final now = DateTime.now();

    return [
      MelCategory(
        name: 'A',
        delayDays: categoryADelay,
        calculatedDate: now.add(Duration(days: categoryADelay)),
      ),
      MelCategory(
        name: 'B',
        delayDays: categoryBDelay,
        calculatedDate: now.add(Duration(days: categoryBDelay)),
      ),
      MelCategory(
        name: 'C',
        delayDays: categoryCDelay,
        calculatedDate: now.add(Duration(days: categoryCDelay)),
      ),
      MelCategory(
        name: 'D',
        delayDays: categoryDDelay,
        calculatedDate: now.add(Duration(days: categoryDDelay)),
      ),
    ];
  }
}
