enum IconType { law, visa, translation }

class IconData {
  final String iconPath;
  final String title;

  IconData({required this.iconPath, required this.title});
}

final Map<IconType, IconData> initial_icons = {
  IconType.law: IconData(
    iconPath: "assets/images/chat/law.png",
    title: "법률",
  ),
  IconType.visa: IconData(
    iconPath: "assets/images/chat/visa.png",
    title: "비자",
  ),
  IconType.translation: IconData(
    iconPath: "assets/images/chat/translation.png",
    title: "생활 정보",
  ),
};
