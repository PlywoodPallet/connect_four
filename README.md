# Command-line Connect Four game in Ruby
Practice with Test-Driven Development (TDD) using Ruby and Rspec

Live code: https://replit.com/@Plywood/connectfour

# Requirements
- Make a 2-player Connect Four game using Ruby
- Write tests first, then write code to satisfy tests, then refactor code (Red-Green-Refactor cycle)
- [Project requirements](https://www.theodinproject.com/lessons/ruby-connect-four#project-tdd-connect-four)

# Project Notes
- Project was coded in small modular pieces for the purpose of test-friendlyness
- Followed Red-Green-Refactor practice for most methods
- Rspec tests helped a lot when I later had to introduce a default value in @board that wasn't nil. Helped me catch bugs across many methods without needing to find them via trial and error
- When I needed to refactor, rspec helped me test code quickly without testing each case *every* *single* *time*
- Wasn't able to google for a satisfactory algo to find the diagonals in a 2d array, so I developed my own.
- Need to be okay with writting tests that may not even be used later

# Future work
- For me, TDD sometimes triggers overthinking and decision paralysis. More experience with design patterns will help calm this