import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fraudsense/core/language/language_enum.dart';
import 'package:fraudsense/models/levels_holder_model.dart';
import 'package:fraudsense/providers/game_providers.dart';
import 'package:fraudsense/providers/providers.dart';
import 'package:mocktail/mocktail.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

late MockWidgetRef mockWidgetRef;
void main() {
  late MockWidgetRef mockWidgetRef;
  late ProviderContainer container;

  setUp(() {
    mockWidgetRef = MockWidgetRef();

    container = ProviderContainer(overrides: [
      timerValueProvider.overrideWith((ref) => 20),
    ]);

    when(() => mockWidgetRef.read(timerValueProvider.notifier))
        .thenReturn(container.read(timerValueProvider.notifier));

    when(() => mockWidgetRef.read(userDataProvider.notifier))
        .thenReturn(container.read(userDataProvider.notifier));

    when(() => mockWidgetRef.read(userDataProvider)).thenReturn(container.read(userDataProvider));

    when(() => mockWidgetRef.read(submittedAnswerProvider.notifier))
        .thenReturn(container.read(submittedAnswerProvider.notifier));

    when(() => mockWidgetRef.read(unsolvedScenariosListProvider.notifier))
        .thenReturn(container.read(unsolvedScenariosListProvider.notifier));

    when(() => mockWidgetRef.read(displayCurrentHintProvider.notifier))
        .thenReturn(container.read(displayCurrentHintProvider.notifier));
  });

  tearDown(() {
    container.dispose();
  });

  test("Changing language to english returns english levels", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    container.read(languageProvider.notifier).setLanguage(AppLanguage.en);

    final LevelsHolderModel levelsHolder = await container.read(levelsProvider.future);

    expect(levelsHolder.language, AppLanguage.en);
  });
  test("Changing language to arabic returns arabic levels", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    container.read(languageProvider.notifier).setLanguage(AppLanguage.ar);

    final LevelsHolderModel levelsHolder = await container.read(levelsProvider.future);

    expect(levelsHolder.language, AppLanguage.ar);
  });
}
