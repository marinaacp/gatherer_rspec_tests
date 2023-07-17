class Project
  attr_accessor :tasks, :value, :name

  def initialize
    @tasks = []
  end
  def incomplete_tasks
    tasks.reject(&:complete?)
  end
  def done?
    # tasks.empty?
    # tasks.all?(&:complete?)
    incomplete_tasks.empty?
  end
  def total_size
    tasks.sum(&:size)
  end
  # The &:size notation is a shorthand syntax for calling the size method on each element of the collection.
  # It is equivalent to tasks.sum { |task| task.size }. The size method, in this case, is expected to be a method defined within the Task class that returns the size of a task.
  def remaining_size
    # tasks.reject(&:complete?).sum(&:size)
    incomplete_tasks.sum(&:size)
  end
end
