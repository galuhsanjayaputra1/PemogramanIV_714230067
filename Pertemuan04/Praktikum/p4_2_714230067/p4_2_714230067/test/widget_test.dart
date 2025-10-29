// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:p4_2_714230067/main.dart';

void main() {
  testWidgets('Pertemuan4App shows expected widgets', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const Pertemuan4App());

    // Verify AppBar title is shown.
    expect(find.text('Tugas Pertemuan 4'), findsOneWidget);

    // Verify the three boxes are present.
    expect(find.text('Box 1'), findsOneWidget);
    expect(find.text('Box 2'), findsOneWidget);
    expect(find.text('Box 3'), findsOneWidget);
  });
}
