class Employee
    attr_accessor :name, :role

    def initialize(args = {})
        @name = args[:name] || ""
        @role =  args[:role] || ""
    end
end
