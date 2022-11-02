//
//  FoodScatchWidget.swift
//  FoodScatchWidget
//
//  Created by pc on 2022/11/02.
//

import WidgetKit
import SwiftUI
import Intents


class MyClass2 {//모델.
    
    

    var url = URL(string: "https://img1.daumcdn.net/thumb/C100x100.mplusfriend/?fname=http%3A%2F%2Fk.kakaocdn.net%2Fdn%2FZCQ3X%2FbtrQbtjKjnx%2Fn0Ndv5euKg3TOJ9hJBOwxk%2Fimg_s.jpg")!
//    var url = URL(string: "https://cdn4.iconfinder.com/data/icons/small-n-flat/24/image-64.png")!
    var img = Image(systemName: "photo")
    
    
    init() {
        imageDownload(url:self.url)
    }
    
    func imageDownload(url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    print("Download image fail : \(url)")
                    return
            }

            DispatchQueue.main.async() {[weak self] in
                print("Download image success \(url)")

                self?.img = Image(uiImage: image)
//                ((MyClass2)self).img = Image(uiImage: image)

//                img = image
//                self?.imageView.image = image
            }
        }.resume()
    }

}



struct Provider: IntentTimelineProvider {
    var myClass2: MyClass2
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), txt: "placeholder",img: Image(systemName: "rectangle"), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),txt: "getSnapshot",img: Image(systemName: "circle"), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,txt: "getTimeline",img: myClass2.img, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let txt: String
    let img : Image
    
    let configuration: ConfigurationIntent
}

struct FoodScatchWidgetEntryView : View {
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
    @State var mytxt : String = "String"
    
    var entry: Provider.Entry

    var body: some View {

        HStack{
            Spacer()
            Link(destination: URL(string: "MyMy:///Yes")!, label: {
                VStack{
                Image(systemName: "hand.thumbsup.fill").imageScale(.large)
                Text("좋아요")
                }.padding(30).background(Color.blue)
            })
            Spacer()
            Link(destination: URL(string: "MyMy:///No")!, label: {
                VStack{
                Image(systemName: "hand.thumbsdown.fill").imageScale(.large)
                Text("지쳐요")
                }.padding(30).background(Color.red)
            })
            Spacer()
        }
        .padding()

        
//            entry.img

        
        
//        Image(Image:entry.img)
    }
}

@main
struct FoodScatchWidget: Widget {
    let kind: String = "FoodScatchWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider(myClass2: MyClass2())) { entry in
            FoodScatchWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct FoodScatchWidget_Previews: PreviewProvider {
    static var previews: some View {
        FoodScatchWidgetEntryView(entry: SimpleEntry(date: Date(),txt: "preview",img:Image(systemName: "star"), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


