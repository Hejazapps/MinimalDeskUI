//
//  FontListView.swift
//  MinimalDesk
//
//  Created by Rakib Hasan on 22/9/24.
//

import SwiftUI

struct FontListView: View {
    private let viewModel = WidgetViewModel.shared
    
    @State var searchText: String = ""
    @State var allFonts = [String]()
    @Environment(\.dismiss) var dismiss
    
    private var searchResult: [String] {
        guard searchText.isEmpty == false else {
            return allFonts
        }
        
        return allFonts.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        VStack {
            header()
            searchField()
            fontList()
            
            Spacer()
        }
        .background(.black)
        .foregroundStyle(.white)
        .onAppear {
            allFonts = viewModel.fetchAllFonts()
        }
    }
}

// MARK: - SubViews
private extension FontListView {
    func header() -> some View {
        ZStack {
            Text("Choose Font")
                .font(.title3)
                .bold()
            
            HStack {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding()
                    .opacity(0.5)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
    
    func searchField() -> some View {
        HStack {
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    Label {
                        Text("Search")
                    } icon: {
                        Image(systemName: "magnifyingglass")
                    }
                    .font(.title3)
                }
                
                TextField("", text: $searchText)
            }
            .padding([.leading, .vertical])

            Spacer()
        }
        .background(.white)
        .opacity(0.25)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
    
    func fontList() -> some View {
        List(searchResult, id: \.self) { font in
            Text(font)
                .font(Font.custom(font, size: 16))
                .listRowBackground(Color(rgbRed: 27, green: 27, blue: 27))
                .listRowSeparator(.visible)
                .onTapGesture {
                    viewModel.favAppWidgetConfig.fontType = font
                    dismiss()
                }
        }
        .background(.black)
        .scrollContentBackground(.hidden)
    }
}


#Preview {
    FontListView()
}
