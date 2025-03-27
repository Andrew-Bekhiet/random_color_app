import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:random_color_app/main.dart';

void main() {
  group('Random Color App', () {
    const String requiredText = 'Hello there';

    testWidgets('Shows "$requiredText" in the middle of the screen', (
      tester,
    ) async {
      await tester.pumpWidget(const RandomColorApp());

      expect(find.text(requiredText), findsOneWidget);

      final Offset textCenter = tester.getCenter(find.text(requiredText));

      final Offset viewCenter = _getTestViewCenter(tester.view);

      expect(textCenter, viewCenter);
    });
  });
}

Offset _getTestViewCenter(FlutterView testView) =>
    testView.physicalSize.center(Offset.zero);
