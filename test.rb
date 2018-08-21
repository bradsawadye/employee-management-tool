x = 1
puts(x) if [2,3].include?(x)

require "./db.rb"
include DB
def create()
    values = ["Managers", "brad whwe", "managers"]
    begin
        connect("employee.db")
        sql = "INSERT INTO ? (Name, Role) values (?,?)"
        sql_statement(sql)
        sql_execute(values)
        puts "created"
    rescue SQLite3::Exception => e
        puts e
    ensure
        close_db()
    end
end

create()
