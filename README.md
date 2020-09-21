# Twitter API

This repository is Ruby on Rails project. It implements some endpoints to simulate a Twitter API.

## Setup
#### Requirements:
* Docker version 19+
* docker-compose version 1.25+

#### Running first time:
1. docker-compose up
2. docker exec -it backend bash
3. rails db:setup
4. rails s -b 0.0.0.0
then application will be available at localhost:3000.

P.S. database will be seeded with 5 users.

## Endpoints
#### Postman docs
https://documenter.getpostman.com/view/2488938/TVKBZeAN

#### GET api/v1/tweets
- Query params:
  1. user_id (required)

- Headers:
  none

- Response:

```
[
    {
        "id": 1,
        "content": "asdasdas",
        "created_at": "2020-09-20T20:48:22.882Z",
        "user": {
            "id": 1,
            "name": "Lesley Gleason",
            "email": "merrill_cummings@larson.com"
        }
    }
]
```
#### POST api/v1/tweets
- Body params:
  1. user_id (required)
  2. content (required)

- Headers:
  none

- Response:

```
{
    "id": 1,
    "content": "asdasdas",
    "created_at": "2020-09-20T20:48:22.882Z",
    "user": {
        "id": 1,
        "name": "Lesley Gleason",
        "email": "merrill_cummings@larson.com"
    }
}
```
#### POST api/v1/users/:user_id/follow
- Url params:
  1. user_id (required)

- Body params:
  1. following_id (required)

- Headers:
  none

- Response:
  201 created

#### DELETE api/v1/users/:user_id/unfollow
- Url params:
  1. user_id (required)

- Body params:
  1. following_id (required)

- Headers:
  none

- Response:
  204 no content


## Database
![Database](https://i.imgur.com/b0Yb2Km.png)
