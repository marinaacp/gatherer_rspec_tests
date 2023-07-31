class CreatesProject
  attr_accessor :name, :project, :task_string

  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new(name: name) # Why not use @name here?
  end

  def convert_string_to_tasks
    task_string.split("\n").map do |one_task|
      Task.new(title: title)
    end
  end
end
