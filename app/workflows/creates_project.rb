class CreatesProject
  attr_accessor :name, :project, :task_string

  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name: name) # Why not use @name here?
    # By using self.name (the getter method) instead of @name (the instance variable), you encapsulate the logic associated with getting the name attribute's value.
    # If you directly use @name, you're bypassing any potential logic or validations that might be added to the getter method in the future.
    project.tasks = convert_string_to_tasks
    project
  end

  def create
    build
    project.save
  end


  def convert_string_to_tasks
    task_string.split("\n").map do |one_task|
      title, size_string = one_task.split(":")
      Task.new(title: title, size: size_as_integer(size_string))
    end
  end

  def size_as_integer(size_string)
    return 1 if size_string.blank?
    [size_string.to_i, 1].max
    # The max method is called on the array. This method returns the maximum value from the array. Since the array contains the
    # integer value from size_string.to_i and the integer value 1, the max method effectively returns the larger of the two values.
  end
end
