enum Sex { male, female }

enum EducationLevel {
  incompleteElementary,
  completeElementary,
  incompleteHighSchool,
  completeHighSchool,
  incompleteCollege,
  completeCollege,
  other
}

enum Handedness { leftHanded, rightHanded, ambidextrous }

extension SexDesc on Sex {
  String get description {
    switch (this) {
      case Sex.male:
        return "Male";
      case Sex.female:
        return "Female";
      default:
        return "---";
    }
  }
}

extension EducationLevelDesc on EducationLevel {
  String get description {
    switch (this) {
      case EducationLevel.incompleteElementary:
        return "Incomplete Elementary";
      case EducationLevel.completeElementary:
        return "Complete Elementary";
      case EducationLevel.incompleteHighSchool:
        return "Incomplete High School";
      case EducationLevel.completeHighSchool:
        return "Complete High School";
      case EducationLevel.incompleteCollege:
        return "Incomplete College";
      case EducationLevel.completeCollege:
        return "Complete College";
      case EducationLevel.other:
        return "Other";
      default:
        return "---";
    }
  }
}

extension HandednessDescription on Handedness {
  String get description {
    switch (this) {
      case Handedness.leftHanded:
        return "Left-Handed";
      case Handedness.rightHanded:
        return "Right-Handed";
      case Handedness.ambidextrous:
        return "Ambidextrous";
      default:
        return "---";
    }
  }
}
