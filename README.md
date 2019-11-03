# Kinsa
See included PDF.

## Requirements
* Docker
* Docker-compose
* pip
* python 3.7

## Build and Run

### Postgres container
```
$ docker-compose up --build -d
$ docker cp ./init.sql kinsa:/
```
Then run the init.sql. This can be run multiple times to restore the database
```
$ docker exec -it kinsa psql -U masteruser -d template1 -a -f /init.sql
```

### Virtualenv
```
$ python3 -m venv venv
$ source venv/bin/activate
$ pip install -r requirements.txt
```

### Run
FILE_PATH required, password is optional.

```
$ ./perm_man -p kinsa -f sample.json
hostname: localhost, port: 5432

working on database: database_one
    table: events
        user: abe
            current rights:   ['DELETE', 'INSERT', 'REFERENCES', 'SELECT', 'TRIGGER', 'TRUNCATE', 'UPDATE']
            requested rights: ['DELETE', 'INSERT', 'SELECT', 'UPDATE']

        Apply changes (Y/n): y
        Changes applied to 'events' for 'abe'.
```
## JSON file format

```
{
    "host": {
        "name": "localhost",
        "port": 5432
    },
    "databases": [
        {
            "name": "database_one",
            "tables": [
                {
                    "name": "events",
                    "users": [
                        {
                            "name": "abe",
                            "rights": [
                                "UPDATE",
                                "INSERT",
                                "SELECT",
                                "DELETE"
                            ]
                        }
                    ]
                }
            ]
        }
    ]
}
```