import 'package:equatable/equatable.dart';

abstract class MelCalculatorEvent extends Equatable {
  const MelCalculatorEvent();

  @override
  List<Object?> get props => [];
}

class CalculateMelDatesEvent extends MelCalculatorEvent {
  final int categoryADelay;
  final int categoryBDelay;
  final int categoryCDelay;
  final int categoryDDelay;

  const CalculateMelDatesEvent({
    required this.categoryADelay,
    required this.categoryBDelay,
    required this.categoryCDelay,
    required this.categoryDDelay,
  });

  @override
  List<Object?> get props => [
        categoryADelay,
        categoryBDelay,
        categoryCDelay,
        categoryDDelay,
      ];
}
