# Coding Challenge Alvaro Alday

This is a coding challenge for coodesh

## Installation

Generate a .env file

```bash
cp .env.sample .env
```

or by using docker-compose with the following commands

```bash
docker-compose build

# Start containers
docker-compose up
# run as a daemon
docker-compose up -d
# Track the logs
docker-compose logs -f
```

After initializsing the docker environment you should have access to a postgres database and a server running in localhost:3000 in your host machine. No need to further change the .env file

## Running tests

Run the tests from the docker container

```bash
docker-compose exec app rspec
```

## Usage

- You'll have access to an interactive console using `docker-compose exec app bash`
- You can regenerate the database and get new credentials to play around using rails reset
- You can also log into the application simply without
- The application will be running in http://localhost:3000
- Log into the application
- Watch the [instructions video](https://www.loom.com/share/23721e6513754b39baebe01bf89d2869)

## S3 implementation

For S3 implementation it's necessary to be able to test the application in development for ease of development
I'd first instal LocalStack into the docker-compose environment by implementing the following code

```yaml
  localstack:
    image: localstack/localstack:latest
    restart: always
    ports:
      - '4566:4566'
    environment:
      - SERVICES=s3
      - AWS_ACCESS_KEY_ID=test
      - AWS_SECRET_ACCESS_KEY=test
      - AWS_DEFAULT_REGION=us-east-1
    volumes:
      - localstack_data:/tmp/localstack
```

After adding the appropriate values to the .env file like follows:

```
AWS_ACCESS_KEY_ID=test
AWS_SECRET_ACCESS_KEY=test
AWS_DEFAULT_REGION=us-east-1
```

You can also setup the ActiveStorage to use aws s3 with the following configuration:

```Gemfile
gem 'aws-sdk-s3'
```

```ruby
# config/environments/production.rb
config.active_storage.service = :amazon
```

And just like that you can setup your project to upload files directly to s3 with minimal code

# Candidate Feedback & Analysis

I Broke down my process and how I spent my time during this challenge to the HR recruiter, This is what I wrote to her:

**Total time: 6 hours 14 minutes (374 mins excluding the 1 hour break)**

| Phase | Duration | Key Activities |
|-------|----------|----------------|
| Initial Setup | 47m 38s | Docker, environment, readme |
| Testing Setup | 4m 44s | RSpec initialization |
| User System | 14m 55s | User generation and roles |
| API Key System | 54m 49s | Full API key implementation |
| Vaults Feature | 46m 16s | Vaults, documents, permissions |
| Active Storage | 51m 40s | Storage setup and controller tests |
| Code Quality | 41m 34s | Rubocop changes |
| Dinner Break | 1hr | Short rest period for having dinner |
| Bug Fixes & Testing | 1h 39m 20s | Specs, authentication, signup fixes |
| Final Polish | 30m 17s | Final commit + Video recording |


From my perspective **your test is pretty complete** and it covered the following topics:

- **Project Setup**: The ability of the prospect to create a project from scratch including testing framework
- **TDD**: The written requirements of the project included writing tests for the application.
- **DB design & ActiveRecord usage**: Designing and implementing relationships between records of different models
- **Authentication knowledge**: Implementing authentication into the project (My choice was devise)
- **Rails scaffolding**: The ability to generate controllers & views using rails commands automatically
- **RestFul API Knowledge**: Best practices such as serialization and query optimization as well as separations of concerns

In my opinion, **this is a very thorough test** that effectively evaluates multiple important skills. While it *could be completed in under 3 hours*, the current scope presents some challenges that extend the timeline:

- **Project setup overhead**: Starting from scratch requires significant initial configuration time
- **Extended scope**: The comprehensive nature of the test covers many areas, which is valuable but time-intensive
- **Environment dependencies**: Without rbenv or rvm installed locally, I relied on Docker, which added some complexity to the development workflow, a headsup to have a proper rails environment before starting the test would be much apprechiated.

Overall, **this is a well-designed challenge** that provides excellent insight into a candidate's capabilities. My suggestions below are aimed at **making it more achievable within the 3-hour timeframe** while maintaining its educational value and thoroughness.

### Option A Reduce the scope:
- Don't require PostgreSQL, for this type of applications SQLite should be enough
- Produce a bare bones ready to use Rails application
- Provide pre-seeded users in the database, so candidates can focus on API key management rather than building user CRUD from scratch
- Focus on the user being able to implement a RESTFul api for the vaults and documents

### Option B Separate into different tests:
- Test 1 - Rails and Setup CRUD (3 hours duration):
  - Start a rails project from scratch to setup a rails application until it works
  - Create a CRUD for 1 or 2 models with simple devise authentication
  - Use PostgreSQL
- Test 2 - RESTful API Development (3 hours duration):
  - Use a pre-configured Rails application (provided)
  - Implement API token authentication
  - Build a RESTful API for 1-2 models with proper serialization
  - Fix broken specs and ensure all tests pass
  - SQLite database (faster setup)
