enum IconType {
  xperson,
  law,
  ambulance,
  edit2,
}

class IconData {
  final String iconPath;
  final String title;

  IconData({required this.iconPath, required this.title});
}

final Map<IconType, IconData> initial_icons = {
  IconType.xperson: IconData(
    iconPath: "assets/images/chat/xperson.png",
    title: "직장 내 고충",
  ),
  IconType.law: IconData(
    iconPath: "assets/images/chat/law.png",
    title: "체류 및 근로 자격",
  ),
  IconType.ambulance: IconData(
    iconPath: "assets/images/chat/ambulance.png",
    title: "산재 및 의료",
  ),
  IconType.edit2: IconData(
    iconPath: "assets/images/chat/edit2.png",
    title: "기타",
  ),
};
