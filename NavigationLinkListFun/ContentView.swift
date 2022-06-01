//
//  ContentView.swift
//  NavigationLinkListFun
//
//  Created by Jason Ji on 5/31/22.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
}

class ViewModel: ObservableObject {
    @Published var items = [Item(name: "Initial Item")]
    @Published var linkActive = false
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Some Content (Ignore - Just for Spacing)") {
                    TextEditor(text: Binding.constant(""))
                        .frame(minHeight: 400)
                }
                Section("Items") {
                    NavigationLink(
                        isActive: $viewModel.linkActive,
                        destination: {
                            DetailView(items: $viewModel.items)
                        },
                        label: {
                            Button {
                                viewModel.linkActive = true
                            } label: {
                                Text("Add Items")
                            }
                        }
                    )
                    ForEach(viewModel.items) { item in
                        Text(item.name)
                    }
                    
                }
            }
            .navigationTitle("Navigation Woes")
        }
    }
}

struct DetailView: View {
    @Binding var items: [Item]
    
    var body: some View {
        Button("Add an item") {
            items.append(Item(name: "An item"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
