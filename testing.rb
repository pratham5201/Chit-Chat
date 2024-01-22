module G
    class Hello
        def fun
            @v = "hello from instance method"
        end

        def self.abc
            p @v
        end
    end
end

include G
# a = (0...10).to_a
# b = Array.new(4)
# c = a + b
# p c
# p c.reject! { |n|  n == nil}

#  p ["orange", "apple", "banana"].map(&:class)
# a = Array.new(4)[1,2,3,4]
p a
# p a.map {|n| n.nil?}