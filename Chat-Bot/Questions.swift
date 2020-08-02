struct QuestionsAndAnswers {
     func responseTo(question: String) -> String {
        let lowercased = question.lowercased()
        if lowercased.hasPrefix("hello"){
            return "Hi there, I'm Flora! Ask me anything about sustainability. "
        }
        else if lowercased == "how can I build sustainable habits?" {
            return "There are many ways, but some include: "
        }
        else if lowercased.hasPrefix("thank"){
            return "No problem! Hope you learned something new. "
        }
        else if lowercased.hasPrefix("bye"){
            return  "No problem! Hope you learned something new. "
        }
        else {
            return "I'm sorry, I don't understand your question :( "
        }
    }
}

