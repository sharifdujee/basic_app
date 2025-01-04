class Event {
  final String? imagePath,
      title,
      description,
      location,
      duration,
      punchline1,
      punchline2;
  final List<int>? categoryIds;
  final List<String>? galleryImages;
  final DateTime? date;
  final int? numberOfParticipant;

  Event({
    this.imagePath,
    this.title,
    this.description,
    this.location,
    this.duration,
    this.punchline1,
    this.punchline2,
    this.categoryIds,
    this.galleryImages,
    this.date,
    this.numberOfParticipant

  });

  // Static list of Event objects
  static final List<Event> events = [
    Event(
      imagePath: 'assets/event_image/5_km_downtown_run.jpeg',
      title: '5 Kilometers downTown run',
      description: '',
      location: 'Pleasant park',
      duration: '3h',
      punchline1: 'Marathon',
      punchline2: 'The latest fad in padology, get the insight',
      categoryIds: [0, 1],
      galleryImages: ['assets/event_image/cooking_2.jpeg', 'assets/event_image/cooking_3.jpeg'],
      date: DateTime(2025, 01, 18),
      numberOfParticipant: 50
    ),
    Event(
      imagePath: 'assets/event_image/cooking_1.jpeg',
      title: 'Graintee Cooking Event',
      description: 'Guest list fill up fast so be sure to apply before handto secure a spot.',
      location: 'Pleasant park',
      duration: '3h',
      punchline1: 'Cooking',
      punchline2: 'Discover the joy of cooking with grains',
      categoryIds: [0, 2],
      galleryImages: ['assets/event_image/cooking_2.jpeg', 'assets/event_image/cooking_3.jpeg'],
      date: DateTime(2025, 01, 25),
        numberOfParticipant: 150

    ),
    Event(
      imagePath: 'assets/event_image/music_concert.jpeg',
      title: 'Arijit Music Concert',
      description: '',
      location: 'Pleasant park',
      duration: '3h',
      punchline1: 'Music',
      punchline2: 'Enjoy soulful music by Arijit Singh',
      categoryIds: [0, 1],
      galleryImages: ['assets/event_image/cooking_2.jpeg', 'assets/event_image/cooking_3.jpeg'],
      date: DateTime(2025, 02, 09),
        numberOfParticipant: 500
    ),
    Event(
      imagePath: 'assets/event_image/golf_competition.jpeg',
      title: 'Season 2 Golf Estate',
      description: '',
      location: 'Pleasant park',
      duration: '3h',
      punchline1: 'Golf',
      punchline2: 'Experience the thrill of the golf season',
      categoryIds: [0, 3],
      galleryImages: ['assets/event_image/cooking_2.jpeg', 'assets/event_image/cooking_3.jpeg'],
      date: DateTime(2025, 03, 18),
        numberOfParticipant: 30
    ),
  ];

}
