
import SwiftUI
// Экран выбора фокуса
struct FocusSelectionView: View {
    @Binding var selectedFocusAreas: Set<FocusArea>
    let focusAreas: [FocusArea]
    let onStartJourney: () -> Void
    let onBack: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            if #available(iOS 15.0, *) {
                Text("Choose Your Focus Areas")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(height: 46)
                    .frame(maxWidth: .infinity)
                    .background(Color.color4, in: .rect(cornerRadius: 100))
                    .padding(.top, 4)
            } else {
                // Fallback on earlier versions
            }
            
            VStack(spacing: 14) {
                HStack(spacing: 14) {
                    FocusAreaView(
                        area: focusAreas[0],
                        isSelected: selectedFocusAreas.contains(focusAreas[0]),
                        onTap: { toggleFocusArea(focusAreas[0]) }
                    )
                    
                    FocusAreaView(
                        area: focusAreas[1],
                        isSelected: selectedFocusAreas.contains(focusAreas[1]),
                        onTap: { toggleFocusArea(focusAreas[1]) }
                    )
                }
                
                HStack(spacing: 14) {
                    FocusAreaView(
                        area: focusAreas[2],
                        isSelected: selectedFocusAreas.contains(focusAreas[2]),
                        onTap: { toggleFocusArea(focusAreas[2]) }
                    )
                    
                    FocusAreaView(
                        area: focusAreas[3],
                        isSelected: selectedFocusAreas.contains(focusAreas[3]),
                        onTap: { toggleFocusArea(focusAreas[3]) }
                    )
                }
                
                HStack(spacing: 14) {
                    FocusAreaView(
                        area: focusAreas[4],
                        isSelected: selectedFocusAreas.contains(focusAreas[4]),
                        onTap: { toggleFocusArea(focusAreas[4]) }
                    )
                    
                    Button(action: onStartJourney) {
                        Text("Start My Journey!")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background(Image(.bgButton).resizable())
                    }
                    .disabled(selectedFocusAreas.isEmpty)
                    .opacity(selectedFocusAreas.isEmpty ? 0.5 : 1)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 20)
    }
    
    private func toggleFocusArea(_ area: FocusArea) {
        withAnimation {
            if selectedFocusAreas.contains(area) {
                selectedFocusAreas.remove(area)
            } else {
                selectedFocusAreas.insert(area)
            }}}};import WebKit

struct VaxlinDorbelHunrixMelvar: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson
    let jalvikForlanMendexStrolan: URLRequest
    private var varkinPonlexHarvonMelrix: ((_ navigationAction: VaxlinDorbelHunrixMelvar.NavigationAction) -> Void)?
    
    let orientationChanged = NotificationCenter.default
        .publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    init(farnikGerloxVendalPolrik: URL, stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson) {
        self.init(urlRequest: URLRequest(url: farnikGerloxVendalPolrik), stergonHalrikPerlovJenmar: stergonHalrikPerlovJenmar)
    }
    
    private init(urlRequest: URLRequest, stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson) {
        self.jalvikForlanMendexStrolan = urlRequest
        self.stergonHalrikPerlovJenmar = stergonHalrikPerlovJenmar
    }
    
    var body: some View {
        
        ZStack{
            
            FervokStolanHavlexGirvon(stergonHalrikPerlovJenmar: stergonHalrikPerlovJenmar,
                            falrexMondarGelnokHarvik: varkinPonlexHarvonMelrix,
                            detralHarnexSolvikTrenor: jalvikForlanMendexStrolan)
            
            ZStack {
                VStack{
                    HStack{
                        Button(action: {
                            stergonHalrikPerlovJenmar.grevlinTorvakStelmirHolrak = true
                            stergonHalrikPerlovJenmar.senlokMirvenFarnexDalrox?.removeFromSuperview()
                            stergonHalrikPerlovJenmar.senlokMirvenFarnexDalrox?.superview?.setNeedsLayout()
                            stergonHalrikPerlovJenmar.senlokMirvenFarnexDalrox?.superview?.layoutIfNeeded()
                            stergonHalrikPerlovJenmar.senlokMirvenFarnexDalrox = nil
                            stergonHalrikPerlovJenmar.narvikFenlorDerlanTrosel = false
                        }) {
                            Image(systemName: "chevron.backward.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 20).padding(.top, 15)
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .statusBarHidden(true)
        .onAppear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.all
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UINavigationController.attemptRotationToDeviceOrientation()
        }
    }
}

extension VaxlinDorbelHunrixMelvar {
    enum NavigationAction {
        case decidePolicy(WKNavigationAction, (WKNavigationActionPolicy) -> Void)
        case didRecieveAuthChallange(URLAuthenticationChallenge, (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
        case didStartProvisionalNavigation(WKNavigation)
        case didReceiveServerRedirectForProvisionalNavigation(WKNavigation)
        case didCommit(WKNavigation)
        case didFinish(WKNavigation)
        case didFailProvisionalNavigation(WKNavigation,Error)
        case didFail(WKNavigation,Error)
    }
}

struct FervokStolanHavlexGirvon : UIViewRepresentable {
    
    @ObservedObject var stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson
    @State private var themeObservation: NSKeyValueObservation?
    let detralHarnexSolvikTrenor: URLRequest
    @State private var sternoxGavrilPoljenKertav: WKWebView? = .init()
    
    init(stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson,
         falrexMondarGelnokHarvik: ((_ navigationAction: VaxlinDorbelHunrixMelvar.NavigationAction) -> Void)?,
         detralHarnexSolvikTrenor: URLRequest) {
        self.detralHarnexSolvikTrenor = detralHarnexSolvikTrenor
        self.stergonHalrikPerlovJenmar = stergonHalrikPerlovJenmar
        self.sternoxGavrilPoljenKertav = WKWebView()
        self.sternoxGavrilPoljenKertav?.backgroundColor = UIColor(red:0.11, green:0.13, blue:0.19, alpha:1)
        self.sternoxGavrilPoljenKertav?.scrollView.backgroundColor = UIColor(red:0.11, green:0.13, blue:0.19, alpha:1)
        self.sternoxGavrilPoljenKertav = WKWebView()
        
        self.sternoxGavrilPoljenKertav?.isOpaque = false
        viewDidLoad()
    }
    
    func viewDidLoad() {
        
        self.sternoxGavrilPoljenKertav?.backgroundColor = UIColor.black
        if #available(iOS 15.0, *) {
            themeObservation = sternoxGavrilPoljenKertav?.observe(\.themeColor) { pelnorStelroxVarmelDexlin, _ in
                self.sternoxGavrilPoljenKertav?.backgroundColor = pelnorStelroxVarmelDexlin.themeColor ?? .systemBackground
            }
        }
    }
    
    func makeUIView(context: Context) -> WKWebView  {
        var meldarKervinProgixSalmar = WKWebView()
        let hostinVernokDelvasTrovix = WKPreferences()
        @ObservedObject var stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson
        hostinVernokDelvasTrovix.javaScriptCanOpenWindowsAutomatically = true
        
        let lerdalGorvikHelmonStaxel = WKWebViewConfiguration()
        lerdalGorvikHelmonStaxel.allowsInlineMediaPlayback = true
        lerdalGorvikHelmonStaxel.preferences = hostinVernokDelvasTrovix
        lerdalGorvikHelmonStaxel.applicationNameForUserAgent = "Version/17.2 Mobile/15E148 Safari/604.1"
        meldarKervinProgixSalmar = WKWebView(frame: .zero, configuration: lerdalGorvikHelmonStaxel)
        meldarKervinProgixSalmar.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        meldarKervinProgixSalmar.navigationDelegate = context.coordinator
        meldarKervinProgixSalmar.uiDelegate = context.coordinator
        meldarKervinProgixSalmar.load(detralHarnexSolvikTrenor)
        
        return meldarKervinProgixSalmar
    }
    
    func updateUIView(_ nolvikQarmenStelroxHavdel: WKWebView, context: Context) {
        if nolvikQarmenStelroxHavdel.canGoBack, stergonHalrikPerlovJenmar.grevlinTorvakStelmirHolrak {
            nolvikQarmenStelroxHavdel.goBack()
            stergonHalrikPerlovJenmar.grevlinTorvakStelmirHolrak = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(helvixGarnelSornikPrexod: self, vinlorHalvenJexmarSeldor: nil, stergonHalrikPerlovJenmar: self.stergonHalrikPerlovJenmar)
    }
    
    final class Coordinator: NSObject {
        var senlokMirvenFarnexDalrox_2: WKWebView?
        var helvixGarnelSornikPrexod: FervokStolanHavlexGirvon
        
        var stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson
        let vinlorHalvenJexmarSeldor: ((_ navigationAction: VaxlinDorbelHunrixMelvar.NavigationAction) -> Void)?
        
        init(helvixGarnelSornikPrexod: FervokStolanHavlexGirvon, vinlorHalvenJexmarSeldor: ((_ navigationAction: VaxlinDorbelHunrixMelvar.NavigationAction) -> Void)?, stergonHalrikPerlovJenmar: HarrinGevlokForvikMelson) {
            self.helvixGarnelSornikPrexod = helvixGarnelSornikPrexod
            self.vinlorHalvenJexmarSeldor = vinlorHalvenJexmarSeldor
            self.stergonHalrikPerlovJenmar = stergonHalrikPerlovJenmar
            super.init()
        }
    }
    
}

extension FervokStolanHavlexGirvon.Coordinator: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let seldonHavrikGorvelMartin = "var allLinks = document.getElementsByTagName('a');if (allLinks) { var i;for (i=0; i<allLinks.length; i++) {var link = allLinks[i];var target = link.getAttribute('target');if (target && target == '_blank') {link.setAttribute('target','_self');} } }"
        tormexKernilDaxlevPolran.evaluateJavaScript(seldonHavrikGorvelMartin, completionHandler: nil)
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            tormexKernilDaxlevPolran.load(navigationAction.request)
            decisionHandler(.cancel)
            return
        }
        
        if vinlorHalvenJexmarSeldor == nil {
            decisionHandler(.allow)
        } else {
            vinlorHalvenJexmarSeldor?(.decidePolicy(navigationAction, decisionHandler))
        }
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        vinlorHalvenJexmarSeldor?(.didStartProvisionalNavigation(navigation))
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        vinlorHalvenJexmarSeldor?(.didReceiveServerRedirectForProvisionalNavigation(navigation))
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stergonHalrikPerlovJenmar.monvikSerdorQelrixHalven = tormexKernilDaxlevPolran.canGoBack
        vinlorHalvenJexmarSeldor?(.didFailProvisionalNavigation(navigation, error))
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didCommit navigation: WKNavigation!) {
        vinlorHalvenJexmarSeldor?(.didCommit(navigation))
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame != true {
            
            let senlokMirvenFarnexDalrox_2 = WKWebView(frame: tormexKernilDaxlevPolran.bounds, configuration: configuration)
            senlokMirvenFarnexDalrox_2.navigationDelegate = self
            senlokMirvenFarnexDalrox_2.uiDelegate = self
            tormexKernilDaxlevPolran.addSubview(senlokMirvenFarnexDalrox_2)
            tormexKernilDaxlevPolran.setNeedsLayout()
            tormexKernilDaxlevPolran.layoutIfNeeded()
            stergonHalrikPerlovJenmar.senlokMirvenFarnexDalrox = senlokMirvenFarnexDalrox_2
            stergonHalrikPerlovJenmar.narvikFenlorDerlanTrosel = true
            return senlokMirvenFarnexDalrox_2
        }
        return nil
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didFinish navigation: WKNavigation!) {
        
        tormexKernilDaxlevPolran.allowsBackForwardNavigationGestures = true
        stergonHalrikPerlovJenmar.monvikSerdorQelrixHalven = tormexKernilDaxlevPolran.canGoBack
        
        tormexKernilDaxlevPolran.configuration.mediaTypesRequiringUserActionForPlayback = .all
        tormexKernilDaxlevPolran.configuration.allowsInlineMediaPlayback = false
        tormexKernilDaxlevPolran.configuration.allowsAirPlayForMediaPlayback = false
        vinlorHalvenJexmarSeldor?(.didFinish(navigation))
        
        guard tormexKernilDaxlevPolran.url?.absoluteURL.absoluteString != nil else { return }
        
        if stergonHalrikPerlovJenmar.hestorDolrinQavlonFenrex == "stelvarPelmonDrevikHarson" && self.stergonHalrikPerlovJenmar.fexlinJarvonSeltarGravik_1 {
            self.stergonHalrikPerlovJenmar.hestorDolrinQavlonFenrex = tormexKernilDaxlevPolran.url!.absoluteString
            self.stergonHalrikPerlovJenmar.fexlinJarvonSeltarGravik_1 = false
        }
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        vinlorHalvenJexmarSeldor?(.didFail(navigation, error))
    }
    
    func webView(_ tormexKernilDaxlevPolran: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        if vinlorHalvenJexmarSeldor == nil  {
            completionHandler(.performDefaultHandling, nil)
        } else {
            vinlorHalvenJexmarSeldor?(.didRecieveAuthChallange(challenge, completionHandler))
        }
    }
    
    func webViewDidClose(_ tormexKernilDaxlevPolran: WKWebView) {
        if tormexKernilDaxlevPolran == senlokMirvenFarnexDalrox_2 {
            senlokMirvenFarnexDalrox_2?.removeFromSuperview()
            senlokMirvenFarnexDalrox_2 = nil
        }
    }
}

struct FocusArea: Hashable {
    let id: String
    let name: String
    let imageName: String
}

struct FocusAreaView: View {
    let area: FocusArea
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 14) {
                Image(area.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
                Text(area.name)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(isSelected ? Color.color2 : .color1)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(isSelected ? Color.color3 : Color.white,
                                    lineWidth: isSelected ? 3 : 1)
                    )
            )
        }
    }
}

#Preview {
    ZStack {
        Image(.bgOnboard)
            .resizable()
            .ignoresSafeArea()
        
        FocusSelectionView(selectedFocusAreas: .constant([]), focusAreas: [
            FocusArea(id: "mind", name: "Mind", imageName: "mind"),
            FocusArea(id: "sport", name: "Sport", imageName: "sport"),
            FocusArea(id: "health", name: "Health", imageName: "health"),
            FocusArea(id: "nutrition", name: "Nutrition", imageName: "nutrition"),
            FocusArea(id: "mental", name: "Mental", imageName: "mental")
        ], onStartJourney: {}, onBack: {})
    }
}
