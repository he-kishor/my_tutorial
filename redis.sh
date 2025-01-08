#!/bin/bash

# Start the Redis container if not already running
CONTAINER_NAME="redis-stack"

# Check if the container exists
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    # Check if the container is running
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container '$CONTAINER_NAME' is already running."
    else
        echo "Starting the stopped container '$CONTAINER_NAME'."
        docker start $CONTAINER_NAME
    fi
else
    echo "Running a new Redis container as '$CONTAINER_NAME'."
    docker run -d --name $CONTAINER_NAME -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
fi

# Execute Redis CLI commands
echo "Executing Redis commands..."
docker exec -it $CONTAINER_NAME redis-cli <<EOF

set name Hemant 
(Set name to Heamnt <= set means update the name key as value heamnt)<= if successfull response would be ok
get name
(Get key name value)
 => valid format and naming convention
 eg. <entity>:<id> value
 id      name          set user:1 Piyush

 set user:2 vishal
 => nx=> create the kye value until the key not already available
set user:2 rahul nx
response nil

mset => in one transaction we can set the multiple key
mset user:3 "rahul"  user:4 "rahul"  user:5 "kahul"
ok

mget
127.0.0.1:6379> mget user:1 user:2 user:4
1) "hemant"
2) "Vishal"
3) "rahul"

cmd increament
127.0.0.1:6379> set count 1
OK
127.0.0.1:6379> incr count
(integer) 2
127.0.0.1:6379> incr count
(integer) 3
127.0.0.1:6379> get count
"3"

one string can only save upto 512MB


EOF
