import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker_app_task/src/core/constants/app_strings.dart';
import 'package:habit_tracker_app_task/src/core/injections/dependency_injections.dart';
import 'package:habit_tracker_app_task/src/core/routing/app_routes.dart';
import 'package:habit_tracker_app_task/src/core/services/connectivity_service.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_bloc.dart';
import 'package:habit_tracker_app_task/src/features/habit_tracker/presentation/blocs/habit_event.dart';
import 'package:habit_tracker_app_task/src/shared/presentation/cubits/connectivity_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp();

  // Set up dependency injection
  initInjections();

  runApp(const MiniHabitApp());
}

class MiniHabitApp extends StatelessWidget {
  const MiniHabitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityCubit(ConnectivityService())..checkInitialStatus(),
        ),
        BlocProvider<HabitBloc>(
          create: (context) => sl<HabitBloc>()..add(LoadHabitsEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.introScreen,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}

//      Scaffold(
//               backgroundColor: Colors.grey[100],
//               appBar: AppBar(
//                 title: const Text(
//                   AppStrings.habits,
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 automaticallyImplyLeading: false,
//                 centerTitle: true,
//                 elevation: 2,
//                 backgroundColor: Colors.white,
//                 foregroundColor: Colors.black87,
//               ),
//               body: PopScope(
//                 canPop: false,
//                 child: SafeArea(
//                   child: BlocBuilder<HabitBloc, HabitState>(
//                     builder: (context, state) {
//                       if (state is HabitLoadingState) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (state is HabitLoadedState) {
//                         final habits = state.habits;
//
//                         if (habits.isEmpty) {
//                           return Center(
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: const [
//                                 Icon(Icons.self_improvement_outlined, size: 100, color: Colors.grey),
//                                 SizedBox(height: 20),
//                                 Text(
//                                   AppStrings.noHabitsAddedYet,
//                                   style: TextStyle(fontSize: 22, color: AppStyles.darkTextColor),
//                                 ),
//                               ],
//                             ).withPaddingHorizontal(20),
//                           );
//                         }
//
//                         return RefreshIndicator(
//                           onRefresh: () async {
//                             context.read<HabitBloc>().add(LoadHabitsEvent());
//                           },
//                           child: ListView.separated(
//                             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                             itemCount: habits.length,
//                             separatorBuilder: (_, __) => const SizedBox(height: 10),
//                             itemBuilder: (context, index) {
//                               final habit = habits[index];
//                               final isCompletedToday = habit.isCompletedToday();
//
//                               return HabitListTile(
//                                 habit: habit,
//                                 isCompletedToday: isCompletedToday,
//                                 onComplete: () {
//                                   final today = DateTime.now();
//                                   final cleanDate = DateTime(today.year, today.month, today.day);
//                                   context.read<HabitBloc>().add(MarkHabitAsDoneEvent(
//                                         habitId: habit.id,
//                                         date: cleanDate,
//                                       ));
//                                 },
//                               );
//                             },
//                           ),
//                         );
//                       } else if (state is HabitErrorState) {
//                         return Center(
//                           child: Text(
//                             state.message,
//                             style: const TextStyle(color: AppStyles.errorColor),
//                           ).withPaddingAll(),
//                         );
//                       }
//
//                       return const SizedBox();
//                     },
//                   ),
//                 ),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: () => _openAddHabitBottomSheet(context),
//                 backgroundColor: AppStyles.buttonColor,
//                 foregroundColor: AppStyles.whiteColor,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//                 child: const Icon(Icons.add),
//               ),
//             ),
