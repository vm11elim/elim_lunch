//
//  ContentView.swift
//  elimLunch
//
//  Created by pc on 2022/11/02.
//

import SwiftUI

class MyClass {//모델.
    var cnt = 0
    var url = URL(string: "https://img1.daumcdn.net/thumb/C100x100.mplusfriend/?fname=http%3A%2F%2Fk.kakaocdn.net%2Fdn%2FZCQ3X%2FbtrQbtjKjnx%2Fn0Ndv5euKg3TOJ9hJBOwxk%2Fimg_s.jpg")!
    func doYes() {

//        cnt+=1
        MY_HTTP.do_count1()// 이게 끝나야 꺼지게하기.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
        
    }
    func doNo() {
//        cnt-=1
        MY_HTTP.do_count2()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
        

    }
}



struct ContentView: View {//뷰.
    @State var myClass: MyClass
    
    
    @State var cnt = 0
    
    @State var appwidget: String = "(none)"

    
    var body: some View {
        Button("1"){
            myClass.doYes()
            
        }
        Button("2"){
            myClass.doNo()
        }
            
        
        AsyncImage(url: myClass.url) // 1
//        myClass.img
//        Text(self.appwidget)
        Text(String("cnt ")+String(cnt))
        Text(String("Yes ")+String(myClass.cnt))
//        Text(String("No ")+String(myClass.cnt))
            .padding()
        
            .onOpenURL(perform: { (url) in
                if(url.path.elementsEqual("/Yes"))
                {
                    cnt+=1
                    myClass.doYes()
                }
                if(url.path.elementsEqual("/No"))
                {
                    cnt+=1
                    myClass.doNo()
                }
            })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(myClass: MyClass())
    }
}

