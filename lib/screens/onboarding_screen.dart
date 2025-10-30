import 'package:fitness_tracker/core/constants.dart';
import 'package:fitness_tracker/screens/work_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Track Your Workouts',
          body:
              'Keep track of your exercises, sets, and reps all in one place.',
          image: const FlutterLogo(size: 100),
        ),
        PageViewModel(
          title: 'Monitor Progress',
          body: 'See your workout history and track your progress over time.',
          image: const FlutterLogo(size: 100),
        ),
        PageViewModel(
          title: 'Stay Motivated',
          body: 'Set goals and stay motivated with our easy-to-use interface.',
          image: const FlutterLogo(size: 100),
        ),
      ],
      showNextButton: true,
      next: const Text('Next'),
      done: const Text('Get Started'),
      onDone: () => onDone(),
    );
  }

  //on done
  void onDone() async {
    await _onboardingInitialStatus();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WorkListScreen()),
      );
    }
  }

//shared prefrence set onboarding complete
  Future<void> _onboardingInitialStatus() async {
    final sharedPrefrence = await SharedPreferences.getInstance();
    sharedPrefrence.setBool(hasOnboardingInitialized, true);
  }
}
