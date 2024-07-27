import 'package:equatable/equatable.dart';

abstract class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object> get props => [];
}

class FetchProgress extends ProgressEvent {
  final String userId;

  const FetchProgress(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateProgress extends ProgressEvent {
  final List<Map<String, dynamic>> progress;

  const UpdateProgress(this.progress);

  @override
  List<Object> get props => [progress];
}
