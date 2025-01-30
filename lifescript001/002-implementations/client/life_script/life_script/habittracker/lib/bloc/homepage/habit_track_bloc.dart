import 'package:bloc/bloc.dart';
import 'package:habittracker_openapi/openapi.dart';

import 'package:equatable/equatable.dart';

class HabitTrackBloc extends Bloc<HabitTrackEvent, HabitTrackState> {
  
  final Openapi openApi;

  HabitTrackBloc({required this.openApi}) : super(HabitTrackInitial()){

    on<HabitTrackSubmittedEvent>(_onHabitTrackSubmitted);
  }
  
  Future<void> _onHabitTrackSubmitted(HabitTrackSubmittedEvent event, Emitter<HabitTrackState> emit) async {

    emit(HabitTrackLoading());
    try {
      final habitTracker = HabitTrack((b) => b
        ..habitName = event.habitName
        ..description = event.description);
        
      final response = await openApi.getHabitTrackResourceApi().createHabitTrack(
        habitTrack: habitTracker,
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );
      if (response.statusCode == 200) {
          emit(HabitTrackSuccessState(habitName: event.habitName, description: event.description));
        } 
      else {
        emit(HabitTrackFailure(error: 'Failed to create habit track'));
      }
    } 

    catch (e) {
      emit(HabitTrackFailure(error: e.toString()));
    }
  }
}

 






abstract class HabitTrackEvent extends Equatable {
  const HabitTrackEvent();

  @override
  List<Object> get props => [];
  
}

class HabitTrackSubmittedEvent extends HabitTrackEvent {
  
  final String habitName;
  final String description;
  
  const HabitTrackSubmittedEvent({required this.habitName, required this.description});

  @override
  List<Object> get props => [habitName, description];
}







abstract class HabitTrackState extends Equatable {
  const HabitTrackState();

  @override
  List<Object> get props => [];
}

class HabitTrackInitial extends HabitTrackState {}

class HabitTrackLoading extends HabitTrackState {}



class HabitTrackSuccessState extends HabitTrackState {
  final String habitName;
  final String description;

  const HabitTrackSuccessState({required this.habitName, required this.description});

  @override
  List<Object> get props => [habitName, description];
}



class HabitTrackFailure extends HabitTrackState {
  final String error;

  const HabitTrackFailure({required this.error});

  @override
  List<Object> get props => [error];
}