
enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String _street;
  final String _city;
  final String _zipCode;

  Address(this._street, this._city, this._zipCode);

  String get street => _street;
  String get city => _city;
  String get zipCode => _zipCode;
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee(
    this._name,
    this._baseSalary, {
    required List<Skill> skills,
    required Address address,
    required int yearsOfExperience,
  })  : _skills = List.unmodifiable(skills),
        _address = address,
        _yearsOfExperience = yearsOfExperience;

  Employee.mobileDeveloper(
    String name,
    double baseSalary,
    Address address,
    int yearsOfExperience,
  ) : this(
          name,
          baseSalary,
          skills: [Skill.FLUTTER, Skill.DART],
          address: address,
          yearsOfExperience: yearsOfExperience,
        );

  Employee.flutterDeveloper(
    String name,
    double baseSalary,
    Address address,
    int yearsOfExperience,
  ) : this(
          name,
          baseSalary,
          skills: [Skill.FLUTTER],
          address: address,
          yearsOfExperience: yearsOfExperience,
        );

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double calculateSalary() {
    double salary = 40000;

    salary += _yearsOfExperience * 2000;

    for (Skill skill in _skills) {
      switch (skill) {
        case Skill.FLUTTER:
          salary += 5000;
          break;
        case Skill.DART:
          salary += 3000;
          break;
        case Skill.OTHER:
          salary += 1000;
          break;
      }
    }

    return salary;
  }

  void printDetails() {
    print('Employee: $_name');
    print('Base Salary: \$$_baseSalary');
    print('Skills: $_skills');
    print('Address: ${_address.street}, ${_address.city}, ${_address.zipCode}');
    print('Years of Experience: $_yearsOfExperience');
    print('Calculated Salary: \$${calculateSalary()}');
    print('------------------------');
  }
}

void main() {
  var address1 = Address('Street 1', 'Phnom Penh', '12000');
  var address2 = Address('Street 2', 'Siem Reap', '17000');

  var emp1 = Employee.mobileDeveloper(
    'Sokea',
    40000,
    address1,
    3,
  );

  var emp2 = Employee.flutterDeveloper(
    'Ronan',
    45000,
    address2,
    2,
  );

  emp1.printDetails();
  emp2.printDetails();
}
