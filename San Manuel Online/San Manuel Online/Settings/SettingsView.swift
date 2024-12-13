//
//  SettingsView.swift
//  San Manuel Online
//
//  Created by Dias Atudinov on 03.12.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: SettingsModel
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        TextWithBorder(text: "Settings", font: .custom(Fonts.mazzardM.rawValue, size: 55), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                            .textCase(.uppercase)
                        
                        Spacer()
                    }
                    HStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Image(.backBtn)
                                    .resizable()
                                    .scaledToFit()
                                
                            }.frame(height: 65)
                            
                        }
                        Spacer()
                    }.padding()
                }
                
                VStack(spacing: 30) {
                    ZStack {
                        
                        Image(.settingsBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                        
                        HStack(spacing: 16) {
                            TextWithBorder(text: "SOUND", font: .custom(Fonts.mazzardM.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 60:30), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                            Button {
                                settings.soundEnabled.toggle()
                            } label: {
                                if settings.soundEnabled {
                                    Image(.on)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                                } else {
                                    Image(.off)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                                }
                            }
                            
                        }
                    }
                   
                    ZStack {
                        
                        Image(.settingsBg)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 160:80)
                        HStack(spacing: 16) {
                            TextWithBorder(text: "MUSIC", font: .custom(Fonts.mazzardM.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 60:30), textColor: .mainYellow, borderColor: .mainBrown, borderWidth: 2)
                                .textCase(.uppercase)
                            Button {
                                settings.musicEnabled.toggle()
                            } label: {
                                if settings.musicEnabled {
                                    Image(.on)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                                } else {
                                    Image(.off)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                                }
                            }
                        }
                    }.padding(.bottom, 50)
                   
                }
                
                Spacer()
            }
        }.background(
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
}

#Preview {
    SettingsView(settings: SettingsModel())
}
