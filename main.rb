#Employee Management tool

require "./db.rb"
require "./dbmethods.rb"
#require "./employee.rb"

include DbMethods
action = ""

def retrieve(action)
    retrieve_employees("managers") if action == "1"
    retrieve_employees("accountants") if action == "2"
    retrieve_employees("generalhand") if action == "4"
    retrieve_employees("security") if action == "3"
end

puts "Welcome to Employee management\n\n".rjust(20)

while action != "exit"
    print "Enter action to be done.\n\
    enter '1' - To add employee, '2' - To list employees\n\
    '3' - To update employee, '4' - To remove employee\n> "

    roles = {"1" => "managers", "2" => "accountants", "3" => "security", "4" => "generalhand"}

    action = gets.chomp.downcase()

    case action

    when "1"
        print "Enter Name and Surname:\n> "
        action  = gets.chomp.downcase()
        name = action
        break if action == "exit"

        print "Enter role number: '1' - for managers; '2' - for accountants\n\
        '3' - for security; '4' - for general hand\n> "
        action  = gets.chomp.downcase()
        role = action

        break if action == "exit"
        break if roles[action] == ""
        add_to_table(name, roles[action]) if ["1","2","3","4"].include?(role)

    when "2"
        print "Enter '1' - for managers; '2' - for accountants\n\
        '3' - for security; '4' - for general hand\> "

        action  = gets.chomp.downcase()
        break if action == "exit"
        retrieve(action)

    when "3"
        print "To update enter role number: '1' - for managers; '2' - for accountants\n\
        '3' - for security; '4' - for general hand\n> "

        action  = gets.chomp.downcase()
        break if action == "exit"
        role = ""
        role = "managers" if action == "1"
        role = "accountants" if action == "2"
        role = "generalhand" if action == "4"
        role = "security" if action == "3"
        role_number = action

        retrieve_employees(role)
        print "\nEnter name of Employee\n> "

        action  = gets.chomp.downcase()
        oldname = action

        print "Enter new Name or Role\nNew Name> "
        action  = gets.chomp.downcase()
        newname = action

        print "Enter role number: '1' - for managers; '2' - for accountants\n\
        '3' - for security; '4' - for general hand\n> "
        action  = gets.chomp.downcase()
        newrole = action

        if ["1","2","3","4"].include?(newrole)
            update_employee(newname, role, oldname) if oldname != newname && role_number == newrole
            del_employee(oldname, role) if oldname == newname && role_number != newrole
            add_to_table(newname, roles[newrole]) if oldname == newname && role_number != newrole
        else
            print "No update done\n"
        end

        break if action == "exit"

    when "4"
        print "To delete enter the role of the employee\n"
        print "Enter role number: '1' - for managers; '2' - for accountants\n\
        '3' - for security; '4' - for general hand\n> "
        action  = gets.chomp.downcase()
        role = action
        break if action == "exit"
        break if !["1", "2", "3", "4"].include?(role)
        retrieve(action)

        print "Type in the name of the employee to delete:\n> "
        action  = gets.chomp.downcase()
        name = action
        break if action == "exit"
        del_employee(name, roles[role])
        print "#{name.capitalize} deleted from our database.\n"
    end
end

puts "Thank you. Goodbye!"
