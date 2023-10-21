enum Role {
  manager,
  admin,
  ambasador;

  @override
  String toString() {
    switch (this) {
      case Role.manager:
        return "Manager";
      case Role.admin:
        return "Administrator";
      case Role.ambasador:
        return "Ambasador";
    }
  }
}
