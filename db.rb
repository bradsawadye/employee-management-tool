module DB

    require 'sqlite3'

    @db
    @@exec
    @@smt

    def connect(db)
            @@db = SQLite3::Database.open db
    end

    def sql_statement(sql)
        @@smt = @@db.prepare(sql)
    end

    def reporterr(e)
        puts "Exception occured"
        puts e
    end

    def sql_execute(values = nil)
        if values != nil
            @@smt.bind_params values
        end
        @@exec = @@smt.execute
        return @@exec
    end

    def close_db
        @@smt.close if @@smt
        @@db.close if @@db
    end

end
