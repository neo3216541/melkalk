import 'package:equatable/equatable.dart';
import '../../domain/entities/mel_category.dart';

abstract class MelCalculatorState extends Equatable {
  const MelCalculatorState();

  @override
  List<Object?> get props => [];
}

class MelCalculatorInitial extends MelCalculatorState {}

class MelCalculatorLoaded extends MelCalculatorState {
  final List<MelCategory> categories;

  const MelCalculatorLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}
