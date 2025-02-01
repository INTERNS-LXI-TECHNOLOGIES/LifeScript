import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:communication_openapi/openapi.dart';
import 'package:communication/bloc/events/admin_mediaUpload_events/upload_button_event.dart';
import 'package:communication/bloc/events/admin_mediaUpload_events/upload_event.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_failure_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_initial_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_loading_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_state.dart';
import 'package:communication/bloc/states/admin_mediaUpload_states/upload_success_state.dart';

class AdminMediaUploadBloc extends Bloc<UploadEvent, UploadState> {
  final Openapi _api; // OpenAPI client instance

  AdminMediaUploadBloc(this._api) : super(UploadInitialState()) {
    
    on<UploadButtonEvent>((event, emit) {
      emit(UploadLoadingState());

      try {
        final mediaContent = MediaContentBuilder()
          ..text = event.text
          ..textAudio = event.textAudio
          ..language = event.language
          ..difficultyLevel = event.difficultyLevel
          ..uploadDateTime = event.uploadDateTime?.toUtc();

        final response = _api.getMediaContentResourceApi().createMediaContent(
              mediaContent: mediaContent.build(),
              headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
              
            );
            print(Openapi.jwt);

        if (response != null) {
          emit(UploadSuccessState(message: 'Successfully uploaded media content'));
        } else {
          emit(UploadFailureState('Failed to upload media content.', error: ''));
        }
      } catch (e) {
        emit(UploadFailureState('Error occurred while uploading media content: $e', error: ''));
      }
    });
  }
}
