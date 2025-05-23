import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_agroflow/main.dart';

void main() {
  testWidgets('AgroFlow app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AgroFlowApp());

    // Verify that app starts with splash screen
    expect(find.text('AgroFlow'), findsOneWidget);
  });
}
