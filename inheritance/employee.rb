class Employee
  attr_reader :name, :title, :salary, :boss
  
  def initialize(name,title,salary,boss)
    @name, @title, @salary, @boss = name, title, salary, boss
    assign_manager unless @boss.nil?
  end
  
  def bonus(multiplier)
    bonus = @salary * multiplier
    return bonus
  end
  
  def assign_manager
    begin
      if @boss.is_a?(Manager)
        @boss.employees << self
      else
        raise 'Not a valid boss!'
      end
    end
  end
  
  def inspect
    p "Name: #{@name}, Boss: #{@boss}"
  end
    
  
end

class Manager < Employee
  attr_accessor :employees
  
  def initialize(name,title,salary,boss,employees = [])
    @employees = employees
    super(name,title,salary,boss)
  end
  
  
  def bonus(multiplier)
    total = 0
    employees.each do |i|
      total += i.bonus(multiplier)
    end
    total
  end
end


if __FILE__ == $PROGRAM_NAME
  ned = Manager.new("Ned","Founder",1_000_000, nil)
  joe = Manager.new("joe","janitor",10, ned)
  tyler = Employee.new("Tyler","boss daddy",20,joe)
  david = Employee.new("david", "ta", 10, joe)

  p david
end