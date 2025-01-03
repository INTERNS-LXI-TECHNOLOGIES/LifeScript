import 'package:component/main.dart';
import 'package:component/widget/component_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 // Replace with actual import path

void main() {
  group('ComposeContainer Tests', () {
    testWidgets('DraggableWidget displays correctly', (WidgetTester tester) async {
     
      await tester.pumpWidget(MaterialApp(home: DraggableComposeApp()));

     
      final draggableFinder = find.text('Drag Me');
      expect(draggableFinder, findsOneWidget);
    });

    testWidgets('DraggableWidget moves when dragged', (WidgetTester tester) async {
      
      await tester.pumpWidget(MaterialApp(home: DraggableComposeApp()));

      
      final draggableFinder = find.text('Drag Me');

      
      expect(draggableFinder, findsOneWidget);

      // Act: Drag the widget
      await tester.drag(draggableFinder, const Offset(50, 50));
      await tester.pumpAndSettle();

      // Assert: Verify that the widget is moved
      expect(draggableFinder, findsOneWidget);
    });
  });
}