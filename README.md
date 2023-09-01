# exp-backoff-to-mitigate-ice
Script for starting an EC2 instance with exponential backoff, repeatedly try within throttling limits to eventually get the instance you need for testing

```
git clone https://github.com/ashivadi/exp-backoff-to-mitigate-ice.git
cd exp-backoff-to-mitigate-ice
chmod +x exp-backoff-to-mitigate-ice.sh 
```

```
./exp-backoff-to-mitigate-ice.sh i-011c0e7**** us-east-1
```