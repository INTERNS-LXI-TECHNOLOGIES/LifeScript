import 'package:bloc/bloc.dart';
import 'package:habittracker_openapi/openapi.dart';
import 'package:equatable/equatable.dart';

class HabitTrackBloc extends Bloc<HabitTrackEvent, HabitTrackState> {
  
  

  HabitTrackBloc() : super(HabitTrackInitial()) {

    on<HabitTrackSubmittedEvent>(_onHabitTrackSubmitted);
    on<StartDateSelectedEvent>(_onStartDateSelected);
    on<EndDateSelectedEvent>(_onEndDateSelected);
    on<UpdateHabitTrackEvent>(_onUpdateHabitTrack); 
    on<DeleteHabitTrackEvent>(_onDeleteHabitTrack);
  }
  
  Future<void> _onHabitTrackSubmitted(HabitTrackSubmittedEvent event, Emitter<HabitTrackState> emit) async {

    emit(HabitTrackLoading());
    
    try {
       final openApi = Openapi();

      final habitTracker = HabitTrack((b) => b
        ..habitName = event.habitName
        ..description = event.description
        ..startDate = event.startDate
        ..endDate = event.endDate
        ..category = event.category);

      final response = await openApi.getHabitTrackResourceApi().createHabitTrack(
        habitTrack: habitTracker,
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );
      
      if (response.statusCode == 200) {
          emit(HabitTrackSuccessState(habitName: event.habitName, 
                                      description: event.description , 
                                      startDate: event.startDate, 
                                      endDate: event.endDate, 
                                      category: event.category));
      } 
      else {
        emit(HabitTrackFailure(error: 'Failed to create habit track'));
      }
    } 

    catch (e) {
      emit(HabitTrackFailure(error: e.toString()));
    }
  }



  void _onStartDateSelected(StartDateSelectedEvent event, Emitter<HabitTrackState> emit) {
    if (state is HabitTrackDateSelectedState) {
      final currentState = state as HabitTrackDateSelectedState;
      emit(HabitTrackDateSelectedState(
        startDate: event.startDate,
        endDate: currentState.endDate,
      ));
    }
    else {
      emit(HabitTrackDateSelectedState(startDate: event.startDate));
    }
  }



  void _onEndDateSelected(EndDateSelectedEvent event, Emitter<HabitTrackState> emit) {
    if (state is HabitTrackDateSelectedState) {
      final currentState = state as HabitTrackDateSelectedState;
      emit(HabitTrackDateSelectedState(
        startDate: currentState.startDate,
        endDate: event.endDate,
      ));
    } 
    else {
      emit(HabitTrackDateSelectedState(endDate: event.endDate));
    }
  }



  Future<void> _onUpdateHabitTrack(UpdateHabitTrackEvent event, Emitter<HabitTrackState> emit) async {
    emit(HabitTrackLoading());

    try {

       final openApi = Openapi();

      final habitTracker = HabitTrack((b) => b
        ..id = event.id // Ensure the ID is passed for updating
        ..habitName = event.habitName
        ..description = event.description
        ..startDate = event.startDate
        ..endDate = event.endDate
        ..category = event.category);

      final response = await openApi.getHabitTrackResourceApi().updateHabitTrack(
        id: event.id, // Pass the ID for updating
        habitTrack: habitTracker,
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );

      if (response.statusCode == 200) {
        emit(HabitTrackSuccessState(habitName: event.habitName,
          description: event.description,
          startDate: event.startDate,
          endDate: event.endDate,
          category: event.category,
        ));
      } else {
        emit(HabitTrackFailure(error: 'Failed to update habit track'));
      }
    } catch (e) {
      emit(HabitTrackFailure(error: e.toString()));
    }
  }




    Future<void> _onDeleteHabitTrack(DeleteHabitTrackEvent event, Emitter<HabitTrackState> emit) async {
    emit(HabitTrackLoading());

    try {

       final openApi = Openapi();

      final response = await openApi.getHabitTrackResourceApi().deleteHabitTrack(
        id: event.id, // Pass the ID for deletion
        headers: {'Authorization': 'Bearer ${Openapi.jwt}'},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        emit(HabitTrackDeletedState()); // Emit a state for successful deletion
      } else {
        emit(HabitTrackFailure(error: 'Failed to delete habit track'));
      }
    } catch (e) {
      emit(HabitTrackFailure(error: e.toString()));
    }
  }
}

  



 






abstract class HabitTrackEvent extends Equatable {
  const HabitTrackEvent();

  @override
  List<Object> get props => [];
  
}

class FetchDayPlansEvent extends HabitTrackEvent {}

class HabitTrackSubmittedEvent extends HabitTrackEvent {
  final int id;
  final String habitName;
  final String description;
  final String startDate;
  final String endDate;
  final String category;

  const HabitTrackSubmittedEvent({
    required this.id,
    required this.habitName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.category,
  });

  @override
  List<Object> get props => [habitName, description];
}

class StartDateSelectedEvent extends HabitTrackEvent {
  final DateTime startDate;

  const StartDateSelectedEvent({required this.startDate});

  @override
  List<Object> get props => [startDate];
}



class EndDateSelectedEvent extends HabitTrackEvent {
  final DateTime endDate;

  const EndDateSelectedEvent({required this.endDate});

  @override
  List<Object> get props => [endDate];
}



class UpdateHabitTrackEvent extends HabitTrackEvent {
  final int id;
  final String habitName;
  final String description;
  final String startDate;
  final String endDate;
  final String category;

  const UpdateHabitTrackEvent({
    required this.id,
    required this.habitName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.category,
  });

  @override
  List<Object> get props => [id, habitName, description];
}



class DeleteHabitTrackEvent extends HabitTrackEvent {
  final int id;

  const DeleteHabitTrackEvent({required this.id});

  @override
  List<Object> get props => [id];
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
  final String startDate;
  final String endDate;
  final String category;
  
  const HabitTrackSuccessState({required this.habitName, required this.description , required this.startDate,
    required this.endDate,
    required this.category,});

  @override
  List<Object> get props => [habitName, description];
}

class HabitTrackFailure extends HabitTrackState {
  final String error;

  const HabitTrackFailure({required this.error});

  @override
  List<Object> get props => [error];
}


class HabitTrackDateSelectedState extends HabitTrackState {
  final DateTime? startDate;
  final DateTime? endDate;

  const HabitTrackDateSelectedState({this.startDate, this.endDate});

  @override
  List<Object> get props => [startDate ?? DateTime.now(), endDate ?? DateTime.now()];
}


class HabitTrackDeletedState extends HabitTrackState {}