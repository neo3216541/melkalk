import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/calculate_mel_dates.dart';
import 'mel_calculator_event.dart';
import 'mel_calculator_state.dart';

class MelCalculatorBloc extends Bloc<MelCalculatorEvent, MelCalculatorState> {
  final CalculateMelDates calculateMelDates;

  MelCalculatorBloc({
    required this.calculateMelDates,
  }) : super(MelCalculatorInitial()) {
    on<CalculateMelDatesEvent>(_onCalculateMelDates);
  }

  Future<void> _onCalculateMelDates(
    CalculateMelDatesEvent event,
    Emitter<MelCalculatorState> emit,
  ) async {
    final categories = calculateMelDates(
      categoryADelay: event.categoryADelay,
      categoryBDelay: event.categoryBDelay,
      categoryCDelay: event.categoryCDelay,
      categoryDDelay: event.categoryDDelay,
    );
    emit(MelCalculatorLoaded(categories));
  }
}
