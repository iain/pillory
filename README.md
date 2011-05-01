# Pillory

This is highly alpha stuff... come back later...


## Notes

To work with Cucumber: add this to the top op `features/support/env.rb`:


if ENV['PILLORY']
  require ENV['PILLORY']
  Pillory::CucumberFormatter.start
end

---

Copyright 2011, Iain Hecker
