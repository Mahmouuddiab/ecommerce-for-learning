import 'package:equatable/equatable.dart';

class VerifyCodeEntity extends Equatable {
  final String status;

  const VerifyCodeEntity({
    required this.status,
  });

  @override
  List<Object?> get props => [status];
}