import logging
import boto3
from botocore.exceptions import ClientError

AWS_REGION = "eu-west-1"
ENDPOINT_URL = "http://localstack:4566"

# logger config
logger = logging.getLogger()
logging.basicConfig(
    level=logging.INFO, format="%(asctime)s: %(levelname)s: %(message)s"
)

vpc_client = boto3.client("ec2", region_name=AWS_REGION, endpoint_url=ENDPOINT_URL)


def create_default_vpc():
    """
    Creates a default VPC in the configured region.
    """
    try:
        response = vpc_client.create_default_vpc()
    except ClientError:
        logger.exception("Could not create default vpc.")
        pass
    else:
        return response['Vpc']


def check_for_vpc(vpc_client):
    """
    Check to see whether default VPC exists
    """
    logger.info("Checking for default VPC...")
    filters = [{'Name': 'isDefault', 'Values': ['true']}]
    vpcs = vpc_client.describe_vpcs(Filters=filters)['Vpcs']
    return len(vpcs) > 0


def create_default_vpc_if_not_exist(vpc_client):
    if check_for_vpc(vpc_client):
        logger.info("Has default VPC. Skipping create.")
        return

    logger.info("Does not have default VPC. Creating.")
    vpc = create_default_vpc(vpc_client)
    logger.info("Created VPC {vpc['VpcId']}")


if __name__ == "__main__":
    create_default_vpc_if_not_exist(vpc_client)