# Placing business logic outside Rails classes makes that logic easier to test and manage
require "rails_helper"

# RSpec.describe CreatesProject do
RSpec.describe CreatesProject, :aggregate_failures do
  # aggregate_failures: RSpec won’t stop after the first failure, but will show all failures in the spec.

  describe "initialization" do
    it "creates a project given a name" do
      creator = CreatesProject.new(name: "Project Runway")
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe "task sating parsing" do
    it "handles an empty string" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "")
      tasks = creator.convert_string_to_tasks
      expect(tasks).to be_empty
    end

    it "handles a single string" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1) # it's verifying that the convert_string_to_tasks method generated a single task from the provided task string.
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles a single string with size " do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things:3")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 3)
    end

    it "handles a single string with size zero" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things:0")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles a single string with malformed size" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things:")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles a single string with negative size" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things:-1")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(1)
      expect(tasks.first).to have_attributes(title: "Start Things", size: 1)
    end

    it "handles multiple tasks" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things:3\nEnd Things:2")
      tasks = creator.convert_string_to_tasks
      expect(tasks.size).to eq(2)
      expect(tasks).to match(
      [an_object_having_attributes(title: "Start Things", size: 3),
      an_object_having_attributes(title: "End Things", size: 2)])
      # expect(tasks[0]).to have_attributes(title: "Start Things", size: 3)
      # expect(tasks[1]).to have_attributes(title: "End Things", size: 2).
    end

    it "attaches tasks to the project" do
      creator = CreatesProject.new( name: "Project Runway", task_string: "Start Things:3\nEnd Things:2")
      creator.create
      expect(creator.project.tasks.size).to eq(2)
      expect(creator.project).not_to be_a_new_record
      # be_a_new_record: This matcher checks whether an ActiveRecord model instance is in a "new record" state, meaning it has not yet been saved to the database.
    end

  end
end

# S I N G L E - A S S E R T I O N
# By default, RSpec ends the spec when the first expectation fails. This means that if there are any expectations later in the spec,
# you don’t know whether they are correct. Sometimes this can lead to the tests giving an inaccurate sense of the status of the code.

# require "rails_helper"
# RSpec.describe CreatesProject do

#   let(:creator) { CreatesProject.new(
#   name: "Project Runway", task_string: task_string) }

#   describe "initialization" do
#     let(:task_string) { "" }
#     it "creates a project given a name" do
#       creator.build
#       expect(creator.project.name).to eq("Project Runway")
#     end
#   end

#   describe "task string parsing" do
#     let(:tasks) { creator.convert_string_to_tasks }

#     describe "with an empty string" do
#       let(:task_string) { "" }
#       specify { expect(tasks).to be_empty }
# #      The individual assertions are now wrapped in specify calls since the assertion is (arguably) expressive enough not to need another text description.
#     end

#     describe "with a single string" do
#       let(:task_string) { "Start Things" }
#       specify { expect(tasks.size).to eq(1) }
#       specify { expect(tasks.first).to have_attributes(
#       title: "Start Things", size: 1) }
#     end

#     describe "with a single string with size " do
#       let(:task_string) { "Start Things:3" }
#       specify { expect(tasks.size).to eq(1) }
#       specify { expect(tasks.first).to have_attributes(
#       title: "Start Things", size: 3) }
#     end

#     describe "handles a single string with size zero" do
#       let(:task_string) { "Start Things:0" }
#       specify { expect(tasks.size).to eq(1) }
#       specify { expect(tasks.first).to have_attributes(
#       title: "Start Things", size: 1) }
#     end

#     describe "handles a single string with malformed size" do
#       let(:task_string) { "Start Things:" }
#       specify { expect(tasks.size).to eq(1) }
#       specify { expect(tasks.first).to have_attributes(
#       title: "Start Things", size: 1) }
#     end

#     describe "handles a single string with negative size" do
#       let(:task_string) { "Start Things:-1" }
#       specify { expect(tasks.size).to eq(1) }
#       specify { expect(tasks.first).to have_attributes(
#       title: "Start Things", size: 1) }
#     end

#     describe "with multiple tasks" do
#       let(:task_string) { "Start Things:3\nEnd Things:2" }
#       specify { expect(tasks.size).to eq(2) }
#       specify { expect(tasks).to match(
#       [an_object_having_attributes(title: "Start Things", size: 3),
#       an_object_having_attributes(title: "End Things", size: 2)]) }
#     end

#     describe "attaches tasks to the project" do
#       let(:task_string) { "Start Things:3\nEnd Things:2" }
#       before(:example) { creator.create }
#       specify { expect(creator.project.tasks.size).to eq(2) }
#       specify { expect(creator.project).not_to be_a_new_record }
#     end
#   end
# end
