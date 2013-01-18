class Weekday < Time

    def self.today
        self.new.strftime '%A' 
    end
end

def modify_class (cls)
    if cls.respond_to? :today
        cls.instance_eval do
            def today
                self.new.strftime '%^A'
            end
        end
    end
end

puts Weekday.today
modify_class Weekday
puts Weekday.today
