//
//  ContentView.swift
//  The-Weather
//
//  Created by Петр Караиван on 04.02.2023.
//

import SwiftUI
struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            backGroundView(isNight: $isNight)
                VStack {
               cityTextView(cityName: "Comrat, MD")
                    
                    mainWheatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.snow.fill", temperature: -1)
                
                HStack(spacing: 18) {
                    ForEach(0 ..< 5) {
                        index in
                WeatherDayView(dayOfWeek:
                                ["Mon", "Tue", "Wed", "Thu", "Fri"][index],
                            imageName: ["cloud.snow.fill", "cloud.sleet.fill", "cloud.heavyrain.fill", "cloud.heavyrain.fill", "sun.dust.fill"][index],
                                temperature: [-1, 1, 10, 17, 18][index])
                    }
                    
                }
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    weatherButton(title: "Change Day Time",
                                  textColor: .blue,
                                  backGroungColor: .white)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 22,
                              weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,
                       height: 50)
            Text("\(temperature)°")
                .font(.system(size: 25,
                              weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct backGroundView: View {
    
    @Binding var  isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}

struct cityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(
                size: 32,
                weight: .medium,
                design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct mainWheatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,
                       height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70,
                              weight: .medium))
            
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 40)
    }
}

struct weatherButton: View {
    
    var title: String
    var textColor: Color
    var backGroungColor: Color
    
    var body: some View {
        Text(title)
            .font(.system(size: 25,
                          weight: .medium))
            .foregroundColor(textColor)
            .padding()
            .background(backGroungColor)
            .cornerRadius(20)
    }
}

