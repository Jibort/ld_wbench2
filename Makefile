setup:
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    flutter gen-l10n