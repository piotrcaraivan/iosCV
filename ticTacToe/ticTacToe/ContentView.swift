//
//  ContentView.swift
//  ticTacToe
//
//  Created by Петр Караиван on 09.02.2023.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    let viewMonths: [viewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 55221),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 59874),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 72854),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 123375),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 293254),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 593745),
        .init(date: Date.from(year: 2023, month: 7, day: 1), viewCount: 368345),
        .init(date: Date.from(year: 2023, month: 8, day: 1), viewCount: 439854),
        .init(date: Date.from(year: 2023, month: 9, day: 1), viewCount: 759034),
        .init(date: Date.from(year: 2023, month: 10, day: 1), viewCount: 865945),
        .init(date: Date.from(year: 2023, month: 11, day: 1), viewCount: 994564),
        .init(date: Date.from(year: 2023, month: 12, day: 1), viewCount: 238546),
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            Text("Youtube Views")
            
            Text("Total: \(viewMonths.reduce(0, { $0 + $1.viewCount }))")
                .fontWeight(.semibold)
                .font(.footnote)
                .foregroundColor(.secondary)
                .padding(.bottom, 12)
            
            Chart {
                RuleMark(y: .value("Goal", 500000))
                    .foregroundStyle(Color.blue)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [8]))
              //      .annotation(alignment: .leading)  {
                //        Text("Goal")
                  //          .font(.caption)
                    //        .foregroundColor(.secondary)
                        
                   // }
                
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount)
                    )
                    .foregroundStyle(Color.mint.gradient)
                    .cornerRadius(4)
                }
                
            }
            .frame(height: 200)
            .chartXAxis {
                AxisMarks(values: viewMonths.map { $0.date }) { date in
                    AxisValueLabel(format: .dateTime.month(.narrow),centered: true)
                }
            }
            .chartYAxis {
                AxisMarks { mark in
                    AxisValueLabel()
                    AxisGridLine()
                }
            }
            .padding(.bottom)
         //   .chartYScale(domain: 0...2_000_000)
        //    .chartXAxis(.hidden)
        //    .chartYAxis(.hidden)
        //    .chartPlotStyle { plotContent in
        //        plotContent
        //            .background(.white.gradient.opacity(0.6))
        //           .border(.black, width: 0)
        // }
            
            HStack {
                Image(systemName: "line.diagonal")
                    .rotationEffect(Angle(degrees: 45))
                    .foregroundColor(.blue)
                
                Text("Monthly Goal")
                    .foregroundColor(.secondary)
            }
            .font(.caption2)
            .padding(.leading, 4)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct viewMonth: Identifiable {
    let id =  UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
