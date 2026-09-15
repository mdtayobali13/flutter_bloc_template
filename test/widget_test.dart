import 'package:flutter_bloc_template/main_app_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MainAppEntry());
    expect(find.byType(MainAppEntry), findsOneWidget);
  });
}
