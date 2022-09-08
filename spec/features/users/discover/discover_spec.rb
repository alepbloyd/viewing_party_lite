require 'rails_helper'

RSpec.describe "users discover page", type: :feature do

    before(:each) do
        @generic_user = User.create!(first_name: "Alep", last_name: "Bloyd", email: "beepo@beep.com", password: "iluvmovies123", password_confirmation: "iluvmovies123")

        visit login_path

        fill_in "Email", with: "beepo@beep.com"
        fill_in "Password", with: "iluvmovies123"

        click_on "Log In"
    end

    it 'has a users discover page' do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now, password: "iluvmovies123", password_confirmation: "iluvmovies123")

        visit "/users/#{@generic_user.id}"

        click_button("Discover Movies")

        expect(current_path).to eq("/users/#{@generic_user.id}/discover")
        expect(page).to have_button("Discover Top Rated Movies")
    end

    it 'has a text field with a search function', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now, password: "iluvmovies123", password_confirmation: "iluvmovies123")

        visit "/users/#{@generic_user.id}/discover"

        fill_in "search", with: "Toy Story"
        click_button("Search")

        expect(page).to have_content("Toy Story")
        
        # expect(current_path).to eq("/users/#{user.id}/movies?utf8=✓&search=Toy+Story&commit=Search&user_id=1")
    end

    it 'text search field cannot be blank', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now, password: "iluvmovies123", password_confirmation: "iluvmovies123")

        visit "/users/#{@generic_user.id}/discover"

        click_button("Search")

        expect(current_path).to eq("/users/#{@generic_user.id}/discover")

        expect(page).to have_content("Error: Search form cannot be blank")
    end

    it 'has a text field with a top movies function', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now, password: "iluvmovies123", password_confirmation: "iluvmovies123")

        visit "/users/#{@generic_user.id}/discover"

        click_button("Discover Top Rated Movies")

        expect(page).to have_content("The Shawshank Redemption")

        # expect(current_path).to eq("/users/#{user.id}/movies?movies=top_movies")
    end
end