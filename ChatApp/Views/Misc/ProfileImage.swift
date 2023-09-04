//
//  ProfileImage.swift
//  ChatApp
//
//  Created by Alfie Downing on 22/08/2023.
//

import SwiftUI

struct ProfileImage: View {
    var user: User = User()
    var body: some View {
        ZStack {
            
            if user.photo == nil {
                
            } else {
                
                
                // Check image cache, if exists use that, else download image
                
                if let cacheImage = CacheService.getImage(forKey: user.photo!) {
                    
                    // Image in cache
                    
                    cacheImage
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                    
                } else {
                    
                    let photoURL = URL(string: user.photo ?? "")
                    
                    
                    AsyncImage(url: photoURL) { phase in
                        
                        switch phase {
                            
                        case AsyncImagePhase.empty:
                            // Currently fetching
                            ProgressView()
                        case AsyncImagePhase.success(let image):
                            // Display fetched image
                            image
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .onAppear {
                                    
                                    // Save image to cache
                                    CacheService.setImage(image: image, forKey: user.photo!)
                                }
                            
                            
                            
                            
                        case AsyncImagePhase.failure:
                            // Could not fetch upload photo
                            Circle()
                                .foregroundColor(.white)
                                .overlay {
                                    Text(user.firstName?.prefix(1) ?? "")
                                        .font(.bodyText)
                                        .bold()
                                }
                        }
                        
                        
                    }
                }
                

                
            }
            
            Circle().stroke(Color("logoStart"), lineWidth: 2)
            
        }
        .frame(width:44, height:44)
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage()
    }
}
