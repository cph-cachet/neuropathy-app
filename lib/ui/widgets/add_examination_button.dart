import 'package:flutter/material.dart';

import '../../examination_page.dart';

class AddExaminationButton extends StatelessWidget {
  const AddExaminationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add_rounded, size: 36),
      onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<dynamic>(builder: (context) => ExaminationPage())),
    );
  }
}
