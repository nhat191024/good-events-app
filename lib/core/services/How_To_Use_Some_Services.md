# Manual: How to use some service in this project?

### All new service need to have a FKIN docs here. I don't care small or big. Write it here i (or we) ain't gonna read yo dumb code

## Table of Contents

1. [API Service](#1-api-service)
2. [Local Storage Service](#2-local-storage-service)

## 1. API SERVICE

- Simple thing no need to say much. Use it to call da backend/API.
- Use **Dio Package** for calling (_yo phone linging_)
- Use **pretty_dio_logger** to make the logger more read able (this thing it not tested when i write this)
- Auto include **Base Url** (from .env) in request
- Auto add **Auth token** (from local storage) if you already login on app

**Get Example:**

```dart
import 'package:sukientotapp/core/services/api_service.dart'; //import the service
  ///Check token validity
  Future<void> _checkToken() async {
    try {
      await _apiService.dio.get('/check-token');
    } catch (e) {
      debugPrint(e.toString())
    }
  }
```

**Post Example:**

```dart
import 'package:sukientotapp/core/services/api_service.dart'; //import the service
  ///Some post function
  Future<void> postMeme(String meme) async {
    try {
      final response = await _apiService.dio.post(
        '/meme',
        data: {'meme': meme},
      );

      final data = response.data;
       if (kDebugMode) {
        debugPrint(data.toString) //meme
       }

    } catch (e) {
      debugPrint(e.toString())
    }
  }
```

## 2. Local Storage SERVICE

- Also simple thing no need to say much. Use it to read/write/remove/check/clear.
- Write support write bool/string
- Use **Get Storage** for manager
- You can define keys inside [Local Storage Keys](/lib/core/services/localstorage_service.dart)

**Example:**

- **Import**

```dart
    import 'package:sukientotapp/core/services/localstorage_service.dart';
```

- **Read**

```dart
    var token = StorageService.readData(key: LocalStorageKeys.token);
```

- **Write**

```dart
    //Bool
    StorageService.writeBoolData(key: LocalStorageKeys.isTokenExist, value: true);

    //String
    StorageService.writeStringData(key: LocalStorageKeys.token, value: token);
```

- **Remove**

```dart
    StorageService.removeData(key: LocalStorageKeys.token);
```

- **Check**

```dart
    StorageService.checkData(key: LocalStorageKeys.token); //return true/false
```

- **Clear**

```dart
    StorageService.clearAllData();
```
