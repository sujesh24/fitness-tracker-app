import 'package:fitness_tracker/config/theme/theme.dart';
import 'package:fitness_tracker/core/constants.dart';
import 'package:fitness_tracker/providers/onboarding/onboarding_provider.dart';
import 'package:fitness_tracker/screens/onboarding_screen.dart';
import 'package:fitness_tracker/screens/work_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefrence = await SharedPreferences.getInstance();
  final hasSeenOnboarding =
      sharedPrefrence.getBool(hasOnboardingInitialized) ?? false;
  runApp(ProviderScope(overrides: [
    hasSeenOnboardingProvider.overrideWith((ref) => hasSeenOnboarding),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasSeenOnboarding = ref.watch(hasSeenOnboardingProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: AppTheme.darkTheme,
      home:
          hasSeenOnboarding ? const WorkListScreen() : const OnboardingScreen(),
    );
  }
}
