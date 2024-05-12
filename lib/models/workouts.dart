class Workouts {
  late String muscle;
  late String workout;
  late String difficulty;
  late String sets;
  //late String reps;
  late String equipment;
  late String explanation;
  late String video;

  Workouts.fromJson(Map<String, dynamic> json) {
    muscle = json["Muscles"];
    workout = json["WorkOut"];
    difficulty = json["Intensity_Level"];
    sets = json["Beginner Sets"];
    //reps = json[""];
    //equipment = json["Equipment"];
    explanation = json["Explaination"];
    video = json["Video"];
  }
}