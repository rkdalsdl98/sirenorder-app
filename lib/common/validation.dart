enum ValidateType {
  email,
  pass,
  nickname,
}

Map<ValidateType, List<RegExp>> regsMap = {
  ValidateType.email: [
    RegExp(r"^[0-9a-zA-Zㄱ-ㅎ가-힣]{1,}@[a-zA-Z]{1,}.[a-zA-Z]{2,3}$")
  ],
  ValidateType.pass: [
    RegExp(r"[0-9a-zA-Z]{6,20}"),
    RegExp(r"[\!\`\~\@\#\$\%\^\&\*\_\+\=\/\>\<\?]{1,}"),
  ],
};

String _getIdentifier(String str) {
  switch (str) {
    case "email":
      return "이메일";
    case "pass":
      return "비밀번호";
    case "nickname":
      return "별명";
    default:
      return "none";
  }
}

String? match(ValidateType type, String? value) {
  final List<RegExp>? regs = regsMap[type];
  if (value == "" || value == null) {
    return "${_getIdentifier(type.name)}를(을) 입력해주세요!";
  } else if (regs == null) {
    return "존재하지 않는 검증방법 입니다.";
  }
  if (regs.every((reg) => reg.hasMatch(value))) {
    return null;
  }
  return "입력하신 정보를 한번 더 확인해주세요.";
}
