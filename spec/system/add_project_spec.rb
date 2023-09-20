require "rails_helper"

# System Tests: System tests are high-level tests that examine the application as a whole. They interact with the application in a way
# that simulates how a user would interact with it, usually using a web driver, to ensure that all components work together correctly.

RSpec.describe "adding a project", type: :system do #:pending, (beforte type)
  it "allows a user to create a project with tasks" do
    # pending "not implemented yet"
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Choose Fabric:3\nMake it Work:5"
    click_on("Create Project")
    visit projects_path
    @project = Project.find_by(name: "Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .name", text: "Project Runway")
    # expect(page).to have_content("Project Runway")
    expect(page).to have_selector(
      "#project_#{@project.id} .total-size", text: "8")
    # expect(page).to have_content(8)
  end
  # it "bends steel in its bare hands" =>  In RSpec, any it method defined without a block is considered to be “pending.”
  # pending runs the tes but it doesent return as broken if doesent passes. To not run the code at all use skip

  # This is called an “outside” test because it works from outside the Rails stack
  # using Capybara allows you to simulate user activity for end￾to-end tests of your Rails features.

end
