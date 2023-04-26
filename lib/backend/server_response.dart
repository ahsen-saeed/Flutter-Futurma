class InfoModel {
  final int id;
  final String synopsis;
  final String yearsAired;
  final List<Creators>? creators;

  const InfoModel({required this.id, required this.synopsis, required this.yearsAired, this.creators});

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
        id: map['id'] ?? -1,
        synopsis: map['synopsis'] ?? '',
        yearsAired: map['yearsAired'] ?? '',
        creators: map.containsKey('creators') ? (map['creators'] as List).map((e) => Creators.fromMap(e)).toList() : null);
  }
}

class Creators {
  final String name;
  final String url;

  const Creators({required this.name, required this.url});

  factory Creators.fromMap(Map<String, dynamic> map) {
    return Creators(name: map['name'] ?? '', url: map['url'] ?? '');
  }
}

class CharactersModel {
  final Name name;
  final String gender, species, homePlanet, occupation, age;
  final int id;
  final List<String> sayings;

  final String images;

  const CharactersModel(
      {required this.name,
      required this.gender,
      required this.species,
      required this.homePlanet,
      required this.occupation,
      required this.age,
      required this.id,
      required this.sayings,
      required this.images});

  factory CharactersModel.fromMap(Map<String, dynamic> map) {
    final name = map.containsKey('name') ? Name.fromMap(map['name']) : Name.initial();
    final image = map.containsKey('images')
        ? (map['images'] as Map).containsKey('main')
            ? map['images']['main']
            : ''
        : '';
    return CharactersModel(
        name: name,
        gender: map['gender'] ?? '',
        species: map['species'] ?? '',
        homePlanet: map['homePlanet'] ?? '',
        occupation: map['occupation'] ?? '',
        age: map['age'] ?? '',
        id: map['id'] ?? -1,
        sayings: (map['sayings'] as List<dynamic>).map((e) => e.toString()).toList(),
        images: image);
  }
}

class Name {
  final String first, middle, last;

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(first: map['first'] ?? '', middle: map['middle'] ?? '', last: map['last'] ?? '');
  }

  static Name initial() => const Name(first: '', middle: '', last: '');

  const Name({required this.first, required this.middle, required this.last});
}

List<InfoModel> parserAllInfo(jsonMap) {
  final data = jsonMap;
  if (data == null || data.isEmpty) return <InfoModel>[];
  return (data as List).map((e) => InfoModel.fromMap(e)).toList();
}
List<CharactersModel> parserAllCharacters(jsonMap) {
  final data = jsonMap;
  if (data == null || data.isEmpty) return <CharactersModel>[];
  return (data as List).map((e) => CharactersModel.fromMap(e)).toList();
}
