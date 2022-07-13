//
//  ContentView.swift
//  Pinch
//
//  Created by Jersy Fernandes on 10/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAnimating:Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
  
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    var body: some View {
        NavigationView {
            ZStack{
                Color.clear
                
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color:.black.opacity(0.2), radius: 12, x:2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }
                        else{
                         resetImageState()
                        }
                    })
                
            }
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        withAnimation(.linear (duration: 1)){
                            imageOffset = value.translation
                        }
                    }
                    .onEnded{   value in
                       resetImageState()
                    }
            )
            .gesture(
                MagnificationGesture()
                    .onChanged{
                        value in
                        withAnimation(.linear(duration: 1)){
                            if imageScale >= 1 && imageScale <= 5 {
                                imageScale = value
                            } else if imageScale > 5 {
                                imageScale = 5
                            }
                        }
                    }
                    .onEnded{ _ in
                              if imageScale > 5 {
                                  imageScale = 5
                              } else if imageScale <= 1 {
                                  resetImageState()
                              }
                    }
            )
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            .overlay(
            InfoPainelView(scale: imageScale, offset: imageOffset)
                .padding(.horizontal)
                .padding(.top, 30)
            , alignment: .top
            )
            .overlay(
                Group {
                    HStack {
                        Button {
                            if imageScale > 1 {
                                 imageScale -= 1
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                        } label: {
                            ControllImageView(icon: "minus.magnifyingglass")
                        }
                        Button {
                            resetImageState()
                        } label: {
                            ControllImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        Button {
                            withAnimation(.spring()) {
                                if imageScale < 5 {
                                   
                                    imageScale += 1
                                    
                                    if imageScale > 5 {
                                        
                                        imageScale = 5
                                    }
                                }
                            }
                            
                        } label: {
                            ControllImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30)
                ,   alignment:  .bottom
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
