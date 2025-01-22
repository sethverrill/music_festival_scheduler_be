# Music Festival Scheduler - Backend

This repository contains the backend Rails API for the Music Festival Scheduler.

---

### Summary

The backend is responsible for managing users, schedules, and shows. It serves as the data layer for the Music Festival Scheduler application, providing RESTful API endpoints for interaction with the frontend.

---

### Setup Instructions

Install Ruby
Install Rails
Clone the repository: https://github.com/sethverrill/music_festival_scheduler_be.git  
Navigate to the project directory: cd music_festival_scheduler_be.  
Install dependencies using Bundler: bundle install.  
Set up the database:  
- Create the database: rails db:create  
- Run migrations: rails db:migrate  
- Seed the database: rails db:seed  
Start the Rails server: rails s  

---

### Endpoints

#### Users:  
- GET /api/v1/users - Retrieves a list of all users.  
- GET /api/v1/users/:id - Retrieves a specific user and their details.  

#### Schedules:  
- GET /api/v1/users/:user_id/schedule - Retrieves the schedule for a specific user.  
- PATCH /api/v1/users/:user_id/schedule - Updates a user’s schedule to add or remove a show.  

#### Shows:  
- GET /api/v1/shows - Retrieves a list of all shows.  
- GET /api/v1/shows/:id - Retrieves details about a specific show.  
- DELETE /api/v1/shows/:id - Deletes a specific show.

---

### Testing

Run the test suite with bundle exec rspec.
