String addComma(int number) {
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  mathFunc(Match match) => '${match[1]},';
  return "$number".replaceAllMapped(reg, mathFunc);
}
