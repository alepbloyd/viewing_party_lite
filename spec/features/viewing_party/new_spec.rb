require 'rails_helper'

RSpec.describe "viewing party new page", type: :feature do

    it 'has a viewing party new page', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user.id}/movies/278"

        click_button("Create Viewing Party for The Shawshank Redemption")

        expect(current_path).to eq("/users/#{user.id}/movies/278/viewing-party/new")
        expect(page).to have_content("The Shawshank Redemption")
    end

    it 'has a viewing party new page with a default runtime that can be adjusted', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user.id}/movies/278/viewing-party/new"
       
        expect(page).to have_field("runtime", with: "142")
    end

    xit 'has a viewing party new page with a default runtime that cannot be lower than the movie runtime', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user.id}/movies/278/viewing-party/new"

        fill_in("runtime", with: "120")
        #finish fields 
        click_on("Create Viewing Party")
       
        expect(current_path).to eq("/users/#{user.id}/movies/278/viewing-party/new")
    end

    it 'has a viewing party new page with the ability to select a date', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user.id}/movies/278/viewing-party/new"

        fill_in("date", with: "2022/10/03")
    end

    it 'has a viewing party new page with the ability to select a time', :vcr do
        user = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user.id}/movies/278/viewing-party/new"
        
        fill_in("time", with: "05:25AM")
    end

    it 'has a viewing party new page with the ability to select users', :vcr do
        user1 = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
        user2 = User.create!(first_name: "James", last_name: "Rock", email:"james@test.com", created_at: Time.now, updated_at: Time.now)
        user3 = User.create!(first_name: "Heidi", last_name: "Hello", email:"heidi@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user1.id}/movies/278/viewing-party/new"

        check(user2.id)
        check(user3.id)
    end

     it 'creates a new viewing party', :vcr do
        user1 = User.create!(first_name: "Homer", last_name: "Simpson", email:"name@test.com", created_at: Time.now, updated_at: Time.now)
        user2 = User.create!(first_name: "James", last_name: "Rock", email:"james@test.com", created_at: Time.now, updated_at: Time.now)
        user3 = User.create!(first_name: "Heidi", last_name: "Hello", email:"heidi@test.com", created_at: Time.now, updated_at: Time.now)
       
        visit "/users/#{user1.id}/movies/278/viewing-party/new"
        
        fill_in("date", with: "2022/10/03")
        fill_in("time", with: "05:25AM")
        check("user_ids_#{user2.id}")
        check("user_ids_#{user3.id}")
        click_button('Create Viewing Party')

        expect(current_path).to eq("/users/#{user1.id}")
    end
end 