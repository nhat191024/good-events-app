# How

- All Data in this project require a models (or else nobody will understand anything)
- So i will provide you a example about this

**Example**

- User model

```dart
class User {
  final int id;
  final String username;
  final String name;

  User({required this.id, required this.username, required this.name});

    ///fromJoon help take data from api return
  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'] ?? 0, username: json['username'] ?? '', name: json['name'] ?? '');
  }

    ///Same with above but with opposite result
  Map<String, dynamic> toJson() {
    return {'id': id, 'username': username, 'name': name};
  }
}
```

- Use in a controller (gonna update this in future with GetX state for model)

```dart
import 'package:sukientotapp/data/models/user.dart'; //import model

  Future<void> login() async {
    //some logic for post login
    final data = response.data;
    if (data['user'] != null) {
        final user = User.fromJson(data['user']);
    }
  }
```
