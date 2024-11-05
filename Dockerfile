# Use the official Ruby image as a base
FROM ruby:3.1

# Set environment variables
ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV PORT=3000

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /browserchat

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 4 --retry 3

# Copy the rest of the application code
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]
