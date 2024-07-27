import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

import '../../../../data/shared_preference_helper.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final FirebaseStorage _firebaseStorage;
  final FirebaseFirestore _firestore;
  final SharedPreferencesHelper _sharedPreferencesHelper;

  ImageBloc(this._firebaseStorage, this._firestore, this._sharedPreferencesHelper) : super(ImageInitial()) {
    on<UploadImageEvent>((event, emit) async {
      emit(ImageUploading());
      try {
        File imageFile = File(event.imagePath);
        String fileName = path.basename(imageFile.path);
        Reference ref = _firebaseStorage.ref().child('user_images').child(event.userId).child(fileName);
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await _firestore.collection('users').doc(event.userId).update({'imageUrl': downloadUrl});

        // Save the image URL in SharedPreferences
        await _sharedPreferencesHelper.saveUserImageUrl(downloadUrl);


        emit(ImageUploaded(downloadUrl));
      } catch (e) {
        emit(ImageUploadError(e.toString()));
      }
    });
  }
}
