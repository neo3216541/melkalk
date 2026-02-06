import 'package:equatable/equatable.dart';

class MelCategory extends Equatable {
  final String name;
  final int delayDays;
  final DateTime calculatedDate;

  const MelCategory({
    required this.name,
    required this.delayDays,
    required this.calculatedDate,
  });

  @override
  List<Object?> get props => [name, delayDays, calculatedDate];
}
