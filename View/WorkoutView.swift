////
////  WorkoutView.swift
////  MyApplication
////
////
//
import SwiftUI




struct WorkoutView: View {
    let workout: Workout
    @Environment(\.dismiss) private var dismiss
    @State var isActive = false

    var body: some View {
        NavigationView {
            List {
                ForEach(workout.exercises) { exercise in
                    DisclosureGroup(exercise.exercisestat.exercisenamestatic){
                        VStack(alignment: .leading, spacing: 16) {
                            ExerciseWorkoutCell(exercise: exercise)

                            ForEach(0..<exercise.sets.count) { index in
                                let set = exercise.sets[index]
                                HStack {
                                    Text("Set \(index + 1):")

                                    Spacer()

                                    Text("\(set.reps) reps, \(String(format: "%.1f", set.weight)) kg")
                                        .foregroundColor(.secondary)
                                }
                                .padding(.horizontal, 16)
                            }

                            HStack {
                                Text("Rest time:")

                                Spacer()

                                Text(String(format: "%02d:%02d", exercise.min, exercise.sec))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle(workout.workoutname)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: NavigationLink(destination: PlayView(workoutindex: workout.id, exerciseindex: 0).navigationBarBackButtonHidden(true)) {
                    Image(systemName: "play").foregroundColor(.green)
                }
            )
        }.accentColor(.green)
    }
}




struct ExerciseWorkoutCell:View {
    let exercise: Exercise

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            GifImage(exercise.exercisestat.image)
                .frame(width: 80, height: 80)

            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.exercisestat.exercisenamestatic)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()

                HStack {
                    Text(exercise.exercisestat.bodypart.rawValue)
                        .font(.footnote)
                        .foregroundColor(.secondary)

                    Spacer()

                    Text("\(exercise.sets.count) sets")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(
            Color.gray.opacity(0.2)
                .cornerRadius(10)
        )
    }
}


struct WorkoutView_Previews: PreviewProvider {


    static var previews: some View {
        let exercisestatic = ExerciseStatic(exercisenamestatic: "nome", description: "descrizione", bodypart: Bodyparts.back, image: "Panca")
        let arrayExercise = [Exercise(exercisestat: exercisestatic)]
        var dates = [Date.now]
        WorkoutView(workout: Workout(id: 1,workoutname: "Nome workout", exercises: arrayExercise, creationdate: Date.now, date: dates,exerciseTime: DateComponents()))
    }
}

