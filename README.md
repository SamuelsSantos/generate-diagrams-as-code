# Docker Diagrams as Code

This is the Git non oficial repo image of the [Diagram as code](https://diagrams.mingrammer.com) that is mainteined for [MinJae Kwon](https://github.com/mingrammer) and all credits are for him that made this greate job.

Usually is hard to install and configure some tools and Docker become to make it easy. So I decide to create this image to try **Diagrams as Code** and shared here.

> Diagrams lets you draw the cloud system architecture in Python code.

## Getting Started

### Requires

 - [Docker](https://www.docker.com/get-started)

### Pull image Diagram as Code

```bash
    docker pull samuelsantos/generate-diagrams-as-code
```

#### Enviroment variables

| Variable     | Default | Description                                                                                                                                                                                                                                       |
| ------------ | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| DIAGRAM_FILE |         | This variable represents the name of the python file that you create to generate a diagram. Remember to define a volume **:/data**, your diagram you be generate inside this volume and your python diagram need to be inside this folder volume. |

### Create a diagram

Original source [Diagrams](https://diagrams.mingrammer.com/docs/getting-started/examples).

> 
```python
# !/diagram.py
# https://diagrams.mingrammer.com/docs/getting-started/examples

from diagrams import Cluster, Diagram
from diagrams.aws.compute import ECS
from diagrams.aws.database import ElastiCache, RDS
from diagrams.aws.network import ELB
from diagrams.aws.network import Route53

with Diagram("Clustered Web Services", show=False):
    dns = Route53("dns")
    lb = ELB("lb")

    with Cluster("Services"):
        svc_group = [ECS("web1"),
                    ECS("web2"),
                    ECS("web3")]

    with Cluster("DB Cluster"):
        db_master = RDS("userdb")
        db_master - [RDS("userdb ro")]

    memcached = ElastiCache("memcached")

    dns >> lb >> svc_group
    svc_group >> db_master
    svc_group >> memcached

```

### Generate diagram throught docker 

Remember your path needs to be shared with docker, 

```bash
|...
├── diagrams
│   └── diagram.py
```

```
    docker run --rm -t -v ./diagrams:/data -e DIAGRAM_FILE=diagram.py --name diagrams generate-diagrams-as-code
```