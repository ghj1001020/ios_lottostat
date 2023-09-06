//
//  appwidget.swift
//  appwidget
//
//  Created by 권혁준 on 2022/03/28.
//

import WidgetKit
import SwiftUI
import Intents

// 위젯을 업데이트할 시기를 위젯킷에 알려줌
struct Provider: TimelineProvider {
    
    // 현재 상태 나타내는 스냅샷
    func getSnapshot(in context: Context, completion: @escaping (WidgetTimelineEntry) -> Void) {
        let entry = WidgetTimelineEntry(date: Date())
        completion(entry)
    }

    // 미래날짜가 포함된 타임라인 엔트리 배열
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetTimelineEntry>) -> Void) {
        var entries : [WidgetTimelineEntry] = []

        let entryDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let entry = WidgetTimelineEntry(date: entryDate)
        entries.append(entry)
                
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> WidgetTimelineEntry {
        WidgetTimelineEntry(date: Date())
    }
}

struct WidgetTimelineEntry: TimelineEntry {
    let date: Date  // 위젯 렌더링할 Date
}

struct appwidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text("로또스탯 위젯")
    }
}

@main
struct appwidget: Widget {
    let kind: String = "com.ghj.lottostat.appwidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { (entry) in
            appwidgetEntryView(entry: entry)
        }
        .configurationDisplayName("로또스탯")
        .description("LottoStat Widget")
        .supportedFamilies([.systemMedium])
    }
}

struct appwidget_Previews: PreviewProvider {
    static var previews: some View {
        appwidgetEntryView(entry: WidgetTimelineEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
