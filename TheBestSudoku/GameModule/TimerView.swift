//
// TimerView.swift
// TheBestSudoku


import SwiftUI

struct TimerView: View {
    @State var startDate: Date
    @State var timeElapsed: Int = 0
    @Binding var time: Int
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(time: Binding<Int>) {
        // Инициализация `timeElapsed` из ранее сохраненного значения `time`
        _timeElapsed = State(initialValue: time.wrappedValue)
        _time = time
        
        // Вычисление `startDate`, чтобы учесть ранее прошедшее время
        _startDate = State(initialValue: Date.now.addingTimeInterval(TimeInterval(-time.wrappedValue)))
    }
    
    var body: some View {
        getTime(timeElapsed)
            .onReceive(timer, perform: { firedDate in
                timeElapsed = Int(firedDate.timeIntervalSince(startDate))
                time = timeElapsed
            })
            .onAppear {
                print("TIME: ", time)
            }
    }
    
    func getTime(_ time: Int) -> Text {
        let minutes = time / 60
        let seconds = time % 60
        
        // Форматирование строки времени
        let formattedTime = String(format: "%d:%02d", minutes, seconds)
        
        if #available(iOS 17, *) {
            return Text(formattedTime).foregroundStyle(Color.specialBlue)
        } else {
            return Text(formattedTime).foregroundColor(Color.specialBlue)
        }
    }
}


//#Preview {
//    TimerView()
//}
