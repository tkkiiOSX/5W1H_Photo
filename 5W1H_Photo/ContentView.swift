//
//  ContentView.swift
//  5W1H_Photo
//
//  Created by Xcode2021 on 2021/08/09.
//

import SwiftUI

struct pkrView: View {
    @Binding var jyo: Int

    var body: some View {
        Picker(selection: $jyo, label: Text("Picker")
                ) {
            Text("Before：前").tag(1)
            Text("During：中").tag(2)
            Text("After：後").tag(3)

        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(height: 20)
        .padding()
        .background(Color(red: 1.0, green: 1.0, blue: 1.0))
        .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 10, y: 10)
    }
}
struct txtField: View {
    @Binding var bpn1: String
    @Binding var bpn2: String
    @Binding var bpn3: String
    @Binding var bpn4: String
    @Binding var bpn5: String

    var body: some View {
        HStack {
            Text("Where：どこで")
                .frame(width: 250, alignment: .leading)
            TextField("Where：どこで", text: $bpn1)
                    .frame(height: 25, alignment: .center)
                    .padding(.all, 5)
                    .border(Color.black)
                    .padding(.all, 5)
                    .foregroundColor(.black)
                    .colorMultiply(.gray)
                    .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 10, y: 10)
        }
        HStack {
            Text("Who：だれが")
                .frame(width: 250, alignment: .leading)
            TextField("Who：だれが", text: $bpn2)
                .frame(height: 25, alignment: .center)
                .padding(.all, 5)
                .border(Color.black)
                .padding(.all, 5)
                .foregroundColor(.black)
                .colorMultiply(.gray)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 10, y: 10)
        }
        HStack {
            Text("What：何を")
                .frame(width: 250, alignment: .leading)
            TextField("What：何を", text: $bpn3)
                .frame(height: 25, alignment: .center)
                .padding(.all, 5)
                .border(Color.black)
                .padding(.all, 5)
                .foregroundColor(.black)
                .colorMultiply(.gray)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 10, y: 10)
        }
        HStack {
            Text("Why：なぜ")
                .frame(width: 250, alignment: .leading)
            TextField("Why：なぜ", text: $bpn4)
                .frame(height: 25, alignment: .center)
                .padding(.all, 5)
                .border(Color.black)
                .padding(.all, 5)
                .foregroundColor(.black)
                .colorMultiply(.gray)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 10, y: 10)
        }
        HStack {
            Text("How：どのように")
                .frame(width: 250, alignment: .leading)
            TextField("How：どのように", text: $bpn5)
                .frame(height: 25, alignment: .center)
                .padding(.all, 5)
                .border(Color.black)
                .padding(.all, 5)
                .foregroundColor(.black)
                .colorMultiply(.gray)
                .shadow(color: Color.gray.opacity(0.9), radius: 4, x: 10, y: 10)
        }
    }
    
}

var imgCap: UIImage?

struct ContentView: View {
    @State var image: Image?
    @State var jyoutai = 0
    @State var Where = ""
    @State var Who = ""
    @State var What = ""
    @State var Why = ""
    @State var How = ""
    @State var isPhoto = false
    @State var OutDate = Date()
    @State var ScreenShot = false
    @State private var canvasRect: CGRect = .zero
    @State var ScreenAlert = ""
    @State var flgActivity = false

    var f: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .short
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        return f
    }

    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.lightGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for:  .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)

    }

    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Rectangle()
                    .foregroundColor(.white)

                VStack {
                    //ここから切り取りスタート
                    GeometryReader {geometry2 in
                        VStack {
                            pkrView(jyo: $jyoutai)
                            HStack  {
                                Text("When：いつ：")
                                    .frame(width: 250, alignment: .leading)
                                Text(f.string(from: OutDate))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.all, 5)
                                    .border(Color.black)
                                    .padding(.all, 5)
                            }
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                            .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 10, y: 10)

                            txtField(bpn1: $Where, bpn2: $Who, bpn3: $What, bpn4: $Why, bpn5: $How)

                            if image != nil {
                                image?
                                    .resizable()
                                    .scaledToFit()
                            }
                            else {
                                Image(systemName: "photo")
                                    .resizable()
                                    .foregroundColor(.gray)
                                    .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 10, y: 10)
                            }
                            Spacer()
                        }
                        .padding(10)
                        .onAppear {
                            canvasRect = geometry2.frame(in: .local)
                        }
                        //切り取り終わり
                    }

                    HStack{
                        Spacer()
                        Button(action: {
                            isPhoto = true

                        }) {
                            //Text("撮影")
                            Image(systemName: "camera")
                                .font(.system(size: 60))
                                .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 10, y: 10)
                        }
                        .padding()
                        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)

                        Spacer()
                        Button(action: {
                            UIApplication.shared.closeKeyboard()
                            if jyoutai == 0 {
                                self.ScreenShot = true
                                self.ScreenAlert = "状態を選択して下さい。"
                            } else if Where == "" {
                                self.ScreenShot = true
                                self.ScreenAlert = "「Where：どこで」を入力して下さい。　対象外：「(空白)」"
                            }else if Who == "" {
                                self.ScreenShot = true
                                self.ScreenAlert = "「Who：だれが」を入力して下さい。　対象外：「(空白)」"
                            }else if What == "" {
                                self.ScreenShot = true
                                self.ScreenAlert = "「What：何が」を入力して下さい。　対象外：「(空白)」"
                            }else if Why == "" {
                                self.ScreenShot = true
                                self.ScreenAlert = "「Why：なぜ」を入力して下さい。　対象外：「(空白)」"
                            }else if How == "" {
                                self.ScreenShot = true
                                self.ScreenAlert = "「How：どのように」を入力して下さい。　対象外：「(空白)」"
                            }
                            else if image == nil {
                                self.ScreenShot = true
                                self.ScreenAlert = "写真を撮って下さい。"
                            } else {
                                Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {_ in
                                    let captureImage = capture(rect: geometry.frame(in: .global))
                                    imgCap = cropImage(with: captureImage, rect: canvasRect)
                                    //UIImageWriteToSavedPhotosAlbum(croppedImage!, nil, nil, nil)
                                    flgActivity = true
                                    //self.ScreenShot = true
                                    //self.ScreenAlert = "写真へ保存しました。"

                                })
                            }

                        }) {
                            //Text("登録")
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 60
                                ))
                                .shadow(color: Color.gray.opacity(0.8), radius: 4, x: 10, y: 10)
                        }
                        .padding()
                        //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        .alert(isPresented: $ScreenShot, content: {
                            Alert(title: Text("完了"), message: Text(ScreenAlert), dismissButton: .default(Text("OK")))
                        })

                        Spacer()
                    }
                }


                if isPhoto {
    //               ImagePicker()
    //                Rectangle()
                    ImagePicker(image: $image, isPicking: $isPhoto, importDate: $OutDate)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut)
                }
            }

            .font(.title)
        }
        .sheet(isPresented: $flgActivity, content: {
            ActivityView(activityItems: [imgCap!], applicationActivities: nil)
        })
    }
}

extension UIView {
    var redaeredImage: UIImage {
        let rect = self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        self.layer.render(in: context)
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImage
    }
}

extension ContentView {
    func capture(rect: CGRect) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: rect.origin, size: rect.size))
        let hosting = UIHostingController(rootView: self.body)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.redaeredImage
    }

    func cropImage(with image: UIImage, rect: CGRect) -> UIImage? {
        let ajustRect = CGRect(
            x: rect.origin.x * image.scale,
            y: rect.origin.y * image.scale,
            width: rect.width * image.scale,
            height: rect.height * image.scale)
        guard let img = image.cgImage?.cropping(to: ajustRect) else {
            return nil
        }
        let croppedImage = UIImage(cgImage: img, scale: image.scale, orientation: image.imageOrientation)
        return croppedImage
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


