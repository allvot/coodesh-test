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

After initializsing the docker environment you should have access to a postgres database and a server running in localhost:3000 in your host machine. No need to further change the .env file or .env file

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


