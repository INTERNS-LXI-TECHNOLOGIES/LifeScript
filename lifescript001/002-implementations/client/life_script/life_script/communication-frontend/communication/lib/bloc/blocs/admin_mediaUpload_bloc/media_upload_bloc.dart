import 'package:communication/bloc/events/admin_mediaUpload_events/upload_button_event.dart';
import 'package:communication/bloc/events/admin_mediaUpload_events/upload_event.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_failure_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_initial_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_loading_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_success_state.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminMediaUploadBloc extends Bloc<UploadEvent, UploadState> {
  final Openapi _openapi;

  AdminMediaUploadBloc(this._openapi) : super(UploadInitialState()) {
    on<UploadButtonEvent>(_handleUploadMediaContent);
  }

  Future<void> _handleUploadMediaContent(
      UploadButtonEvent event, Emitter<UploadState> emit) async {
    emit(UploadLoadingState());

    try {
      // Build the MediaContent object
      final mediaContent = MediaContentBuilder()
        ..text = event.text
        ..textAudio = event.textAudio
        ..language = event.language
        ..difficultyLevel = event.difficultyLevel
        ..uploadDateTime = event.uploadDateTime;

      // Make the API call to upload media content
      final response = await _openapi.getMediaContentResourceApi().createMediaContent(
        mediaContent: mediaContent.build(),
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(UploadSuccessState( message: 'Successfully uploaded media content'));
      } else {
        emit(UploadFailureState('Failed to upload media content. Status: ${response.statusCode}', error: ''));
      }
    } catch (e) {
      emit(UploadFailureState('Error occurred while uploading media content: $e', error: ''));
    }
  }
}
