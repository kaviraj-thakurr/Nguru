// setting screen

//  SettingItem settingItem = SettingItem.changeSession;

enum SettingItem {
  myProfile,
  changeSibling,
  changeSession,
  addSchool,
  pushNotification,
  changePassword,
  feedback,
  termsOfUse,
  privacyPolicy,
  support,
  selfDeclaration,
}

// Extension to map enum values to their corresponding string representations
extension SettingItemExtension on SettingItem {
  String get label {
    switch (this) {
      case SettingItem.myProfile:
        return "My Profile";
      case SettingItem.changeSibling:
        return "Change Sibling";
      case SettingItem.changeSession:
        return "Change Session";
      case SettingItem.addSchool:
        return "Add School";
      case SettingItem.pushNotification:
        return "Push Notification";
      case SettingItem.changePassword:
        return "Change Password";
      case SettingItem.feedback:
        return "Feedback";
      case SettingItem.termsOfUse:
        return "Terms of use";
      case SettingItem.privacyPolicy:
        return "Privacy & Policy";
      case SettingItem.support:
        return "Support";
      case SettingItem.selfDeclaration:
        return "Self Declaration";
    }
  }
}
