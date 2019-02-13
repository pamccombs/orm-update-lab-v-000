require_relative "../config/environment.rb"

class Student
  
  attr_accessor :id, :name, :grade
  
  def initialize(id = nil, name, grade)
    @id, @name, @grade = id, name, grade
  end
  
  def self.create_table
    sql =  "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)"
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  def save
    sql = "INSERT INTO students (name, grade) 
        VALUES (?, ?)"

      DB[:conn].execute(sql, self.name, self.grade)

      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    
  end
  
  def self.create(name, grade)
    
   student = self.new(name, grade)
   student.save
    
  end
  
  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    grade = row[2]
    self.new(id, name, grade)
    
    
  end


end
