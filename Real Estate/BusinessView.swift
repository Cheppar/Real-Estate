//
//  BusinessView.swift
//  Real Estate
//
//  Created by Mac User on 8/13/23.
//

import SwiftUI

struct BusinessView: View {
    @ObservedObject var mapController: MapController
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(mapController.selectBusinessName)
                        .font(.title)
                    
                    Text(mapController.selectBusinessPlacemark)
                }
                
                Spacer()
                
                Button {
                    mapController.isBusinessViewShowing.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                HStack {
                    ForEach(mapController.actions) {action in
                        Button{
                            action.handler
                        } label: {
                            VStack {
                                Image(systemName : action.image)
                                Text(action.title)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
    }
}

struct BusinessView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessView(mapController: <#MapController#>)
            .previewLayout(.sizeThatFits)
    }
}
