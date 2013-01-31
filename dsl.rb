class Car
    attr_writer :engine, :size, :turbo

    def initialize( attributes={}, &b )
        instance_eval &b if block_given?
        attributes.each_pair do |name, val|
            if self.respond_to? "#{name}=".to_sym
                send("#{name}=".to_sym, val)
            else
                raise "No setter"
            end
        end
    end

    def method_missing(method, *args)
        if respond_to? "#{method}=".to_sym
            send "#{method}=".to_sym, *args
        end
    end
    def engine_info
        raise "Info not filled [#{@engine}] [#{@size}]" if @engine.nil? or @size.nil?
        return "#{@size.to_f} #{@engine.capitalize} engine" unless @turbo
        "Turbo #{@engine} engine #{@size.to_f}" if @turbo
    end
end

puts Car.new(engine: :gas, size: 1.6).engine_info
puts Car.new(engine: :diesel, size: 2, turbo: true).engine_info

a = Car.new do
    engine :diesel
    size 3
end
puts a.engine_info
