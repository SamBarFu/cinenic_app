class Series {
  List<Serie> items = List();

  Series();

  Series.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final serie = Serie.fromJsonMap(item);
      items.add(serie);
    }
  }
}

class Serie {
  String posterPath;
  double popularity;
  int id;
  String backdropPath;
  double voteAverage;
  String overview;
  String firstAirDate;
  List<dynamic> originCountry;
  List<int> genreIds;
  String originalLanguage;
  int voteCount;
  String name;
  String originalName;

  Serie({
    this.posterPath,
    this.popularity,
    this.id,
    this.backdropPath,
    this.voteAverage,
    this.overview,
    this.firstAirDate,
    this.originCountry,
    this.genreIds,
    this.originalLanguage,
    this.voteCount,
    this.name,
    this.originalName,
  });

  Serie.fromJsonMap(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    popularity = json['popularity'] / 1;
    id = json['id'];
    backdropPath = json['backdrop_path'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    firstAirDate = json['first-air-date'];
    originCountry = json['origin_country'];
    genreIds = json['genre_ids'].cast<int>();
    originalLanguage = json['original_language'];
    voteCount = json['vote_count'];
    name = json['name'];
    originalName = json['original_name'];
  }

  String getPosterImage() {
    if (posterPath == null) {
      return 'assets/img/no-image.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }
}
