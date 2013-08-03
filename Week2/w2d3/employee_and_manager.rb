class Employee
  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def calculate_bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee
  def initialize(name, title, salary, boss = nil)
    super(name, title, salary, boss)
    @employee_list = []
  end

  def add_employee(employee)
    employee.boss = self
    @employee_list << employee
  end

  def calculate_bonus(multiplier)
    (@salary + get_salary_of_underlings) * multiplier
  end

  def get_salary_of_underlings
    sum = 0
    @employee_list.each do |employee|
      if employee.is_a?(Manager)
        sum += employee.get_salary_of_underlings
      end
      sum += employee.salary
    end
    sum
  end

end

e1 = Employee.new("E1", "acct", 1)
e2 = Employee.new("E2", "engr", 1)
e3 = Employee.new("E3", "acct", 1)
m4 = Manager.new("M1", "mgr1", 3)
m5 = Manager.new("M1", "ceo", 5)

m4.add_employee(e1)
m4.add_employee(e2)
m4.add_employee(e3)
m5.add_employee(m4)


puts m5.calculate_bonus(1)



