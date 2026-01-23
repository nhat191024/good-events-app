# So you how to use and some file use for what in utils

### All new utils need to have a FKIN docs here. I don't care small or big. Write it here i (or we) ain't gonna read yo dumb code

## Table of Contents

1. [API Service](#1-api-service)

## 1. Import folder

- [Binding.dart](/lib/core/utils/import/binding.dart) contain export binding - check [router docs](/lib/core/routes/How_To_Use_Route.md) for more details.
- [Global.dart](/lib/core/utils/import/global.dart) contain commonly used packages in project - if you find something are frequently used across the app you can export it here (not everything lol).
- [Screen.dart](/lib/core/utils/import/screens.dart) contain export screen - check [router docs](/lib/core/routes/How_To_Use_Route.md) for more details.

## 2. Logger

- Logger package and i write it here so we can use it global (already in global import)
- Check file for more example -> [Logger.dart](/lib/core/utils/logger.dart)

**Example:**

```dart
import 'package:sukientotapp/core/utils/import/global.dart'; //import global in your file

void something() {
    if (kDebugMode) {
        logger.i("Something is loggggged");
    }
}
```
