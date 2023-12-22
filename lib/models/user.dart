class FireBaseUser {
  late String uid;

  FireBaseUser({required this.uid});

  // override toString() method
  @override
  String toString() {
    return "FireBaseUser{uid: $uid}";
  }
}
