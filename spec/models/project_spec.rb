require 'rails_helper'

RSpec.describe Project do
  describe "project" do
    let(:project) { Project.new } #the symbol is called as a local variable. the let is only envoked when the variable is used.
    let(:task) {Task.new}
    # use --- let! --- if it must be present even though it is never invoked by name
    # ex:
    # RSpec.describe User do
    #   users = []
    #   let!(:me) { users << User.new }
    #   let!(:you) { users << User.new }

    #   it "describes a user behavior" do
    #     expect(users.count).to eq(2)
    #   end
    # end

    it "considers a project with no tasks to be done" do
      # expect(project.done?).to be_truthy
      # expect(actual_value).to(matcher), parentheses for the matcher often omitted. project.done? => 1 object - ExpectationTarget. matcher => another obj. All of it => ExpectationTarget.
      expect(project).to be_done
    end

    it "knows that a project with an incomplete task is not done" do
      project.tasks << task
      expect(project.done?).to be_falsy
    end

    it "marks a project doni if its tasks are done" do
      project.tasks << task
      task.mark_completed
      expect(project).to be_done
    end

    # My tests
    it "knows a project value must be 3 or 4" do
      project.value = 4
      expect(project.value).to eq(3).or eq(4)
      # it is possible to use an ---and--- just like i used the ---or--- above
    end

    it "knows an task must be called ooopsi or doosie" do
      project.name = "OOOPSI"
      expect(project.name).to match("OOOPSI").or ("DOOSIE")
      # expect(project.name).to match(an_object_eq_to("OOOPSI").or an_object_eq_to("DOOSIE"))
    end

    it "properly handles a blank project" do
      expect(project.completed_velocity).to eq(0)
      expect(project.current_rate).to eq(0)
      expect(project.projected_days_remaining).to be_nan # The be_nan assertion uses the RSpec dynamic matcher to check against nan?, which is a method on Number that is true if the number is “not a number,”
      expect(project).not_to be_on_schedule
    end

  end

  describe "estimates" do # Each describe block can have its own setup, making it easier to see what setup goes with what spec
    let(:project) { Project.new }
    let(:newly_done) { Task.new(size: 3, completed_at: 1.day.ago) }
    let(:old_done) { Task.new(size: 2, completed_at: 6.month.ago)}
    let(:small_not_done) { Task.new(size: 1) }
    let(:large_not_done) { Task.new(size: 4) }
    # obs:  Each task has a different score, and neither of the two adds up to the third
    # the let method are the GIVEN data

    before(:example) do # before(:each) or before(:example) block is executed as part of the setup before each spec.
      project.tasks = [newly_done, old_done, small_not_done, large_not_done]
    end
    # the before bloco is the WHEN action

    it "can calculate total size" do
      expect(project.total_size).to eq(10)
    end
    # each it satatemt is an assetion - WHAT behavior expect

    it "can calculate remaining size" do
      expect(project.remaining_size).to eq(5)
    end

    it "knows its velocity" do
      expect(project.completed_velocity).to eq(3)
    end

    it "knows its rate" do
      expect(project.current_rate).to eq(1.0 / 7)
      # expect(actual).to be_within(delta).of(expected)
    end

    it "knows its projected days remaining" do
      expect(project.projected_days_remaining).to eq(35)
    end

    it "knows if it is not on schedule" do
      project.due_date = 1.week.from_now
      expect(project).not_to be_on_schedule
    end

    it "knows if it is on schedule" do
      project.due_date = 6.months.from_now
      expect(project).to be_on_schedule
    end

  end
end

# OBS:

# I can use specify or it (usually use it if after is a string)
# ex of single line test: specify { expect(user.name).to eq("fred") }

# expect method returns RSpec proxy object called an ExpectationTarget
# ExpectationTarget responds to two messages: to and not_to
# to and not_to are ordinary Ruby methods that expect a single argument (RSpec matcher)
# RSpec matcher it’s an object that responds to a matches? method

# expect(array).to all(matcher)   # expect(actual).to all(be_truthy)
# expect(actual).to be > expected # (also works with <, >=, <=, and ==)
# expect(actual).to be_a(type)
# expect(actual).to be_truthy
# expect(actual).to be_falsy
# expect(actual).to be_nil
# expect(actual).to be_between(min, max)
# expect(actual).to be_within(delta).of(expected)
# expect { block }.to change(receiver, message, &block)
# expect(actual).to contain_exactly(expected)
# expect(range).to cover(actual_value)
# expect(actual).to eq(expected)
# expect(actual).to exist
# expect(actual).to have_attributes(key/value pairs)
# expect(actual).to include(*expected)
# expect(actual).to match(regex)
# expect { block }.to output(value).to_stdout # also to_stderr
# expect { block }.to raise_error(exception)
# expect(actual).to satisfy { block }

# Usual test structure:
# 1. given: What data does it needs?
# 2. when: What action
# 3. tehn: What behavior to specify?

# When you think about writing the next spec so that it breaks existing code, it is easier to move in small steps.

# In strict TDD you would avoid writing a test that you expect to pass, because a passing test doesn’t normally drive you to change the code.
