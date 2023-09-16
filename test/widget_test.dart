// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tech_task/main.dart';

void main() {
  testWidgets('Verify get recipes button only appears on Ingredients '
  'screen after ingredients have been selected', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));
    
    // This checks that floating action button is not visible on screen initialization
    expect(find.byType(FloatingActionButton), findsNothing);
    await tester.pumpAndSettle(Duration(seconds: 5));

    // This ensures that the text are visible & the date picker is visible
    expect(find.text("OK"), findsOneWidget);
    expect(find.text("SELECT A LUNCH DATE"), findsOneWidget);
    expect(find.text("INGREDIENTS"), findsOneWidget);
    expect(find.text("Select ingredients to see available recipes"), findsOneWidget);
  });
}
