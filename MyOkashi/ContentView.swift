//
//  ContentView.swift
//  MyOkashi
//
//  Created by 田岸将勝 on 2021/06/10.
//

import SwiftUI

struct ContentView: View {
    // OkashiDataを参照する状態変数
    @ObservedObject var okashiDataList = OkashiData()
    // 入力された文字列を保持する状態変数
    @State var inputText = ""
    @State var showSafari = false
    
    var body: some View {
        // 垂直にレイアウト（縦方向にレイアウト）
        VStack {
            // 文字を受け取るTextFieldを表示する
            TextField("キーワードを入力してください", text: $inputText, onCommit: {
                // 入力直後に検索をする
                okashiDataList.searchOkashi(keyword: inputText)
            })
            // 上下左右に余白を空ける
            .padding()
            
            // リスト表示する
            List(okashiDataList.okashiList) { okashi in
                // okashiに要素を取り出して、List（一覧）を生成する
                // 水平にレイアウト（横方向にレイアウト）
                Button(action: {
                    showSafari.toggle()
                }) {
                    HStack {
                        // 画像を表示する
                        Image(uiImage: okashi.image)
                            // リサイズする
                            .resizable()
                            // アスペクト比（縦横比）を維持してエリア内に収まるようにする
                            .aspectRatio(contentMode: .fit)
                            // 高さ40
                            .frame(height: 40)
                        
                        // テキストを表示する
                        Text(okashi.name)
                    }
                }
                .sheet(isPresented: self.$showSafari, content: {
                    SafariView(url: okashi.link)
                        .edgesIgnoringSafeArea(.bottom)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
