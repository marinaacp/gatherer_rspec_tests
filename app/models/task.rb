class Task
  attr_accessor :size, :completed_at

  def initialize(options = {})
    # @completed = options[:completed]
    mark_completed(options[:completed_at]) if options[:completed_at]
    # This line checks if the :completed_at key exists in the options hash. If it does, it calls a method called mark_completed and passes the value of options[:completed_at] as an argument.
    # if options[:completed_at]
    #   mark_completed(options[:completed_at])
    # end
    @size = options[:size] # It retrieves the value associated with the :size key from the options hash and assigns it to the instance variable @size of the Task object.
  end
  def mark_completed(date = Time.current) # setting the parameter as Time.current allows the calling of mark_as_completed with or without the parameter date
    # if it's called without date, then it will have as default the Time.current. If i define the value for date only inside the method, then date is a mandatory parameter
    @completed_at = date
  end
  def complete?
    completed_at.present?
  end
  def part_of_velocity?
    return false unless complete?
    completed_at > 21.days.ago
  end
  def points_toward_velocity
    part_of_velocity? ? size : 0
  end
end
