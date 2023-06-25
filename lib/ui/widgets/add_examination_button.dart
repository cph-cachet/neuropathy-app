import 'package:flutter/material.dart';

import 'package:neuropathy_grading_tool/examination_page.dart';

class AddExaminationButton extends StatelessWidget {
  const AddExaminationButton({super.key});

  @override
  Widget build(BuildContext context) {
    Widget slideTransition(animation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease)).animate(animation),
        child: child,
      );
    }

    return FloatingActionButton(
      child: const Icon(Icons.add_rounded, size: 36),
      onPressed: () => Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (_, __, ___) => ExaminationPage(),
        transitionDuration: const Duration(milliseconds: 350),
        transitionsBuilder: (_, animation, __, child) =>
            slideTransition(animation, child),
      )),
    );
  }
}
