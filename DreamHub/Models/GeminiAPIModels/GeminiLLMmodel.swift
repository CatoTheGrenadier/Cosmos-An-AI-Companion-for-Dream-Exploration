//
//  GeminiLLMmodel.swift
//  DreamHub
//
//  Created by Yi Ling on 7/12/25.
//

import Foundation
import GoogleGenerativeAI

class GeminiLLM: ObservableObject {
    let model = GenerativeModel(name: "gemini-2.0-flash", apiKey: APIKey.default)
    @Published var isLoading = false
    @Published var response = ""
    @Published var jsonOutput = "{}"
    @Published var dreamContent = ""
    @Published var irlEvents = ""
    var prompt1 = "Below is the user's dream. Give him a lengthy, detailedthorough analysis of the dream. The response should contain 3 parts. First part should be a polished prolonged description of the dream, divided into several parts: People involved, things happened. Second part should be psychological analysis, which should be lengthy and detailed, diving into deep inconsciousness. Last give several emotional words to summary the dream. Dont say anything else. No header or tail. No special font. Just plain text. And struct your answer formally like a proper analysis, like subtitles, bulletins, etc."
    var prompt2 = "And now here's some events happening in his life recently. Use them to conduct the analysis."
    var prompt3 = "The output should be a json format string, properties include name(you will auto assign a title, should be string), content(based on the userinput, also string), savedAnalysis(which should be a string), recentEvents(which should be a string), sentiments(a list of strings). THE OUTPUT SHOULD BE ABLE TO BE PARSED LIKE JSON DIRECTLY BY SWIFT! Besides i want the savedAnalysis to be markdown format. Rememeber to format savedAnslysis beautifully as i will show this to user."
    
    func generateResponse(){
        self.isLoading = true
        Task {
            do {
                print("debug: request sent")
                let result = try await self.model.generateContent(prompt1 + "\n" + dreamContent + prompt2 + "\n" + irlEvents + "\n" + prompt3)
                isLoading = false
                response = result.text ?? "No response found"
                if (response != "No response found"){
                    jsonOutput = cleanJSONString(response)
                }
                dreamContent = ""
            } catch {
                response = "Something went wrong! \n\(error.localizedDescription)"
            }
        }
    }
    
    func decodeDream() -> DreamModel? {
        guard let data = jsonOutput.data(using: .utf8) else {
            print("❌ Failed to convert string to Data")
            return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601  // match Gemini’s date format

        do {
            let dream = try decoder.decode(DreamModel.self, from: data)
            dream.id = UUID().uuidString 
            return dream
        } catch {
            print("❌ Decoding error:", error)
            return nil
        }
    }
    
    func cleanJSONString(_ raw: String) -> String {
        var lines = raw.components(separatedBy: .newlines)
        if let first = lines.first, first.hasPrefix("```") {
            lines.removeFirst()
        }
        if let last = lines.last, last == "```" {
            lines.removeLast()
        }
        return lines.joined(separator: "\n")
    }


}
