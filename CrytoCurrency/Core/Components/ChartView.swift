//
//  ChartView.swift
//  CrytoCurrency
//
//  Created by Gagan Vishal  on 2023/02/01.
//

import SwiftUI

struct ChartView: View {
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startDate: Date
    private let lastDate: Date
    @State var percentage: CGFloat = 0.0
    
    init(coin: CryptoModel) {
        data = coin.sparklineIn7D.price
        maxY = data.max() ?? 0.0
        minY = data.min() ?? 0.0
        
        let priceChhange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChhange > 0 ? Color.green :  Color.red
        
        lastDate = coin.lastUpdated.findLastupdateDate()
        startDate = lastDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chart
                .frame(height: 200)
                .background(
                    chartBackground
                )
                .overlay(
                    chartPriceInfoView
                    ,alignment: .leading
            )
            dateLabels
        }
        .foregroundColor(Color.gray)
        .onAppear{
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) {
                withAnimation(.linear(duration: 2.0)) {
                    percentage =  1.0
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    private var chart: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    let yPosition = ( 1 - ((data[index] -  minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 5.0)
            .shadow(color: lineColor.opacity(0.6), radius: 10, x: 0.0, y: 20.0)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30.0)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40.0)
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartPriceInfoView: some View {
        VStack {
            Text(maxY.formatNumber())
            Spacer()
            Text(((maxY +  minY) / 2).formatNumber())
            Spacer()
            Text(minY.formatNumber())
        }
        .font(.headline)
    }
    
    private var dateLabels: some View {
        HStack {
            Text(startDate.getHumanReadableDate())
            Spacer()
            Text(lastDate.getHumanReadableDate())
        }
        .padding(.leading, 4)
        .padding(.trailing, 4)
    }
}
