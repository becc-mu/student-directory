# let's put all students into an array
@month = [:January, :February, :March, :April, :May, :June, :July, :August, :September, :October, :November, :December]
students = []


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp.capitalize

  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Please enter the student's cohort"
    cohort = gets.chomp.capitalize
    cohort = add_cohort(cohort) if cohort.empty?  # default cohort will be added if no value
    # add the student hash to the array
    students << {name: name, cohort: cohort.to_sym }
    puts "Now we have #{students.count} students"
    # get another name from the user
    puts "Please enter the names of the sudents"
    puts "To finish, just hit return twice"
    name = gets.chomp
    break if name.empty?

 end
  # return the array of students
  students
end

def add_cohort(cohort_mth)
  cohort_mth = cohort_mth.empty? ? "november" : cohort_mth.downcase
  # check if cohort_mth is one of the 12 months
  selected_cohrt = %w(january feburary march april may june july august september october november december)
  if selected_cohrt.include? cohort_mth
    return cohort_mth
  else
    return selected_cohrt[rand(12)] # else send a random month
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def entered_cohort(students) # list cohort in students array
  all_entered_cohorts = students.map do |student|
    student[:cohort]
  end.uniq
end

def print_cohort(students) # print students grouped by cohorts
  space = 12
  all_entered_cohorts = entered_cohort(students)
  all_entered_cohorts.each do |each_cohort|
    puts "Students in #{each_cohort} Cohort "
    students.each do |student|
      puts "#{student[:name].center(space)}" if student[:cohort] == each_cohort
    end
  end

end

def print(students)
 count = 1
 max_n = 12
 space = 4
 until count > students.count
    students.each.with_index(1) do |student, i|
      if student[:name].size < max_n
        puts "#{i}. #{student[:name].center(space)} (#{student[:cohort]} cohort)"
	count += 1
      end
    end
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
#nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
print_cohort(students)
