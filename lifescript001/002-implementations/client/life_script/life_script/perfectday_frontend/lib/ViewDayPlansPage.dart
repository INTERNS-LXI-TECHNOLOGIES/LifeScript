import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapiperfectday/openapi.dart';
import 'package:perfectday_frontend/blocs/day_plan_bloc.dart';
import 'package:perfectday_frontend/events/day_plan_event.dart';
import 'package:perfectday_frontend/state/day_plan_state.dart';
import 'package:perfectday_frontend/state/day_plan_succes_state.dart';

class ViewDayPlansPage extends StatefulWidget {
  const ViewDayPlansPage({super.key});

  @override
  State<ViewDayPlansPage> createState() => _ViewDayPlansPageState();
}

class _ViewDayPlansPageState extends State<ViewDayPlansPage> {
  @override
  void initState() {
    super.initState();
    context.read<DayPlanBloc>().add(FetchDayPlansEvent());
  }

  void _updateDayPlan(int id, String title, String description,Date date) {
   
    // Trigger the update event to update the DayPlan
    context.read<DayPlanBloc>().add(UpdateDayPlanEvent(
      id: id,
      title: title,
      description: description,
      date: date,  // Pass the Date object here
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Day Plans'),
      ),
      body: BlocBuilder<DayPlanBloc, DayPlanState>(
        builder: (context, state) {
          if (state is DayPlanLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DayPlanDeleteState) {
            print("Delete State");
          } else if (state is DayPlanFetchSuccessState) {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.dayPlans.length,
              itemBuilder: (context, index) {
                final dayPlan = state.dayPlans[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(dayPlan.title ?? 'No Title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dayPlan.description?.isNotEmpty == true
                            ? dayPlan.description!
                            : 'No description available'),
                        const SizedBox(height: 4),
                        Text(
                          dayPlan.title ?? 'No Title',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Call _updateDayPlan when the edit button is pressed
                            _updateDayPlan(dayPlan.id!, 'Updated Title', 'Updated Description', dayPlan.date!);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            if (dayPlan.id != null) {
                              context
                                  .read<DayPlanBloc>()
                                  .add(DeleteDayPlanEvent(dayPlan.id!));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is DayPlanErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
