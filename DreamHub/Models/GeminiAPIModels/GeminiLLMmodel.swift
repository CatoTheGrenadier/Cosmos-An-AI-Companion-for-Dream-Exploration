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
    // --- Part 1: Core Dream Analysis Instructions (static) ---
    
    var analysisInstructions = """
    Below is the user's dream. Provide a comprehensive and detailed psychological analysis. The analysis must be structured into three main parts, formatted using Markdown. Rules are:
    ### 1. Dream Description
    This part should be a polished, prolonged description of the dream, divided into clear sub-sections:
    - **People Involved:** Describe all individuals present.
    - **Events/Actions:** Detail the sequence of events and actions that occurred.

    ### 2. Psychological Analysis
    Provide a lengthy, detailed psychological interpretation, diving deep into the unconscious symbolism, emotional states, and potential meanings. Relate elements of the dream to common psychological archetypes, anxieties, desires, or life stages.

    ### 3. Summary Sentiments
    Conclude this analysis with several sentences (2-4 sentences recommended) that summarize the dream's core emotional feeling. **For this summary, use natural language and plain sentiment words (e.g., Joy, Anxiety, Hope, Fear). DO NOT include any numerical strength indicators or underscores in this particular section.** This section is for a human-readable summary.
    
    Here is the user's dream:
    
    """

    // --- Part 2: Recent Events Context (static) ---
    var recentEventsContext = """
    Use the following recent life events to inform and deepen the psychological analysis:

    """ // You'll append the actual recent events string here

    // --- Part 3: Sentiment Formatting Rules (static) ---
    // This part defines how the sentiments should be generated,
    // preceding the actual sentiments array that will be appended.
    var sentimentRules = """
    When generating sentiments, use words from the provided list whenever possible. Only create new words if absolutely necessary. Each sentiment must be followed by an underscore and a number from 1 to 4 (e.g., 'Joyful_1'), indicating the strength of the emotion (1 for weakest, 4 for strongest). If a word from the list already has a strength (e.g., 'Calm_2'), only change the number to reflect the desired strength (e.g., 'Calm_4'), do not append another number.
    The allowed sentiments list is:
    """ // You'll append the actual sentiment array (e.g., `["Joyful_1", "Sad_2", ...]`) here

    // --- Part 4: JSON Output Format (static) ---
    var jsonOutputFormat = """
    The final output must be a single JSON string, parsable directly by Swift's `JSONDecoder`. It should contain the following properties:
    - `name`: (string) An auto-assigned, fitting title for the dream.
    - `content`: (string) The original user's dream input.
    - `savedAnalysis`: (string) The full, Markdown-formatted dream analysis (from parts 1, 2, and 3 above).
    - `recentEvents`: (string) The recent life events provided.
    - `sentiments`: (array of strings) A list of the generated sentiments, each formatted as 'Word_StrengthNumber' (e.g., 'Hopeful_3').

    Ensure the JSON is complete and valid. Do not include any other text, headers, or footers outside the JSON string.
    """

    var finalPrompt = ""
    
    func assembleFinalPrompt(sentimentsString: String){
        finalPrompt = analysisInstructions + dreamContent + recentEventsContext + irlEvents + sentimentRules + sentimentsString + jsonOutputFormat
    }
    
    func generateResponse(){
        self.isLoading = true
        Task {
            do {
                print("debug: request sent")
                let result = try await self.model.generateContent(finalPrompt)
                isLoading = false
                response = result.text ?? "No response found"
                if (response != "No response found"){
                    jsonOutput = cleanJSONString(response)
                }
                dreamContent = ""
                finalPrompt = ""
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
