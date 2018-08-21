module DbMethods

    include DB

    def add_to_table(name, role)
        values = [name, role]
        begin
            connect("./employee.db")
            sql_statement("INSERT into #{role.capitalize} (Name, Role) VALUES (?, ?)")
            sql_execute(values)
        rescue SQLite3::Exception => e
            reporterr(e)
        ensure
            close_db()
        end
    end

    def retrieve_employees(role)
        begin
            connect("./employee.db")
            sql_statement("select * from #{role.capitalize}")
            res = sql_execute()
            display_employees(res, role)
        rescue SQLite3::Exception => e
            reporterr(e)
        ensure
            close_db()
        end
    end

    def display_employees(list, role)
        puts "LIST OF #{role.upcase()} \n"
        len = 0
        #list.each {|e| len = e[0].length if len < e[0].length}
        print "Name".ljust(60) +   "Role\n"

        list.each {|e| puts "  #{e[0].capitalize}".ljust(60) + "  #{e[1].capitalize}"}
        puts "\n#{"-"*20}"
    end

    def update_employee(name, role, oldname)
        values = [name, role, oldname]
        begin
            connect("employee.db")
            sql = "UPDATE #{role.capitalize} SET Name = ?, Role = ? WHERE Name = ?"
            sql_statement(sql)
            sql_execute(values)
        rescue SQLite3::Exception => e
            reporterr(e)
        ensure
            close_db()
        end
    end

    def del_employee(name, role)
        begin
            connect("./employee.db")
            sql = "DELETE FROM #{role.capitalize} WHERE Name = (?)"
            sql_statement(sql)
            sql_execute(name)
        rescue SQLite3::Exception => e
            reporterr(e)
        ensure
            close_db()
        end
    end
end
