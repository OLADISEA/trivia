import 'package:equatable/equatable.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class UploadImageEvent extends ImageEvent {
  final String userId;
  final String imagePath;

  const UploadImageEvent(this.userId, this.imagePath);

  @override
  List<Object> get props => [userId, imagePath];
}
