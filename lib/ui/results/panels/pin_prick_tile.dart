import 'package:flutter/material.dart';
import 'package:neuro_planner/utils/themes/text_styles.dart';
import 'package:research_package/research_package.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PinPrickTile extends StatelessWidget {
  PinPrickTile({super.key, required this.result});
  final RPTaskResult result;
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Pin prick',
        style: ThemeTextStyle.regularIBM20sp,
      ),
      leading: Icon(Icons.create, color: Theme.of(context).colorScheme.primary),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () => _controller.animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn),
                child: Text('left')),
            Text('Button here'),
            ConstrainedBox(
              //todo: change to sized box
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: PageView(
                controller: _controller,
                children: [PinPrickResultBody(), PinPrickResultBody()],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 2,
            )
          ],
        )
      ],
    );
  }
}

class PinPrickResultBody extends StatelessWidget {
  const PinPrickResultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [Text('data'), Text('data2')],
    );
  }
}
