import 'package:flutter_test/flutter_test.dart';
import 'package:github_explorer/main.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const GithubExplorerApp());
    expect(find.text('GitHub Explorer'), findsOneWidget);
  });
}
