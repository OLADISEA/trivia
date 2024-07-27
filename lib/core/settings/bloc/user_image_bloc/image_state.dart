import 'package:equatable/equatable.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageUploading extends ImageState {}

class ImageUploaded extends ImageState {
  final String imageUrl;

  const ImageUploaded(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class ImageUploadError extends ImageState {
  final String error;

  const ImageUploadError(this.error);

  @override
  List<Object> get props => [error];
}
