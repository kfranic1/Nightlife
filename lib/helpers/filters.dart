import '../model/club.dart';

abstract class BaseFilter {
  String get name;
  void applyFilter(List<Club> clubs);
  static List<BaseFilter> filters = [DefaultFilter(), AlphabeticalFilter(), ScoreFilter(), DateFilter()];
}

class DefaultFilter extends BaseFilter {
  @override
  String get name => "Default";
  @override
  void applyFilter(List<Club> clubs) => clubs;
}

class AlphabeticalFilter extends BaseFilter {
  @override
  String get name => "Alphabetical";
  @override
  void applyFilter(List<Club> clubs) => clubs.sort((a, b) => a.name.compareTo(b.name));
}

class ScoreFilter extends BaseFilter {
  @override
  String get name => "Score";
  @override
  void applyFilter(List<Club> clubs) => clubs.sort((a, b) => b.score.compareTo(a.score));
}

class DateFilter extends BaseFilter {
  @override
  String get name => "Last Review";
  @override
  void applyFilter(List<Club> clubs) => clubs.sort((a, b) => b.review.date.compareTo(a.review.date));
}
