//
// Created By: Mobile Apps Academy
// Subscribe : https://www.youtube.com/@MobileAppsAcademy?sub_confirmation=1
// Medium Blob : https://medium.com/@mobileappsacademy
// LinkedIn : https://www.linkedin.com/company/mobile-apps-academy
// Twitter : https://twitter.com/MobileAppsAcdmy
// Lisence : https://github.com/Mobile-Apps-Academy/MobileAppsAcademyLicense/blob/main/LICENSE.txt
//

import SwiftUI
import PDFKit

struct PDFExampleView: View {
    
    @State private var isExportingDocument = false
    
    var body: some View {
        VStack {
            Spacer()
            PDFKitView(pdfData: PDFDocument(data: generatePDF())!)
                .frame(height: 560)
            Spacer()
            Button(action: {
                savePDF()
            }, label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
                    .overlay(content: {
                        Text("Save PDF")
                            .foregroundStyle(.white)
                    })
            })
            .frame(height: 60)
            .padding()
        }
    }
    
    @MainActor
    private func generatePDF() -> Data {
        
        let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))
        let data = pdfRenderer.pdfData { context in
            
            context.beginPage()

            alignText(value: "Mobile Apps Academy", x: 0, y: 30, width: 595, height: 150, alignment: .center, textFont: UIFont.systemFont(ofSize: 50, weight: .bold))
            
            alignText(value: """
                      Welcome to Mobile Apps Academy, your go-to channel for all things mobile app development! Whether you're a seasoned developer looking to enhance your skills or a complete beginner eager to dive into the world of app creation, we've got you covered.
                      
                      Join us as we explore various aspects of mobile app development, from ideation to design, coding, testing, and deployment.

                      Whether you're interested in developing for iOS, Android, or cross-platform solutions, we offer in-depth tutorials and best practices tailored to each platform. Learn how to harness the capabilities of native features, optimize performance, implement engaging user interfaces, integrate APIs, and monetize your apps effectively.
""", x: 0, y: 150, width: 595, height: 595, alignment: .left, textFont: UIFont.systemFont(ofSize: 20, weight: .regular))
           
            
            let globeIcon = UIImage(named: "Logo")
            let globeIconRect = CGRect(x: 450, y: 550, width: 100, height: 100)
            globeIcon!.draw(in: globeIconRect)
            
        }
        
        return data
    }
    
    func alignText(value:String, x: Int, y: Int, width:Int, height: Int, alignment: NSTextAlignment, textFont: UIFont){
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = alignment
       
        let attributes = [    NSAttributedString.Key.font: textFont,
                              NSAttributedString.Key.paragraphStyle: paragraphStyle  ]
        
        let textRect = CGRect(x: x,
                              y: y,
                              width: width,
                              height: height)
        
        value.draw(in: textRect, withAttributes: attributes)
    }
    
    @MainActor func savePDF() {
        let fileName = "GeneratedPDF.pdf"
        let pdfData = generatePDF()
        
        if let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let documentURL = documentDirectories.appendingPathComponent(fileName)
            do {
                try pdfData.write(to: documentURL)
                print("PDF saved at: \(documentURL)")
            } catch {
                print("Error saving PDF: \(error.localizedDescription)")
            }
        }
    }
    
}


#Preview {
    PDFExampleView()
}

