String SPLASH_SCREEN = 'SPLASH_SCREEN';
String HOME_SCREEN = 'HOME_SCREEN';

String BASE_URL = 'http://192.168.8.107:8080/';

class Species {
  final int id;
  final String name;

  Species({required this.id, required this.name});
}

class Stage {
  final int id;
  final String name;

  Stage({required this.id, required this.name});
}

List<Species> SPECIES = [
  Species(id: 0, name: 'Acara'),
  Species(id: 1, name: 'Angel Fish'),
  Species(id: 2, name: 'Betta (Siamese Fighting Fish)'),
  Species(id: 3, name: 'Carp'),
  Species(id: 4, name: 'Flowerhorn Fish'),
  Species(id: 5, name: 'Gold Fish'),
  Species(id: 6, name: 'Guppy'),
  Species(id: 7, name: 'Neon Tetra'),
  Species(id: 8, name: 'Platy'),
  Species(id: 9, name: 'Rainbow Fish'),
  Species(id: 10, name: 'Swordtail'),
  Species(id: 11, name: 'Zebra Fish'),
  Species(id: 12, name: 'Cara')
];

List<Stage> STAGES = [
  Stage(id: 0, name: 'Breeding'),
  Stage(id: 1, name: 'Growing'),
  Stage(id: 2, name: 'Nursery'),
];
