//
//  CalendarPageView.swift
//  DreamHub
//
//  Created by Yi Ling on 6/27/25.
//

import SwiftUI
import ElegantCalendar

struct CalendarPageView: View, ElegantCalendarDataSource, ElegantCalendarDelegate {
    @ObservedObject var coreAppModel: CoreAppModel
    @StateObject private var calendarManager: ElegantCalendarManager

    init(coreAppModel: CoreAppModel) {
        self.coreAppModel = coreAppModel
        let cal = Calendar.current
        let start = cal.date(byAdding: .year, value: -10, to: .now)!
        let end   = cal.date(byAdding: .year, value:  10, to: .now)!

        let config = CalendarConfiguration(startDate: start, endDate: end)
        _calendarManager = StateObject(
          wrappedValue: ElegantCalendarManager(
            configuration: config,
            initialMonth: .now
          )
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.craftBrown.opacity(0.5)
                    .ignoresSafeArea()

                ElegantCalendarView(calendarManager: calendarManager)
                    .padding(.top, 50)
                    .onAppear {
                          calendarManager.datasource = self
                          calendarManager.delegate   = self
                        }
            }
        }
    }

    // ─── Data-Source Methods ──────────────────────

    // 1️⃣ which days get a colored dot
    func calendar(backgroundColorOpacityForDate date: Date) -> Double {
        return 1   // full opacity on every date
    }

    // 2️⃣ which days can be tapped
    func calendar(canSelectDate date: Date) -> Bool {
        return true
    }

    // 3️⃣ the “accessory” view under the grid
    func calendar(viewForSelectedDate date: Date, dimensions size: CGSize) -> AnyView {
        AnyView(
          VStack(alignment: .leading, spacing: 12) {
            DreamsListView(coreAppModel: coreAppModel, date: date)
          }
          .padding()
          .frame(width: size.width, height: size.height, alignment: .topLeading)
        )
    }
}

