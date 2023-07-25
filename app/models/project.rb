class Project
  attr_accessor :tasks, :value, :name, :due_date

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

  def completed_velocity
    tasks.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity * 1.0 /  Project.velocity_length_in_days # transform in float divide by maximum of days after completed to be a part o velocity. Size of task divide by time avaliable
  end

  def projected_days_remaining
    remaining_size / current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan? # To pass the "properly handles a blank project"
    (Time.zone.today + projected_days_remaining) <= due_date # Time.zone.today returns the current date in the time zone that is set in your Rails application. Date.today returns the current date in the system's local time zone, without considering any time zone configuration set in Rails.
  end

  def self.velocity_length_in_days # self inside a method defines a class method, rather than an instance method. This method can be called directly on the class itself (ClassName.velocity_length_in_days)
    21
  end





end
