import 'package:communication/bloc/states/admin_mediaUpload_states/upload_state.dart';

class UploadFailureState extends UploadState {

  final String error;

  const UploadFailureState(String s, {required this.error});

  @override
  List<Object> get props => [error];
}