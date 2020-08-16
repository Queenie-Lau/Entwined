struct QuestionsAndAnswers {
     func responseTo(question: String) -> String {
        let lowercased = question.lowercased()
        if lowercased.hasPrefix("hello"){
            return "Hi there, I'm Flora! Ask me anything about sustainability. "
        }
        else if lowercased == "how can I build sustainable habits?" {
            return "There are many ways, but some include: turning off electronics when not using them, traveling sustainably, and more!"
        }
        else if lowercased.hasPrefix("thank"){
            return "No problem! Hope you learned something new. "
        }
        else if lowercased.hasPrefix("bye"){
            return  "No problem! Hope you learned something new. "
        }
        else if lowercased == "Are there any recycling centers near me?" {
            return  "Let me check that for you."
        }
        else {
            return "I'm sorry, I don't understand your question :( "
        }
    }
}

