//
//  widget.swift
//  widget
//
//  Created by 권혁준 on 2023/11/10.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    // 처음으로 위젯을 표시할 때
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date:Date(), mRound: 1, mLotto: [1,2,3,4,5,6], configuration: ConfigurationIntent())
    }

    // 위젯이 일시적인 상황에 나타날 때
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date:Date(), mRound: 1, mLotto: [1,2,3,4,5,6], configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let no = SQLiteService.selectMaxNo() + 1
            let lotto = LottoScript.GenerateLottoNumberList(round: no, count: 1)[0]
            let entry = SimpleEntry(date:entryDate, mRound: no, mLotto: lotto, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let mRound : Int
    @State var mLotto: [Int]
    let configuration: ConfigurationIntent
}

struct widgetEntryView : View {
    var entry: Provider.Entry
        
    var body: some View {
        VStack {
            HStack {
                Text("\(entry.mRound)회 번호추천")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 16))
                Spacer()
            }
            .padding(.horizontal, 16)
            Spacer()
            HStack(alignment:.center, spacing: 4) {
                Text("\(entry.mLotto[0])")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 11))
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .background(Circle().fill(backgroundColor(num: entry.mLotto[0])))
                Text("\(entry.mLotto[1])")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 11))
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .background(Circle().fill(backgroundColor(num: entry.mLotto[1])))
                Text("\(entry.mLotto[2])")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 11))
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .background(Circle().fill(backgroundColor(num: entry.mLotto[2])))
                Text("\(entry.mLotto[3])")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 11))
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .background(Circle().fill(backgroundColor(num: entry.mLotto[3])))
                Text("\(entry.mLotto[4])")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 11))
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .background(Circle().fill(backgroundColor(num: entry.mLotto[4])))
                Text("\(entry.mLotto[5])")
                    .bold()
                    .foregroundColor(Color.black)
                    .font(Font.system(size: 11))
                    .frame(width: 16, height: 16, alignment: .center)
                    .padding(14)
                    .background(Circle().fill(backgroundColor(num: entry.mLotto[5])))

            }
            .padding(.horizontal, 8)
            Spacer()
            Button(action: {
                print("action!")

            }) {
                HStack(alignment:.center, spacing: 4) {
                    Image(systemName: "house.circle")
                    Text("더 많은 번호 추천받기 >")
                        .font(Font.system(size: 12))
                }
                .frame(width: 180, height: 32, alignment: .center)
                .foregroundColor(Color.black)
                .background(Capsule().strokeBorder(Color.black))
            }
        }
        .padding(.vertical, 16)
    }
    
    private func backgroundColor(num: Int) -> Color {
        switch num {
        case 1...10:
            return Color.yellow
        case 11...20:
            return Color.blue            
        case 21...30:
            return Color.pink
        case 31...40:
            return Color.gray
        case 41...45:
            return Color.green
        default:
            return Color.yellow
        }
    }
    
    private func update() {
        entry.mLotto = LottoScript.GenerateLottoNumberList(round: entry.mRound, count: 1)[0]
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("로또스탯")
        .description("간단하게 추천번호를 받을 수 있습니다.")
    }
}

struct widget_Previews: PreviewProvider {
    static var previews: some View {
        widgetEntryView(entry: SimpleEntry(date: Date(), mRound: 1, mLotto: [41,42,43,44,45,46], configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
