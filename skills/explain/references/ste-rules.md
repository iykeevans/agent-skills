# STE writing rules

A working subset of the ASD-STE100 writing rules, adapted for software. Each rule has a bad and a good example.

## Words

**1. One word, one meaning.** Use a word only in one sense. Use the same word for the same thing every time.

- Bad: "The handler runs the job. Later the worker executes the task."
- Good: "The worker runs the job. Then the worker sends the result."

**2. Use approved words when you can.** Prefer the short, common word. See `ste-words.md`.

- Bad: "Utilize the helper to facilitate validation."
- Good: "Use the helper to validate the input."

**3. Technical names and technical verbs are allowed.** A technical name is a code identifier, file path, command, product, protocol or a term of the domain (`useQuery`, `JWT`, "webhook", "cache"). A technical verb is a verb of the domain with no simpler form ("deploy", "render", "commit"). Define a technical name in the terms table the first time.

**4. No phrasal verbs.** Use one verb.

- Bad: "Set up the client, then log in and look up the user."
- Good: "Configure the client. Then sign in and find the user."

**5. No idioms, metaphors or slang.**

- Bad: "This is the secret sauce that glues the layers together."
- Good: "This function connects the API layer to the UI layer."

## Sentences

**6. Keep sentences short.** A procedural sentence (an instruction) has 20 words or fewer. A descriptive sentence has 25 words or fewer. Code in backticks counts as one word.

**7. One instruction per sentence.** Two actions at the same time can share a sentence.

- Bad: "Open the file, change the port and restart the server."
- Good: "Open the file. Change the port. Restart the server."

**8. Use the imperative for instructions.**

- Bad: "You should now run the migration."
- Good: "Run the migration."

**9. Use the active voice.** Say who or what does the action.

- Bad: "The token is checked by the middleware."
- Good: "The middleware checks the token."

When the actor is not known or not important, a passive form is allowed in a descriptive sentence. Use it rarely.

**10. Use simple tenses.** Simple present, simple past and simple future ("will"). No "-ing" forms as verbs, no "has been", no "would have".

- Bad: "The app is fetching the data while the user is typing."
- Good: "The app gets the data while the user types."

**11. Do not use "-ing" words as nouns or adjectives** when another form exists.

- Bad: "Caching improves loading time."
- Good: "A cache makes the page load faster."

"-ing" words that are technical names are allowed: "string", "routing table", "polling interval" when "polling" is the domain term. Define them in the terms table.

**12. Use articles.** Write "the", "a" and "an" where normal English uses them. Do not drop them to save words.

- Bad: "Send request to server and wait for response."
- Good: "Send the request to the server. Wait for the response."

**13. Do not chain nouns.** Three nouns in a row or more is a noun cluster. Break it with "of", "for" or a verb, unless it is a technical name.

- Bad: "the user account balance refresh handler"
- Good: "the function that refreshes the balance of the user account"

**14. Say the condition first.** In an instruction with a condition, put the condition at the start.

- Bad: "Restart the server if the port changes."
- Good: "If the port changes, restart the server."

**15. Give warnings before the step they apply to.**

- Good: "Caution: this deletes the local data. Run `reset`."

## Paragraphs and structure

**16. One topic per paragraph.** Six sentences or fewer.

**17. Use lists and tables.** Use a numbered list for steps in order. Use a bullet list for items with no order. Use a table to compare things or to define terms.

**18. Put the most important information first.** The first sentence of a section says what the section is about.

**19. Use the same structure for the same kind of item.** All steps start with a verb. All terms definitions have one sentence.
