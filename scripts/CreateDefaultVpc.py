import logging
import boto3
from botocore.exceptions import ClientError

AWS_REGION = "eu-west-1"
ENDPOINT_URL = "http://localstack:4566"

# logger config
logger = logging.getLogger()
logging.basicConfig(
    level=logging.WARN, format="%(asctime)s: %(levelname)s: %(message)s"
)

client = boto3.client("ec2", region_name=AWS_REGION, endpoint_url=ENDPOINT_URL)


def create_default_vpc():
    """
    Creates a default VPC in the configured region.
    """
    try:
        response = client.create_default_vpc()
    except ClientError:
        logger.exception("Could not create default vpc.")
        pass
    else:
        return response["Vpc"]


def check_for_vpc(client):
    """
    Check to see whether default VPC exists
    """
    logger.info("Checking for default VPC...")
    filters = [{"Name": "isDefault", "Values": ["true"]}]
    vpcs = client.describe_vpcs(Filters=filters)["Vpcs"]
    return vpcs[0]


def create_default_vpc_if_not_exist(client):
    check_vpc = check_for_vpc(client)
    if check_vpc:
        logger.info("Has default VPC. Skipping create.")
        logger.info(check_vpc['VpcId'])
        print(check_vpc['VpcId'])
        return

    logger.info("Does not have default VPC. Creating.")
    vpc = create_default_vpc(client)
    logger.info("Created VPC {vpc['VpcId']}")
    print(vpc['VpcId'])


if __name__ == "__main__":
    create_default_vpc_if_not_exist(client)
    sn_all = client.describe_subnets()
    for sn in sn_all['Subnets'] :
        print(sn)
        print(sn['SubnetId'], end='')
        for tag in sn['Tags']:
            if tag['Key'] == 'Name':
                print('\t' + tag['Value'])