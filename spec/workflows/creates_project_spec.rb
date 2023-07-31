# Placing business logic outside Rails classes makes that logic easier to test and manage
require "rails_helper"

RSpec.describe CreatesProject do
  describe "initialization" do
    it "creates a project given a name" do
      creator = CreatesProject.new(name: "Project Runway")
      creator.build
      expect(creator.project.name).to eq("Project Runway")
    end
  end

  describe "task sating parsing" do
    it "handles an empty string" do
      creator = CreatesProject.new(name: "Project Runway", task_string: "")
      tasks = creator.convert_string_to_tasks
      expect(tasks).to be_empty
    end
  end

  describe "handles a single string" do
    
  end

end
