# Audifie Mobile Application

## Versions
1. Flutter 2.0.5 • channel stable • https://github.com/flutter/flutter.git
1. Framework • revision adc687823a (9 months ago) • 2021-04-16 1. 09:40:20 -0700
1. Engine • revision b09f014e96
1. Tools • Dart 2.12.3

## Architecture
Clean architecture

Tutorial [Link](https://www.youtube.com/watch?v=KjE2IDphA_U&list=PLB6lc7nQ1n4iYGE_khpXRdJkJEp9WOech)

File Structure
```
feature_name
    data
        models
        data_sources
        repositories
    domain
        entities
        usecases
        repositories
    presenter
        notifiers
        pages
            components

```

## State Management
Provider

[Docs](https://pub.dev/packages/provider)

## Dependency Injection
get_it packate File [Link](https://github.com/Audifie/Audifie-Flutter/blob/dev/lib/core/service_locator.dart)

[Docs](https://pub.dev/packages/get_it)

Example
```dart
GetIt sl = GetIt.instance;

Future<void> setUpServices() async {
    ...
    sl.registerSingleton<SomeClass>(SomeClassImplementation());
    ...
}
```

## Resonsiveness

Custom made File [Link](https://github.com/Audifie/Audifie-Flutter/blob/dev/lib/core/size_config.dart)

```dart
// Initialize inside inside class
static final SizeConfig sc = sl<SizeConfig>();
.
.
.
// Using for width and height
Container(
    width: sc.width(100),
    height: sc.height(100),
)

// Using for text
Text(
    'some text', 
    style: TStyle( // [TStyle] is a custom styling class
        color: Colors.black, 
        size: sc.text(12),
    )
)
```