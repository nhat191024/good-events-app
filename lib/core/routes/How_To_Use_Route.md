# Manual: How to Route in This Flutter Project

- If you want to add a new **screen**, you need to add routing for it. frfr or else idk do some dumb thing
- Each screen requires the following files:
  - **Screen file**: Contains the View and Widget build logic.
  - **Controller**: Logic and state management for that screen.
  - **Binding file**: To initialize the controller.

- some file already have you just need to wirte yo dumb thing into its:
  - **Screen export**: contain all screen this project use
  - **Binding export**: contain all binding router need
  - **Routes**: contain all paths for screen
  - **Pags**: contain all Page

# Some file you need to create

### 1. Binding File

**Example:**

```dart
import 'package:get/get.dart';
import 'package:sukientotapp/features/common/choose_yo_side/choose_yo_side_controller.dart';

class ChooseYoSideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseYoSideController>(() => ChooseYoSideController());
  }
}
```

### 2. Screen File

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

### 3. Controller File

**Example:**

```dart
import 'package:get/get.dart';

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

# After those boring thing above you can add it to route now yippi

### 1. Add thing to global import for router

- **Go to** [Sreen Import](/lib/core/utils/import/screens.dart)
- **Export** yo screen file

```dart
export 'package:sukientotapp/features/common/choose_yo_side/choose_yo_side_screen.dart';
```

- **Go to** [Binding Import](/lib/core/utils/import/binding.dart)
- **Export** yo binding file

```dart
export 'package:sukientotapp/core/bindings/choose_yo_side_binding.dart';
```

### 2. Add router path

- **Go to** [Routes](/lib/core/routes/routes.dart)
- **Add** Path for new srceen

```dart
part of 'pages.dart';

abstract class Routes {
Routes._();

//some path already here bla bla
static const chooseYoSideScreen = '/choose-yo-side';
//some path already here bla bla
}
```

### 3. Add page declaration

- **Go to** [Pages](/lib/core/routes/pages.dart)
- **Add** GetPage declar for yo screen

```dart
import 'package:get/get.dart';

import 'package:sukientotapp/core/utils/import/screens.dart';
import 'package:sukientotapp/core/utils/import/binding.dart';

part 'routes.dart';

class Pages {
  Pages._();

  static const initialRoute = Routes.splashScreen;

  static final routes = [
    //some page already here bla bla

    GetPage(
      name: Routes.chooseYoSideScreen,
      page: () => const ChooseYoSideScreen(),
      binding: ChooseYoSideBinding(),
    ),

    //some page already here bla bla
  ];
}

```

## This file could be get some update in future idk lol
