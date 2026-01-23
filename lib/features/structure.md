### Project main structure

```
lib/
├── features/ # Feature Modules (Screens/Logic)
│ ├── client/ # Client-specific features (Booking, Home)
│ ├── partner/ # Partner-specific features (Orders, Portfolio)
│ ├── common/ # Shared features (Auth, Splash)
│ └── components/ # Shared UI Widgets (Atoms/Molecules)
```

**Example:**

```
common/
├── choose_yo_side
│ ├── choose_yo_side_screen.dart #For ui
│ ├── choose_yo_side_controller.dart #For logic
│ └── widgets/
│     └── some_widget.dart #For component widget only use in this screen
```

### 1. Screen File

**Example:**

```dart
import 'package:sukientotapp/core/utils/import/global.dart';

import 'choose_yo_side_controller.dart';

class ChooseYoSideScreen extends GetView<ChooseYoSideController> {
  const ChooseYoSideScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Widget(); //Build something yo want idk wwww!
  }
}
```

### 2. Controller File

**Example:**

```dart
import 'package:sukientotapp/core/utils/import/global.dart';

class ChooseYoSideController extends GetxController {

  //some GETX state
  final RxBool isServiceProvider = false.obs;

  // This gonna use so much if you need to call api for stm
  // @override
  // void onInit() {
  //   super.onInit();
  // }
}

```
