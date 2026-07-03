# CodeWordBreaker

A variant of [CodeBreaker](https://github.com/evans-prince/CodeBreaker) (my Mastermind clone) that swaps colored pegs for letters and adds a constraint: guesses must be real English words. Built on the same Stanford CS193p-style course assignment base as CodeBreaker.

**Status: work in progress, early stage.** The core letter-guessing loop works; the word-validity feature is partially wired up.

## What's here

- Same Mastermind-style match feedback as CodeBreaker (right letter/right spot, right letter/wrong spot), but guesses are 4+ letter words instead of arbitrary peg combinations.
- `Words.swift` loads a real word list (Stanford CS193p's word corpus) to validate guesses against actual English words, keyed by word length.

## Structure

```
CodeWordBreaker/
├── Model/
│   ├── Code.swift
│   ├── CodeBreaker.swift   # game state, adapted for letter pegs (A-Z)
│   └── Words.swift         # async-loaded word list for guess validation
├── UI/
│   ├── CodeBreakerView.swift
│   ├── CodeView.swift
│   └── PegChooser.swift
└── CodeWordBreakerApp.swift
```

## Known gaps / what's left

- Word-validity checking isn't fully enforced in the guess-submission flow yet.
- No feedback to the player when a guess isn't a real word (currently just a data structure that's loaded, not surfaced in UI).
- Same missing pieces as CodeBreaker: no difficulty settings, no persistence.

## Running it

Open in Xcode (SwiftUI, iOS/macOS target) and run. Requires network access on first launch to fetch the word list.
