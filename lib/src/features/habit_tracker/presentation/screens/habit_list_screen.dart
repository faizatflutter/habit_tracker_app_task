import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_colors.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/core/extensions/widget_extensions.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_bloc.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_event.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_state.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/widgets/add_habit_bottom_sheet.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/widgets/habit_list_tile.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  void _openAddHabitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => AddHabitBottomSheet(
        onSubmit: (name, frequency, startDate) {
          context.read<HabitBloc>().add(AddHabitEvent(
                name: name,
                frequency: frequency,
                startDate: startDate,
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          AppStrings.habits,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            if (state is HabitLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HabitLoadedState) {
              final habits = state.habits;

              if (habits.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.self_improvement_outlined, size: 100, color: Colors.grey),
                      SizedBox(height: 20),
                      Text(
                        AppStrings.noHabitsAddedYet,
                        style: TextStyle(fontSize: 22, color: AppStyles.darkTextColor),
                      ),
                    ],
                  ).withPaddingHorizontal(20),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HabitBloc>().add(LoadHabitsEvent());
                },
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: habits.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final habit = habits[index];
                    final isCompletedToday = habit.isCompletedToday();

                    return HabitListTile(
                      habit: habit,
                      isCompletedToday: isCompletedToday,
                      onComplete: () {
                        final today = DateTime.now();
                        final cleanDate = DateTime(today.year, today.month, today.day);
                        context.read<HabitBloc>().add(MarkHabitAsDoneEvent(
                              habitId: habit.id,
                              date: cleanDate,
                            ));
                      },
                    );
                  },
                ),
              );
            } else if (state is HabitErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppStyles.errorColor),
                ).withPaddingAll(),
              );
            }

            return const SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddHabitBottomSheet(context),
        backgroundColor: AppStyles.buttonColor,
        foregroundColor: AppStyles.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
