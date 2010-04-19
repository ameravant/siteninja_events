# module EventExtraMethods
#   module PersonInstanceMethods
#     def say_jason
#       puts "jason"
#     end
#     def name
#       puts "fred flintstone"
#     end
#   end
#   module PersonClassMethods
#     def jason
#       puts "class jason"
#     end 
#   end
#   Person.send(:include, EventExtraMethods::PersonInstanceMethods)
#   Person.extend EventExtraMethods::PersonClassMethods
# end
#ApplicationController
#  include EventExtraMethods
#end
#Person.first.say_jason
